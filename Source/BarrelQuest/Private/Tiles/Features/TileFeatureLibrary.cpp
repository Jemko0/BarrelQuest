// 


#include "Tiles/Features/TileFeatureLibrary.h"

#include "Json.h"
#include "JsonObjectConverter.h"

namespace
{
const FString ExportTextRuntimeDataPrefix = TEXT("__exporttext:");

FName GetFeatureRuntimeDataKey(UObject* FeatureObject, FName FeatureNamespace, const FProperty* Property)
{
	const FString NamespaceString = FeatureNamespace.IsNone() && FeatureObject
		? FeatureObject->GetClass()->GetName()
		: FeatureNamespace.ToString();

	return FName(*FString::Printf(
		TEXT("__feature.%s.%s"),
		*NamespaceString,
		*Property->GetAuthoredName()));
}

bool JsonValueToString(const TSharedPtr<FJsonValue>& JsonValue, FString& OutString)
{
	if (!JsonValue.IsValid())
	{
		return false;
	}

	TSharedRef<TJsonWriter<>> Writer = TJsonWriterFactory<>::Create(&OutString);
	return FJsonSerializer::Serialize(JsonValue, TEXT(""), Writer);
}

bool PropertyToRuntimeDataString(FProperty* Property, const void* PropertyValue, FString& OutString)
{
	TSharedPtr<FJsonValue> JsonValue = FJsonObjectConverter::UPropertyToJsonValue(
		Property,
		PropertyValue,
		0,
		CPF_Transient);

	if (JsonValue.IsValid())
	{
		if (JsonValueToString(JsonValue, OutString))
		{
			return true;
		}
	}

	FString ExportedValue;
	Property->ExportTextItem_Direct(ExportedValue, PropertyValue, nullptr, nullptr, PPF_None);
	OutString = ExportTextRuntimeDataPrefix + ExportedValue;
	return true;
}

bool StringToJsonValue(const FString& String, TSharedPtr<FJsonValue>& OutValue)
{
	TSharedRef<TJsonReader<>> Reader = TJsonReaderFactory<>::Create(String);
	return FJsonSerializer::Deserialize(Reader, OutValue) && OutValue.IsValid();
}

bool TryGetRuntimeDataValueSilently(const FTileRuntimeData& RuntimeData, FName Key, FString& OutValue)
{
	for (const FString& Entry : RuntimeData.Values())
	{
		FString EntryKey;
		FString EntryValue;
		if (Entry.Split(TEXT("="), &EntryKey, &EntryValue) && FName(*EntryKey) == Key)
		{
			OutValue = MoveTemp(EntryValue);
			return true;
		}
	}

	return false;
}
}

void UTileFeatureLibrary::SerializeFeatureRuntimeData(
	UObject* FeatureObject,
	FName FeatureNamespace,
	FTileRuntimeData& RuntimeData)
{
	if (!FeatureObject)
	{
		return;
	}

	for (TFieldIterator<FProperty> PropertyIt(FeatureObject->GetClass(), EFieldIteratorFlags::IncludeSuper); PropertyIt; ++PropertyIt)
	{
		FProperty* Property = *PropertyIt;
		if (!Property || !Property->HasAnyPropertyFlags(CPF_SaveGame))
		{
			continue;
		}

		FString JsonString;
		const void* PropertyValue = Property->ContainerPtrToValuePtr<void>(FeatureObject);
		if (!PropertyToRuntimeDataString(Property, PropertyValue, JsonString))
		{
			UE_LOG(LogBarrelQuest, Warning, TEXT("SerializeFeatureRuntimeData: Could not serialize property '%s' on '%s'."),
				*Property->GetAuthoredName(),
				*FeatureObject->GetName());
			continue;
		}

		const FName RuntimeDataKey = GetFeatureRuntimeDataKey(FeatureObject, FeatureNamespace, Property);
		RuntimeData.SetValue(RuntimeDataKey, JsonString);
		UE_LOG(LogBarrelQuest, Verbose, TEXT("SerializeFeatureRuntimeData: Saved property '%s' on '%s' to runtime key '%s'."),
			*Property->GetAuthoredName(),
			*FeatureObject->GetName(),
			*RuntimeDataKey.ToString());
	}
}

void UTileFeatureLibrary::DeserializeFeatureRuntimeData(
	UObject* FeatureObject,
	FName FeatureNamespace,
	const FTileRuntimeData& RuntimeData)
{
	if (!FeatureObject)
	{
		return;
	}

	for (TFieldIterator<FProperty> PropertyIt(FeatureObject->GetClass(), EFieldIteratorFlags::IncludeSuper); PropertyIt; ++PropertyIt)
	{
		FProperty* Property = *PropertyIt;
		if (!Property || !Property->HasAnyPropertyFlags(CPF_SaveGame))
		{
			continue;
		}

		FString JsonString;
		if (!TryGetRuntimeDataValueSilently(RuntimeData, GetFeatureRuntimeDataKey(FeatureObject, FeatureNamespace, Property), JsonString))
		{
			UE_LOG(LogBarrelQuest, Verbose, TEXT("DeserializeFeatureRuntimeData: No saved value for property '%s' on '%s' with namespace '%s'."),
				*Property->GetAuthoredName(),
				*FeatureObject->GetName(),
				*FeatureNamespace.ToString());
			continue;
		}

		TSharedPtr<FJsonValue> JsonValue;
		if (JsonString.RemoveFromStart(ExportTextRuntimeDataPrefix))
		{
			void* PropertyValue = Property->ContainerPtrToValuePtr<void>(FeatureObject);
			Property->ImportText_Direct(*JsonString, PropertyValue, FeatureObject, PPF_None);
			continue;
		}

		if (!StringToJsonValue(JsonString, JsonValue))
		{
			UE_LOG(LogBarrelQuest, Warning, TEXT("DeserializeFeatureRuntimeData: Could not parse JSON for property '%s' on '%s'."),
				*Property->GetAuthoredName(),
				*FeatureObject->GetName());
			continue;
		}

		void* PropertyValue = Property->ContainerPtrToValuePtr<void>(FeatureObject);
		FText FailReason;
		if (!FJsonObjectConverter::JsonValueToUProperty(
			JsonValue,
			Property,
			PropertyValue,
			0,
			CPF_Transient,
			false,
			&FailReason))
		{
			UE_LOG(LogBarrelQuest, Warning, TEXT("DeserializeFeatureRuntimeData: Could not assign property '%s' on '%s'. Reason='%s'"),
				*Property->GetAuthoredName(),
				*FeatureObject->GetName(),
				*FailReason.ToString());

			if (JsonValue->Type == EJson::String)
			{
				const FString StringValue = JsonValue->AsString();
				Property->ImportText_Direct(*StringValue, PropertyValue, FeatureObject, PPF_None);
			}
		}
	}
}
