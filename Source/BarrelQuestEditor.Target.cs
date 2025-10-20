// Fill out your copyright notice in the Description page of Project Settings.

using UnrealBuildTool;
using System.Collections.Generic;

public class BarrelQuestEditorTarget : TargetRules
{
	public BarrelQuestEditorTarget(TargetInfo Target) : base(Target)
	{
		Type = TargetType.Editor;
		DefaultBuildSettings = BuildSettingsVersion.V5;
		CppStandard = CppStandardVersion.Cpp20;
		ExtraModuleNames.AddRange( new string[] { "BarrelQuest" } );
	}
}
