

#pragma once

#include "CoreMinimal.h"
#include "Kismet/BlueprintFunctionLibrary.h"
#include "BarrelUtilityFunctionLibrary.generated.h"

/**
 * 
 */
USTRUCT(BlueprintType)
struct FLuaStructField
{
	GENERATED_BODY()
	
	FString Name;
	FString DisplayName;
	FString Type;
	FString CleanName;
};

UCLASS()
class BARRELQUEST_API UBarrelUtilityFunctionLibrary : public UBlueprintFunctionLibrary
{
	GENERATED_BODY()

public:
	UFUNCTION(BlueprintCallable, BlueprintPure)
	static FLinearColor HexStringToLinearColor(FString hexString);
	
	UFUNCTION(BlueprintCallable, BlueprintPure)
	static FString LinearColorToHexString(const FLinearColor& color);
	
	UFUNCTION(BlueprintCallable)
	static void GenerateAssetPathFile();

	UFUNCTION(BlueprintCallable)
	static void GenerateLuaMetaFileFromClass(UClass* InClass, bool suppressWarnings);
	
	UFUNCTION(BlueprintCallable)
	static void GenerateLuaMetaFilesRecursive(UClass* InClass, bool suppressWarnings);
	
	static FString GenerateDelegateTypeDefinition(FMulticastDelegateProperty* DelegateProperty);

	UFUNCTION(BlueprintCallable)
	static void GenerateBaseMetaFiles(bool suppressWarnings);
	
	UFUNCTION(BlueprintCallable)
	static UClass* GetClassFromBlueprintPackage(FString PackagePath);
	
	static FString GetLuaTypeFromProperty(FProperty* Property);
	static bool IsValidLuaIdentifier(const FString& Name);
	static FString SanitizeLuaIdentifier(const FString& Name);
	
	static FString GetLuaMetaOutputDirectory();
	static void SetLuaMetaOutputDirectory(const FString& RelativePath);

	static void GenerateLuaMetaFileFromStruct(UStruct* InStruct, bool suppressWarnings);
	static void CollectReferencedTypes(UClass* InClass, TSet<UStruct*>& OutStructs, TSet<UClass*>& OutClasses);
	
	UFUNCTION(BlueprintCallable)
	static void GenerateStructWrapper(
	const FString& StructName,
	const TArray<FLuaStructField>& Fields,
	const TMap<FString, FString>& FieldMappings,
	const TMap<FString, FString>& FieldTypes,
	const FString& OutputDir);
};
