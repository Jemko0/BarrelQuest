// Fill out your copyright notice in the Description page of Project Settings.

using UnrealBuildTool;

public class BarrelQuest : ModuleRules
{
	public BarrelQuest(ReadOnlyTargetRules Target) : base(Target)
	{
		PCHUsage = PCHUsageMode.UseExplicitOrSharedPCHs;

		PublicDependencyModuleNames.AddRange(new string[]
		{
			"Core",
			"CoreUObject",
			"Engine",
			"InputCore",
			"ProceduralMeshComponent",
			"Slate",
			"SlateCore",
			"ApplicationCore",
			"HTTP",
			"Json",
			"JsonUtilities",
			"MeshDescription",
			"StaticMeshDescription",
			"RenderCore",
			"RHI",
			"VorbisAudioDecoder",
		});

		PrivateDependencyModuleNames.AddRange(new string[] { "Slate", "SlateCore" });

		if (Target.Platform == UnrealTargetPlatform.Win64)
		{
			PublicSystemLibraries.Add("winmm.lib");
		}

		// Uncomment if you are using online features
		// PrivateDependencyModuleNames.Add("OnlineSubsystem");

		// To include OnlineSubsystemSteam, add it to the plugins section in your uproject file with the Enabled attribute set to true
	}
}
