#pragma once

#include "CoreMinimal.h"
#include "Kismet/BlueprintFunctionLibrary.h"
#include "BarrelFileUtilityFunctionLibrary.generated.h"

/**
 * 
 */
UCLASS()
class BARRELQUEST_API UBarrelFileUtilityFunctionLibrary : public UBlueprintFunctionLibrary
{
	GENERATED_BODY()
    
public:
	/**
	 * Gets all subdirectories within a directory
	 * @param DirectoryPath - The directory path to search
	 * @param bIncludeFullPath - If true, returns full paths. If false, returns just directory names
	 * @return Array of directory paths/names found
	 */
	UFUNCTION(BlueprintCallable, Category = "File Utility")
	static TArray<FString> GetDirectoriesInDirectory(const FString& DirectoryPath, bool bIncludeFullPath = true);
    
};