// 


#include "RuntimeImporters/BarrelRuntimeMIDI.h"

#include "BarrelUtilityLibrary.h"
#include "HAL/Runnable.h"
#include "HAL/RunnableThread.h"
#include "HAL/ThreadSafeBool.h"
#include "Misc/ScopeLock.h"

#if PLATFORM_WINDOWS
#include "Windows/AllowWindowsPlatformTypes.h"
#include <mmsystem.h>
#include "Windows/HideWindowsPlatformTypes.h"
#endif

namespace
{
	struct FRuntimeMIDIEvent
	{
		double TimeSeconds = 0.0;
		uint8 Status = 0;
		uint8 Data0 = 0;
		uint8 Data1 = 0;
	};

	struct FTempoChange
	{
		uint64 Tick = 0;
		int32 MicrosecondsPerQuarter = 500000;
	};

	bool ReadBE16(const TArray<uint8>& Data, int32& Offset, uint16& OutValue)
	{
		if (Offset + 2 > Data.Num())
		{
			return false;
		}

		OutValue = (static_cast<uint16>(Data[Offset]) << 8)
			| static_cast<uint16>(Data[Offset + 1]);
		Offset += 2;
		return true;
	}

	bool ReadBE32(const TArray<uint8>& Data, int32& Offset, uint32& OutValue)
	{
		if (Offset + 4 > Data.Num())
		{
			return false;
		}

		OutValue = (static_cast<uint32>(Data[Offset]) << 24)
			| (static_cast<uint32>(Data[Offset + 1]) << 16)
			| (static_cast<uint32>(Data[Offset + 2]) << 8)
			| static_cast<uint32>(Data[Offset + 3]);
		Offset += 4;
		return true;
	}

	bool ReadVLQ(const TArray<uint8>& Data, int32& Offset, int32 EndOffset, uint32& OutValue)
	{
		OutValue = 0;
		for (int32 i = 0; i < 4; ++i)
		{
			if (Offset >= EndOffset)
			{
				return false;
			}

			const uint8 Byte = Data[Offset++];
			OutValue = (OutValue << 7) | (Byte & 0x7f);
			if ((Byte & 0x80) == 0)
			{
				return true;
			}
		}

		return false;
	}

	bool SkipBytes(int32& Offset, int32 EndOffset, uint32 Count)
	{
		if (Count > static_cast<uint32>(EndOffset - Offset))
		{
			return false;
		}

		Offset += static_cast<int32>(Count);
		return true;
	}

	double TicksToSeconds(uint64 TargetTick, int32 TicksPerQuarter, const TArray<FTempoChange>& TempoMap)
	{
		double Seconds = 0.0;
		uint64 LastTick = 0;
		int32 CurrentTempo = 500000;

		for (const FTempoChange& Tempo : TempoMap)
		{
			if (Tempo.Tick > TargetTick)
			{
				break;
			}

			const uint64 DeltaTicks = Tempo.Tick - LastTick;
			Seconds += (static_cast<double>(DeltaTicks) * static_cast<double>(CurrentTempo))
				/ (1000000.0 * static_cast<double>(TicksPerQuarter));
			LastTick = Tempo.Tick;
			CurrentTempo = Tempo.MicrosecondsPerQuarter;
		}

		if (TargetTick > LastTick)
		{
			const uint64 DeltaTicks = TargetTick - LastTick;
			Seconds += (static_cast<double>(DeltaTicks) * static_cast<double>(CurrentTempo))
				/ (1000000.0 * static_cast<double>(TicksPerQuarter));
		}

		return Seconds;
	}

	bool ParseRuntimeMIDI(const TArray<uint8>& RawBytes, TArray<FRuntimeMIDIEvent>& OutEvents, double& OutDurationSeconds)
	{
		OutEvents.Empty();
		OutDurationSeconds = 0.0;

		if (RawBytes.Num() < 14 || FMemory::Memcmp(RawBytes.GetData(), "MThd", 4) != 0)
		{
			UE_LOG(LogBarrelQuest, Warning, TEXT("MIDI: Invalid file. Missing MThd header."));
			return false;
		}

		int32 Offset = 4;
		uint32 HeaderLength = 0;
		uint16 Format = 0;
		uint16 NumTracks = 0;
		uint16 Division = 0;
		if (!ReadBE32(RawBytes, Offset, HeaderLength)
			|| HeaderLength < 6
			|| !ReadBE16(RawBytes, Offset, Format)
			|| !ReadBE16(RawBytes, Offset, NumTracks)
			|| !ReadBE16(RawBytes, Offset, Division))
		{
			UE_LOG(LogBarrelQuest, Warning, TEXT("MIDI: Failed to parse MThd."));
			return false;
		}

		if ((Division & 0x8000) != 0)
		{
			UE_LOG(LogBarrelQuest, Warning, TEXT("MIDI: SMPTE timing is not supported."));
			return false;
		}

		const int32 TicksPerQuarter = Division;
		if (TicksPerQuarter <= 0)
		{
			UE_LOG(LogBarrelQuest, Warning, TEXT("MIDI: Invalid ticks-per-quarter value."));
			return false;
		}

		Offset = 8 + static_cast<int32>(HeaderLength);

		struct FRawTrackEvent
		{
			uint64 Tick = 0;
			uint8 Status = 0;
			uint8 Data0 = 0;
			uint8 Data1 = 0;
		};

		TArray<FRawTrackEvent> RawEvents;
		TArray<FTempoChange> TempoMap;
		TempoMap.Add({0, 500000});

		for (uint16 TrackIndex = 0; TrackIndex < NumTracks; ++TrackIndex)
		{
			if (Offset + 8 > RawBytes.Num() || FMemory::Memcmp(RawBytes.GetData() + Offset, "MTrk", 4) != 0)
			{
				UE_LOG(LogBarrelQuest, Warning, TEXT("MIDI: Missing MTrk header for track %u."), TrackIndex);
				return false;
			}

			Offset += 4;
			uint32 TrackLength = 0;
			if (!ReadBE32(RawBytes, Offset, TrackLength))
			{
				return false;
			}

			const int32 TrackEnd = Offset + static_cast<int32>(TrackLength);
			if (TrackEnd < Offset || TrackEnd > RawBytes.Num())
			{
				UE_LOG(LogBarrelQuest, Warning, TEXT("MIDI: Invalid track length for track %u."), TrackIndex);
				return false;
			}

			uint64 AbsoluteTick = 0;
			uint8 RunningStatus = 0;

			while (Offset < TrackEnd)
			{
				uint32 DeltaTicks = 0;
				if (!ReadVLQ(RawBytes, Offset, TrackEnd, DeltaTicks))
				{
					return false;
				}

				AbsoluteTick += DeltaTicks;
				if (Offset >= TrackEnd)
				{
					return false;
				}

				uint8 Status = RawBytes[Offset++];
				if (Status < 0x80)
				{
					if (RunningStatus == 0)
					{
						UE_LOG(LogBarrelQuest, Warning, TEXT("MIDI: Running status without previous status."));
						return false;
					}

					--Offset;
					Status = RunningStatus;
				}
				else if (Status < 0xf0)
				{
					RunningStatus = Status;
				}

				if (Status == 0xff)
				{
					if (Offset >= TrackEnd)
					{
						return false;
					}

					const uint8 MetaType = RawBytes[Offset++];
					uint32 MetaLength = 0;
					if (!ReadVLQ(RawBytes, Offset, TrackEnd, MetaLength))
					{
						return false;
					}

					if (MetaLength > static_cast<uint32>(TrackEnd - Offset))
					{
						return false;
					}

					if (MetaType == 0x2f)
					{
						Offset += static_cast<int32>(MetaLength);
						break;
					}

					if (MetaType == 0x51 && MetaLength == 3)
					{
						const int32 Tempo =
							(static_cast<int32>(RawBytes[Offset]) << 16)
							| (static_cast<int32>(RawBytes[Offset + 1]) << 8)
							| static_cast<int32>(RawBytes[Offset + 2]);
						TempoMap.Add({AbsoluteTick, Tempo});
					}

					Offset += static_cast<int32>(MetaLength);
					continue;
				}

				if (Status == 0xf0 || Status == 0xf7)
				{
					uint32 SysExLength = 0;
					if (!ReadVLQ(RawBytes, Offset, TrackEnd, SysExLength) || !SkipBytes(Offset, TrackEnd, SysExLength))
					{
						return false;
					}
					continue;
				}

				const uint8 Command = Status & 0xf0;
				const bool bOneDataByte = Command == 0xc0 || Command == 0xd0;
				const int32 DataBytes = bOneDataByte ? 1 : 2;
				if (Offset + DataBytes > TrackEnd)
				{
					return false;
				}

				const uint8 Data0 = RawBytes[Offset++];
				const uint8 Data1 = bOneDataByte ? 0 : RawBytes[Offset++];

				if (Command >= 0x80 && Command <= 0xe0)
				{
					RawEvents.Add({AbsoluteTick, Status, Data0, Data1});
				}
			}

			Offset = TrackEnd;
		}

		TempoMap.Sort([](const FTempoChange& A, const FTempoChange& B)
		{
			return A.Tick < B.Tick;
		});

		RawEvents.Sort([](const FRawTrackEvent& A, const FRawTrackEvent& B)
		{
			return A.Tick < B.Tick;
		});

		uint64 LastTick = 0;
		for (const FRawTrackEvent& RawEvent : RawEvents)
		{
			FRuntimeMIDIEvent Event;
			Event.TimeSeconds = TicksToSeconds(RawEvent.Tick, TicksPerQuarter, TempoMap);
			Event.Status = RawEvent.Status;
			Event.Data0 = RawEvent.Data0;
			Event.Data1 = RawEvent.Data1;
			OutEvents.Add(Event);
			LastTick = FMath::Max(LastTick, RawEvent.Tick);
		}

		// Snap LastTick up to the next beat boundary
		const uint64 TicksPerBeat = static_cast<uint64>(TicksPerQuarter);
		const uint64 SnappedTick = ((LastTick + TicksPerBeat - 1) / TicksPerBeat) * TicksPerBeat;
		OutDurationSeconds = TicksToSeconds(SnappedTick, TicksPerQuarter, TempoMap);

		if (OutEvents.Num() == 0)
		{
			UE_LOG(LogBarrelQuest, Warning, TEXT("MIDI: Parsed file but found no playable MIDI channel events. Format=%u Tracks=%u"), Format, NumTracks);
			return false;
		}

		UE_LOG(LogBarrelQuest, Log, TEXT("MIDI: Parsed %d MIDI events across %u tracks, duration %.2fs."), OutEvents.Num(), NumTracks, OutDurationSeconds);
		return true;
	}

	void SendAllNotesOff(void* MIDIHandle)
	{
#if PLATFORM_WINDOWS
		HMIDIOUT Handle = static_cast<HMIDIOUT>(MIDIHandle);
		if (!Handle)
		{
			return;
		}

		for (uint8 Channel = 0; Channel < 16; ++Channel)
		{
			const DWORD ControlAllNotesOff = (0xb0 | Channel) | (123 << 8);
			const DWORD ControlAllSoundOff = (0xb0 | Channel) | (120 << 8);
			midiOutShortMsg(Handle, ControlAllNotesOff);
			midiOutShortMsg(Handle, ControlAllSoundOff);
		}
#endif
	}

	class FRuntimeMIDIPlaybackWorker final : public FRunnable
	{
	public:
		FRuntimeMIDIPlaybackWorker(TArray<FRuntimeMIDIEvent>&& InEvents, double InDurationSeconds, FBarrelRuntimeMIDISettings InSettings)
			: Events(MoveTemp(InEvents))
			, DurationSeconds(InDurationSeconds)
			, Settings(InSettings)
		{
		}

		virtual uint32 Run() override
		{
			UE_LOG(LogBarrelQuest, Warning, TEXT("MIDI: DurationSeconds: %f"), DurationSeconds);
			
#if PLATFORM_WINDOWS
			HMIDIOUT MIDIOut = nullptr;
			if (midiOutOpen(&MIDIOut, MIDI_MAPPER, 0, 0, CALLBACK_NULL) != MMSYSERR_NOERROR)
			{
				UE_LOG(LogBarrelQuest, Warning, TEXT("MIDI: Failed to open default Windows MIDI output device."));
				bPlaying = false;
				return 0;
			}

			do
			{
				const double StartSeconds = FPlatformTime::Seconds();
				for (const FRuntimeMIDIEvent& Event : Events)
				{
					if (bStopRequested)
					{
						break;
					}

					const double Target = StartSeconds + (Event.TimeSeconds / FMath::Max(Settings.PlaybackSpeed, 0.1f));
					while (!bStopRequested)
					{
						const double Remaining = Target - FPlatformTime::Seconds();
						if (Remaining <= 0.0)
						{
							break;
						}

						FPlatformProcess::Sleep(FMath::Min(0.01f, static_cast<float>(Remaining)));
					}

					if (bStopRequested)
					{
						break;
					}

					const DWORD Message = static_cast<DWORD>(Event.Status)
						| (static_cast<DWORD>(Event.Data0) << 8)
						| (static_cast<DWORD>(GetScaledVelocity(Event)) << 16);
					midiOutShortMsg(MIDIOut, Message);
				}

				//SendAllNotesOff(MIDIOut); test
			} while (!bStopRequested && Settings.bLooping);

			SendAllNotesOff(MIDIOut);
			midiOutReset(MIDIOut);
			midiOutClose(MIDIOut);
#else
			UE_LOG(LogBarrelQuest, Warning, TEXT("MIDI: Runtime OS MIDI playback is currently implemented only for Windows."));
#endif
			bPlaying = false;
			return 0;
		}

		virtual void Stop() override
		{
			bStopRequested = true;
		}

		bool IsPlaying() const
		{
			return bPlaying && !bStopRequested;
		}

	private:
		uint8 GetScaledVelocity(const FRuntimeMIDIEvent& Event) const
		{
			const uint8 Command = Event.Status & 0xf0;
			if (Command != 0x90 || Event.Data1 == 0)
			{
				return Event.Data1;
			}

			const float Volume = FMath::Clamp(Settings.Volume, 0.0f, 1.0f);
			return static_cast<uint8>(FMath::Clamp(FMath::RoundToInt(static_cast<float>(Event.Data1) * Volume), 0, 127));
		}

		TArray<FRuntimeMIDIEvent> Events;
		double DurationSeconds = 0.0;
		FBarrelRuntimeMIDISettings Settings;
		FThreadSafeBool bStopRequested = false;
		FThreadSafeBool bPlaying = true;
	};

	FCriticalSection PlaybackLock;
	TUniquePtr<FRuntimeMIDIPlaybackWorker> ActiveWorker;
	FRunnableThread* ActiveThread = nullptr;

	void StopActiveMIDIPlayback()
	{
		FRunnableThread* ThreadToDestroy = nullptr;
		{
			FScopeLock Lock(&PlaybackLock);
			if (ActiveWorker)
			{
				ActiveWorker->Stop();
			}
			ThreadToDestroy = ActiveThread;
			ActiveThread = nullptr;
		}

		if (ThreadToDestroy)
		{
			ThreadToDestroy->WaitForCompletion();
			delete ThreadToDestroy;
		}

		FScopeLock Lock(&PlaybackLock);
		ActiveWorker.Reset();
	}
}

bool UBarrelRuntimeMIDI::PlayMIDIFromBytes(const TArray<uint8>& RawBytes, const FBarrelRuntimeMIDISettings& Settings)
{
	TArray<FRuntimeMIDIEvent> Events;
	double DurationSeconds = 0.0;
	if (!ParseRuntimeMIDI(RawBytes, Events, DurationSeconds))
	{
		return false;
	}

	StopActiveMIDIPlayback();

	TUniquePtr<FRuntimeMIDIPlaybackWorker> NewWorker = MakeUnique<FRuntimeMIDIPlaybackWorker>(MoveTemp(Events), DurationSeconds, Settings);
	FRunnableThread* NewThread = FRunnableThread::Create(NewWorker.Get(), TEXT("BarrelRuntimeMIDIPlayback"));
	if (!NewThread)
	{
		UE_LOG(LogBarrelQuest, Warning, TEXT("MIDI: Failed to create playback thread."));
		return false;
	}

	FScopeLock Lock(&PlaybackLock);
	ActiveWorker = MoveTemp(NewWorker);
	ActiveThread = NewThread;
	return true;
}

void UBarrelRuntimeMIDI::StopMIDI()
{
	StopActiveMIDIPlayback();
}

bool UBarrelRuntimeMIDI::IsMIDIPlaying()
{
	FScopeLock Lock(&PlaybackLock);
	return ActiveWorker && ActiveWorker->IsPlaying();
}
