// Fill out your copyright notice in the Description page of Project Settings.

using UnrealBuildTool;
using System.Collections.Generic;

public class BarrelQuestTarget : TargetRules
{
	public BarrelQuestTarget(TargetInfo Target) : base(Target)
	{
		Type = TargetType.Game;
		DefaultBuildSettings = BuildSettingsVersion.V2;
		bOverrideBuildEnvironment = true;
		CppStandard = CppStandardVersion.Cpp20;

		ExtraModuleNames.AddRange(new string[] { "BarrelQuest" });
		DefaultWarningLevel = WarningLevel.Warning;
		bWarningsAsErrors = false;
	}
}
