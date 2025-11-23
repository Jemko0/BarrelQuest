#include "Utility/BarrelFileUtilityFunctionLibrary.h"
#include "HAL/PlatformFileManager.h"
#include "GenericPlatform/GenericPlatformFile.h"

TArray<FString> UBarrelFileUtilityFunctionLibrary::GetDirectoriesInDirectory(const FString& DirectoryPath, bool bIncludeFullPath)
{
    TArray<FString> Directories;
    
    IPlatformFile& PlatformFile = FPlatformFileManager::Get().GetPlatformFile();
    
    if (!PlatformFile.DirectoryExists(*DirectoryPath))
    {
        UE_LOG(LogTemp, Warning, TEXT("Directory does not exist: %s"), *DirectoryPath);
        return Directories;
    }
    
    class FDirectoryVisitor : public IPlatformFile::FDirectoryVisitor
    {
    public:
        TArray<FString>& DirectoriesArray;
        bool bFullPath;
        
        FDirectoryVisitor(TArray<FString>& InDirectories, bool InFullPath)
            : DirectoriesArray(InDirectories), bFullPath(InFullPath)
        {
        }
        
        virtual bool Visit(const TCHAR* FilenameOrDirectory, bool bIsDirectory) override
        {
            if (bIsDirectory)
            {
                FString DirPath(FilenameOrDirectory);
                
                if (bFullPath)
                {
                    DirectoriesArray.Add(DirPath);
                }
                else
                {
                    FString DirName = FPaths::GetCleanFilename(DirPath);
                    DirectoriesArray.Add(DirName);
                }
            }
            return true;
        }
    };
    
    FDirectoryVisitor Visitor(Directories, bIncludeFullPath);
    PlatformFile.IterateDirectory(*DirectoryPath, Visitor);
    
    return Directories;
}