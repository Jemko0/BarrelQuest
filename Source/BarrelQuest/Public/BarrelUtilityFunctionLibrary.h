

#pragma once

#include "CoreMinimal.h"
#include "Kismet/BlueprintFunctionLibrary.h"
#include "BarrelUtilityFunctionLibrary.generated.h"

/**
 * 
 */
UCLASS()
class BARRELQUEST_API UBarrelUtilityFunctionLibrary : public UBlueprintFunctionLibrary
{
	GENERATED_BODY()

public:
	UFUNCTION(BlueprintCallable, BlueprintPure)
	static FLinearColor HexStringToLinearColor(FString hexString);

	UFUNCTION(BlueprintCallable)
	static void GenerateLuaMetaFileFromClass(UClass* InClass);
	
	UFUNCTION(BlueprintCallable)
	static void GenerateLuaMetaFilesRecursive(UClass* InClass);
	
	static FString GetLuaTypeFromProperty(FProperty* Property);
	static bool IsValidLuaIdentifier(const FString& Name);
	static FString SanitizeLuaIdentifier(const FString& Name);
	
	static FString GetLuaMetaOutputDirectory();
	static void SetLuaMetaOutputDirectory(const FString& RelativePath);

	static void GenerateLuaMetaFileFromStruct(UStruct* InStruct);
	static void CollectReferencedTypes(UClass* InClass, TSet<UStruct*>& OutStructs, TSet<UClass*>& OutClasses);
};
