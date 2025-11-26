#include "BarrelUtilityFunctionLibrary.h"
#include "UObject/Class.h"
#include "UObject/UnrealType.h"
#include "Misc/FileHelper.h"
#include "Misc/Paths.h"
#include "HAL/PlatformFileManager.h"

FLinearColor UBarrelUtilityFunctionLibrary::HexStringToLinearColor(FString hexString)
{
    // Your existing implementation
    return FLinearColor();
}

FString UBarrelUtilityFunctionLibrary::GetLuaMetaOutputDirectory()
{
    static FString MetaOutputDir = TEXT("Lua/API");
    return MetaOutputDir;
}

void UBarrelUtilityFunctionLibrary::SetLuaMetaOutputDirectory(const FString& RelativePath)
{
    static FString MetaOutputDir = TEXT("Lua/API");
    MetaOutputDir = RelativePath;
    UE_LOG(LogTemp, Log, TEXT("Lua meta output directory set to: %s"), *RelativePath);
}

void UBarrelUtilityFunctionLibrary::GenerateLuaMetaFileFromClass(UClass* InClass, bool suppressWarnings)
{
    GenerateBaseMetaFiles(suppressWarnings);
    
    if (!InClass)
    {
        UE_LOG(LogTemp, Error, TEXT("GenerateLuaMetaFileFromClass: Invalid class provided"));
        return;
    }

    FString ClassName = InClass->GetName();
    FString LuaMetaContent;

    // Check if this is a Blueprint Interface
    bool bIsInterface = InClass->HasAnyClassFlags(CLASS_Interface);

    // Start with class declaration
    LuaMetaContent += FString::Printf(TEXT("---@meta\n\n"));
    LuaMetaContent += FString::Printf(TEXT("--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.\n"));
    LuaMetaContent += FString::Printf(TEXT("--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.\n"));
    LuaMetaContent += FString::Printf(TEXT("--- Access these using bracket notation: object[\"Apply Damage\"]\n\n"));
    
    if (suppressWarnings)
    {
        LuaMetaContent += FString::Printf(TEXT("---@diagnostic disable: undefined-doc-name\n"));
    }
    
    if (bIsInterface)
    {
        LuaMetaContent += FString::Printf(TEXT("---@class %s : UInterface\n"), *ClassName);
    }
    else
    {
        LuaMetaContent += FString::Printf(TEXT("---@class %s"), *ClassName);
        
        // Add parent class if exists
        UClass* ParentClass = InClass->GetSuperClass();
        if (ParentClass && ParentClass != UObject::StaticClass())
        {
            LuaMetaContent += FString::Printf(TEXT(" : %s"), *ParentClass->GetName());
        }
        LuaMetaContent += TEXT("\n");
    }

    // Document class description if available
    FString ClassTooltip = InClass->GetToolTipText().ToString();
    if (!ClassTooltip.IsEmpty())
    {
        // Split tooltip into lines and prefix each with ---
        TArray<FString> TooltipLines;
        ClassTooltip.ParseIntoArray(TooltipLines, TEXT("\n"), true);
        for (const FString& Line : TooltipLines)
        {
            LuaMetaContent += FString::Printf(TEXT("---%s\n"), *Line);
        }
    }

    // Skip properties for interfaces - they only have function declarations
    if (!bIsInterface)
    {
        // Generate fields/properties
        LuaMetaContent += TEXT("---\n--- Properties\n");
        for (TFieldIterator<FProperty> PropIt(InClass, EFieldIteratorFlags::ExcludeSuper); PropIt; ++PropIt)
        {
            FProperty* Property = *PropIt;
            
            // Skip private properties
            if (Property->HasAnyPropertyFlags(CPF_NativeAccessSpecifierPrivate))
            {
                continue;
            }

            FString PropName = Property->GetName();
            FString PropNameDisplay = PropName;
            
            // Replace spaces with underscores for valid Lua identifier
            PropNameDisplay.ReplaceInline(TEXT(" "), TEXT("_"));
            
            FString LuaType = GetLuaTypeFromProperty(Property);
            
            // Add property documentation
            FString PropTooltip = Property->GetToolTipText().ToString();
            if (!PropTooltip.IsEmpty())
            {
                // Split tooltip into lines and prefix each with ---
                TArray<FString> TooltipLines;
                PropTooltip.ParseIntoArray(TooltipLines, TEXT("\n"), true);
                
                // Check if first line is @deprecated
                bool bStartsWithDeprecated = false;
                if (TooltipLines.Num() > 0)
                {
                    FString FirstLine = TooltipLines[0].TrimStartAndEnd();
                    bStartsWithDeprecated = FirstLine.StartsWith(TEXT("@deprecated"));
                }
                
                // Add extra newline before @deprecated for spacing
                if (bStartsWithDeprecated)
                {
                    LuaMetaContent += TEXT("---\n");
                }
                
                for (const FString& Line : TooltipLines)
                {
                    LuaMetaContent += FString::Printf(TEXT("---%s\n"), *Line);
                }
            }
            
            // Add original name comment if it contains spaces
            if (PropName.Contains(TEXT(" ")))
            {
                LuaMetaContent += FString::Printf(TEXT("---@field %s %s -- Original name: \"%s\"\n"), 
                    *PropNameDisplay, *LuaType, *PropName);
            }
            else
            {
                LuaMetaContent += FString::Printf(TEXT("---@field %s %s\n"), *PropNameDisplay, *LuaType);
            }
        }
    }

    LuaMetaContent += FString::Printf(TEXT("local %s = {}\n"), *ClassName);

    LuaMetaContent += TEXT("\n--- Methods\n");

    // Generate functions
    for (TFieldIterator<UFunction> FuncIt(InClass, EFieldIteratorFlags::ExcludeSuper); FuncIt; ++FuncIt)
    {
        UFunction* Function = *FuncIt;
        FString FuncName = Function->GetName();

        // Skip K2_ functions (Blueprint internal functions)
        
        /*
        if (FuncName.StartsWith(TEXT("K2_")))
        {
            continue;
        }
        */
        
        // Skip internal engine functions
        if (FuncName.StartsWith(TEXT("Execute")) || 
            FuncName.StartsWith(TEXT("Receive")) ||
            FuncName.Contains(TEXT("__")))
        {
            continue;
        }

        // Skip if not accessible from script
        if (!Function->HasAnyFunctionFlags(FUNC_BlueprintCallable | FUNC_BlueprintPure))
        {
            continue;
        }

        // Store original name and create display name with underscores
        FString FuncNameOriginal = FuncName;
        FString FuncNameDisplay = FuncName;
        FuncNameDisplay.ReplaceInline(TEXT(" "), TEXT("_"));

        // Add function documentation
        FString FuncTooltip = Function->GetToolTipText().ToString();
        if (!FuncTooltip.IsEmpty())
        {
            // Split tooltip into lines and prefix each with ---
            TArray<FString> TooltipLines;
            FuncTooltip.ParseIntoArray(TooltipLines, TEXT("\n"), true);
            for (const FString& Line : TooltipLines)
            {
                // Skip lines that start with @param or @return as we'll generate those ourselves
                FString TrimmedLine = Line.TrimStartAndEnd();
                if (!TrimmedLine.StartsWith(TEXT("@param")) && !TrimmedLine.StartsWith(TEXT("@return")))
                {
                    LuaMetaContent += FString::Printf(TEXT("---%s\n"), *Line);
                }
            }
        }
        
        // Add original name comment if it contains spaces
        if (FuncName.Contains(TEXT(" ")))
        {
            LuaMetaContent += FString::Printf(TEXT("---Original name: \"%s\"\n"), *FuncNameOriginal);
        }

        // Collect parameters and return values
        TArray<FString> ParamAnnotations;
        FString ReturnType = "nil";
        TArray<FString> ParamNames;

        for (TFieldIterator<FProperty> ParamIt(Function); ParamIt; ++ParamIt)
        {
            FProperty* Param = *ParamIt;
            FString ParamName = Param->GetName();
            // Replace spaces with underscores for parameters too
            ParamName.ReplaceInline(TEXT(" "), TEXT("_"));
            
            FString ParamType = GetLuaTypeFromProperty(Param);

            // Skip local/temporary variables (they have CPF_Parm but not CPF_OutParm or CPF_ReturnParm)
            // Only include actual function parameters (input/output/return)
            bool bIsReturnParam = Param->HasAnyPropertyFlags(CPF_ReturnParm);
            bool bIsOutParam = Param->HasAnyPropertyFlags(CPF_OutParm);
            bool bIsParam = Param->HasAnyPropertyFlags(CPF_Parm);
            
            // Skip function-local variables (they have CPF_Parm but aren't in/out/return)
            if (bIsParam && !bIsReturnParam && !bIsOutParam)
            {
                // This is an input parameter
                ParamAnnotations.Add(FString::Printf(TEXT("---@param %s %s"), *ParamName, *ParamType));
                ParamNames.Add(ParamName);
            }
            else if (bIsReturnParam)
            {
                ReturnType = ParamType;
            }
            else if (bIsOutParam && !Param->HasAnyPropertyFlags(CPF_ConstParm))
            {
                // Out parameters are returned in Lua
                if (ReturnType == "void")
                {
                    ReturnType = ParamType;
                }
                else
                {
                    // Multiple return values
                    ReturnType += FString::Printf(TEXT(", %s"), *ParamType);
                }
            }
        }

        // Write parameter annotations
        for (const FString& ParamAnnotation : ParamAnnotations)
        {
            LuaMetaContent += ParamAnnotation + TEXT("\n");
        }

        // Write return annotation
        LuaMetaContent += FString::Printf(TEXT("---@return %s\n"), *ReturnType);

        // Write function signature with underscored name
        FString ParamList = FString::Join(ParamNames, TEXT(", "));
        LuaMetaContent += FString::Printf(TEXT("function %s.%s(%s) end\n\n"), 
            *ClassName, *FuncNameDisplay, *ParamList);
    }

    LuaMetaContent += FString::Printf(TEXT("return %s\n"), *ClassName);

    // Save to file
    FString ProjectDir = FPaths::ProjectDir();
    FString MetaDir = FPaths::Combine(ProjectDir, GetLuaMetaOutputDirectory());
    FString FilePath = FPaths::Combine(MetaDir, FString::Printf(TEXT("%s.lua"), *ClassName));

    // Create directory if it doesn't exist
    IPlatformFile& PlatformFile = FPlatformFileManager::Get().GetPlatformFile();
    if (!PlatformFile.DirectoryExists(*MetaDir))
    {
        PlatformFile.CreateDirectoryTree(*MetaDir);
    }

    // Write file
    if (FFileHelper::SaveStringToFile(LuaMetaContent, *FilePath))
    {
        UE_LOG(LogTemp, Log, TEXT("Successfully generated Lua meta file: %s"), *FilePath);
    }
    else
    {
        UE_LOG(LogTemp, Error, TEXT("Failed to write Lua meta file: %s"), *FilePath);
    }
}

FString UBarrelUtilityFunctionLibrary::GetLuaTypeFromProperty(FProperty* Property)
{
    if (!Property)
    {
        return TEXT("any");
    }

    // Numeric types
    if (Property->IsA<FIntProperty>() || Property->IsA<FInt64Property>() || 
        Property->IsA<FByteProperty>() || Property->IsA<FUInt32Property>() ||
        Property->IsA<FUInt64Property>())
    {
        return TEXT("integer");
    }

    if (Property->IsA<FFloatProperty>() || Property->IsA<FDoubleProperty>())
    {
        return TEXT("number");
    }

    // Boolean
    if (Property->IsA<FBoolProperty>())
    {
        return TEXT("boolean");
    }

    // String types
    if (Property->IsA<FStrProperty>() || Property->IsA<FNameProperty>() || 
        Property->IsA<FTextProperty>())
    {
        return TEXT("string");
    }

    // Array
    if (FArrayProperty* ArrayProp = CastField<FArrayProperty>(Property))
    {
        FString InnerType = GetLuaTypeFromProperty(ArrayProp->Inner);
        return FString::Printf(TEXT("%s[]"), *InnerType);
    }

    // Map
    if (FMapProperty* MapProp = CastField<FMapProperty>(Property))
    {
        FString KeyType = GetLuaTypeFromProperty(MapProp->KeyProp);
        FString ValueType = GetLuaTypeFromProperty(MapProp->ValueProp);
        return FString::Printf(TEXT("table<%s, %s>"), *KeyType, *ValueType);
    }

    // Set
    if (FSetProperty* SetProp = CastField<FSetProperty>(Property))
    {
        FString ElementType = GetLuaTypeFromProperty(SetProp->ElementProp);
        return FString::Printf(TEXT("table<%s, boolean>"), *ElementType);
    }

    // Object/Class types
    if (FObjectProperty* ObjProp = CastField<FObjectProperty>(Property))
    {
        if (ObjProp->PropertyClass)
        {
            return ObjProp->PropertyClass->GetName();
        }
        return TEXT("UObject");
    }

    if (FClassProperty* ClassProp = CastField<FClassProperty>(Property))
    {
        if (ClassProp->MetaClass)
        {
            return FString::Printf(TEXT("TSubclassOf<%s>"), *ClassProp->MetaClass->GetName());
        }
        return TEXT("UClass");
    }

    // Struct types
    if (FStructProperty* StructProp = CastField<FStructProperty>(Property))
    {
        if (StructProp->Struct)
        {
            return StructProp->Struct->GetName();
        }
        return TEXT("table");
    }

    // Enum types
    if (FEnumProperty* EnumProp = CastField<FEnumProperty>(Property))
    {
        if (EnumProp->GetEnum())
        {
            return EnumProp->GetEnum()->GetName();
        }
        return TEXT("integer");
    }

    // Delegate types
    if (Property->IsA<FDelegateProperty>() || Property->IsA<FMulticastDelegateProperty>())
    {
        return TEXT("function");
    }

    // Fallback
    return TEXT("any");
}

bool UBarrelUtilityFunctionLibrary::IsValidLuaIdentifier(const FString& Name)
{
    if (Name.IsEmpty())
    {
        return false;
    }

    // Lua reserved keywords
    static const TSet<FString> LuaKeywords = {
        TEXT("and"), TEXT("break"), TEXT("do"), TEXT("else"), TEXT("elseif"),
        TEXT("end"), TEXT("false"), TEXT("for"), TEXT("function"), TEXT("if"),
        TEXT("in"), TEXT("local"), TEXT("nil"), TEXT("not"), TEXT("or"),
        TEXT("repeat"), TEXT("return"), TEXT("then"), TEXT("true"), TEXT("until"),
        TEXT("while"), TEXT("goto")
    };

    // Check if it's a reserved keyword
    if (LuaKeywords.Contains(Name))
    {
        return false;
    }

    // Check first character (must be letter or underscore)
    TCHAR FirstChar = Name[0];
    if (!FChar::IsAlpha(FirstChar) && FirstChar != '_')
    {
        return false;
    }

    // Check remaining characters (must be letter, digit, or underscore)
    for (int32 i = 1; i < Name.Len(); i++)
    {
        TCHAR Char = Name[i];
        if (!FChar::IsAlnum(Char) && Char != '_')
        {
            return false;
        }
    }

    return true;
}

FString UBarrelUtilityFunctionLibrary::SanitizeLuaIdentifier(const FString& Name)
{
    FString Sanitized = Name;
    
    // Replace spaces with underscores
    Sanitized.ReplaceInline(TEXT(" "), TEXT("_"));
    
    // Replace other invalid characters with underscores
    // Valid Lua identifier characters are: letters, digits, underscores
    // But can't start with a digit
    FString Result;
    for (int32 i = 0; i < Sanitized.Len(); i++)
    {
        TCHAR Char = Sanitized[i];
        if (FChar::IsAlnum(Char) || Char == '_')
        {
            Result.AppendChar(Char);
        }
        else
        {
            Result.AppendChar('_');
        }
    }
    
    // If it starts with a digit, prepend underscore
    if (Result.Len() > 0 && FChar::IsDigit(Result[0]))
    {
        Result = TEXT("_") + Result;
    }
    
    // If it's a Lua keyword, append underscore
    if (!IsValidLuaIdentifier(Result))
    {
        Result += TEXT("_");
    }
    
    return Result;
}

void UBarrelUtilityFunctionLibrary::CollectReferencedTypes(UClass* InClass, TSet<UStruct*>& OutStructs, TSet<UClass*>& OutClasses)
{
    if (!InClass)
    {
        return;
    }

    // Iterate through all properties
    for (TFieldIterator<FProperty> PropIt(InClass, EFieldIteratorFlags::ExcludeSuper); PropIt; ++PropIt)
    {
        FProperty* Property = *PropIt;
        
        // Check for struct properties
        if (FStructProperty* StructProp = CastField<FStructProperty>(Property))
        {
            OutStructs.Add(StructProp->Struct);
        }
        
        // Check for object/class properties
        if (FObjectProperty* ObjProp = CastField<FObjectProperty>(Property))
        {
            if (ObjProp->PropertyClass && 
                ObjProp->PropertyClass != UObject::StaticClass() &&
                !ObjProp->PropertyClass->GetName().StartsWith(TEXT("Actor")) &&
                !ObjProp->PropertyClass->GetName().StartsWith(TEXT("Pawn")) &&
                ObjProp->PropertyClass->IsChildOf(UActorComponent::StaticClass()))
            {
                // Collect custom component classes
                OutClasses.Add(ObjProp->PropertyClass);
            }
        }
        
        // Check for class properties
        if (FClassProperty* ClassProp = CastField<FClassProperty>(Property))
        {
            if (ClassProp->MetaClass && ClassProp->MetaClass != UObject::StaticClass())
            {
                OutClasses.Add(ClassProp->MetaClass);
            }
        }
        
        // Check arrays of structs/objects
        if (FArrayProperty* ArrayProp = CastField<FArrayProperty>(Property))
        {
            if (FStructProperty* InnerStruct = CastField<FStructProperty>(ArrayProp->Inner))
            {
                if (InnerStruct->Struct)
                {
                    OutStructs.Add(InnerStruct->Struct);
                }
            }
            else if (FObjectProperty* InnerObj = CastField<FObjectProperty>(ArrayProp->Inner))
            {
                if (InnerObj->PropertyClass && InnerObj->PropertyClass != UObject::StaticClass())
                {
                    OutClasses.Add(InnerObj->PropertyClass);
                }
            }
        }
    }

    // Iterate through all functions
    for (TFieldIterator<UFunction> FuncIt(InClass, EFieldIteratorFlags::ExcludeSuper); FuncIt; ++FuncIt)
    {
        UFunction* Function = *FuncIt;
        
        // Skip non-callable functions
        if (!Function->HasAnyFunctionFlags(FUNC_BlueprintCallable | FUNC_BlueprintPure))
        {
            continue;
        }

        // Check function parameters
        for (TFieldIterator<FProperty> ParamIt(Function); ParamIt; ++ParamIt)
        {
            FProperty* Param = *ParamIt;
            
            // Check for struct parameters
            if (FStructProperty* StructProp = CastField<FStructProperty>(Param))
            {
                OutStructs.Add(StructProp->Struct);
            }
            
            // Check for object parameters
            if (FObjectProperty* ObjProp = CastField<FObjectProperty>(Param))
            {
                if (ObjProp->PropertyClass && ObjProp->PropertyClass != UObject::StaticClass())
                {
                    OutClasses.Add(ObjProp->PropertyClass);
                }
            }
            
            // Check for class parameters
            if (FClassProperty* ClassProp = CastField<FClassProperty>(Param))
            {
                if (ClassProp->MetaClass && ClassProp->MetaClass != UObject::StaticClass())
                {
                    OutClasses.Add(ClassProp->MetaClass);
                }
            }
        }
    }
}

void UBarrelUtilityFunctionLibrary::GenerateLuaMetaFileFromStruct(UStruct* InStruct, bool suppressWarnings)
{
    if (!InStruct)
    {
        UE_LOG(LogTemp, Error, TEXT("GenerateLuaMetaFileFromStruct: Invalid struct provided"));
        return;
    }

    FString StructName = InStruct->GetName();
    FString LuaMetaContent;

    // Start with struct declaration
    LuaMetaContent += FString::Printf(TEXT("---@meta\n\n"));
    LuaMetaContent += FString::Printf(TEXT("--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.\n"));
    LuaMetaContent += FString::Printf(TEXT("--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.\n"));
    LuaMetaContent += FString::Printf(TEXT("--- Access these using bracket notation: object[\"Apply Damage\"]\n\n"));
    
    if (suppressWarnings)
    {
        LuaMetaContent += FString::Printf(TEXT("---@diagnostic disable: undefined-doc-name\n"));
    }
    
    LuaMetaContent += FString::Printf(TEXT("---@class %s\n"), *StructName);
    
    // Document struct description if available
    FString StructTooltip = InStruct->GetToolTipText().ToString();
    if (!StructTooltip.IsEmpty())
    {
        TArray<FString> TooltipLines;
        StructTooltip.ParseIntoArray(TooltipLines, TEXT("\n"), true);
        for (const FString& Line : TooltipLines)
        {
            LuaMetaContent += FString::Printf(TEXT("---%s\n"), *Line);
        }
    }

    LuaMetaContent += TEXT("---\n--- Properties\n");

    // Structure to hold field info for the constructor generation later
    struct FLuaStructField
    {
        FString Name;
        FString Type;
    };
    TArray<FLuaStructField> CollectedFields;

    // Generate fields
    for (TFieldIterator<FProperty> PropIt(InStruct); PropIt; ++PropIt)
    {
        FProperty* Property = *PropIt;
        
        FString PropName = Property->GetName();
        FString PropNameDisplay = PropName;
        PropNameDisplay.ReplaceInline(TEXT(" "), TEXT("_"));
        
        FString LuaType = GetLuaTypeFromProperty(Property);
        
        // Store for constructor generation
        CollectedFields.Add({PropNameDisplay, LuaType});

        // Add property documentation
        FString PropTooltip = Property->GetToolTipText().ToString();
        if (!PropTooltip.IsEmpty())
        {
            TArray<FString> TooltipLines;
            PropTooltip.ParseIntoArray(TooltipLines, TEXT("\n"), true);
            
            // Check if first line is @deprecated
            bool bStartsWithDeprecated = false;
            if (TooltipLines.Num() > 0)
            {
                FString FirstLine = TooltipLines[0].TrimStartAndEnd();
                bStartsWithDeprecated = FirstLine.StartsWith(TEXT("@deprecated"));
            }
            
            // Add extra newline before @deprecated for spacing
            if (bStartsWithDeprecated)
            {
                LuaMetaContent += TEXT("---\n");
            }
            
            for (const FString& Line : TooltipLines)
            {
                LuaMetaContent += FString::Printf(TEXT("---%s\n"), *Line);
            }
        }
        
        // Add original name comment if it contains spaces
        if (PropName.Contains(TEXT(" ")))
        {
            LuaMetaContent += FString::Printf(TEXT("---@field %s %s -- Original name: \"%s\"\n"), 
                *PropNameDisplay, *LuaType, *PropName);
        }
        else
        {
            LuaMetaContent += FString::Printf(TEXT("---@field %s %s\n"), *PropNameDisplay, *LuaType);
        }
    }

    LuaMetaContent += FString::Printf(TEXT("local %s = {}\n"), *StructName);

    // --- Constructor Generation Start ---
    LuaMetaContent += TEXT("\n--- Constructor\n");
    LuaMetaContent += FString::Printf(TEXT("---@return %s\n"), *StructName);

    // Generate @param annotations for the constructor
    for (const FLuaStructField& Field : CollectedFields)
    {
        LuaMetaContent += FString::Printf(TEXT("---@param %s %s\n"), *Field.Name, *Field.Type);
    }

    // Generate function signature
    TArray<FString> ParamNames;
    for (const FLuaStructField& Field : CollectedFields)
    {
        ParamNames.Add(Field.Name);
    }
    FString ParamList = FString::Join(ParamNames, TEXT(", "));

    LuaMetaContent += FString::Printf(TEXT("function %s.new(%s)\n"), *StructName, *ParamList);
    LuaMetaContent += TEXT("    local self = {}\n");
    
    // Assign values
    for (const FLuaStructField& Field : CollectedFields)
    {
        LuaMetaContent += FString::Printf(TEXT("    self.%s = %s\n"), *Field.Name, *Field.Name);
    }

    LuaMetaContent += TEXT("    return self\n");
    LuaMetaContent += TEXT("end\n\n");
    // --- Constructor Generation End ---

    LuaMetaContent += FString::Printf(TEXT("return %s\n"), *StructName);

    // Save to file
    FString ProjectDir = FPaths::ProjectDir();
    FString MetaDir = FPaths::Combine(ProjectDir, GetLuaMetaOutputDirectory());
    FString FilePath = FPaths::Combine(MetaDir, FString::Printf(TEXT("%s.lua"), *StructName));

    // Create directory if it doesn't exist
    IPlatformFile& PlatformFile = FPlatformFileManager::Get().GetPlatformFile();
    if (!PlatformFile.DirectoryExists(*MetaDir))
    {
        PlatformFile.CreateDirectoryTree(*MetaDir);
    }

    // Write file
    if (FFileHelper::SaveStringToFile(LuaMetaContent, *FilePath))
    {
        UE_LOG(LogTemp, Log, TEXT("Successfully generated Lua meta file: %s"), *FilePath);
    }
    else
    {
        UE_LOG(LogTemp, Error, TEXT("Failed to write Lua meta file: %s"), *FilePath);
    }
}

void UBarrelUtilityFunctionLibrary::GenerateLuaMetaFilesRecursive(UClass* InClass, bool suppressWarnings)
{
    GenerateBaseMetaFiles(suppressWarnings);
    
    if (!InClass)
    {
        UE_LOG(LogTemp, Error, TEXT("GenerateLuaMetaFilesRecursive: Invalid class provided"));
        return;
    }

    // Track processed classes and structs to avoid infinite loops
    // Use thread-local to support multiple simultaneous generations
    static thread_local TSet<UClass*> ProcessedClasses;
    static thread_local TSet<UStruct*> ProcessedStructs;
    static thread_local int32 RecursionDepth = 0;
    
    // Prevent stack overflow with max recursion depth
    if (RecursionDepth > 100)
    {
        UE_LOG(LogTemp, Warning, TEXT("Max recursion depth reached at class: %s"), *InClass->GetName());
        return;
    }
    
    RecursionDepth++;

    // Reset the sets if we're at depth 1 (new root call)
    if (RecursionDepth == 1)
    {
        ProcessedClasses.Empty();
        ProcessedStructs.Empty();
        UE_LOG(LogTemp, Log, TEXT("Starting recursive meta generation from: %s"), *InClass->GetName());
    }

    // If we've already processed this class, skip it
    if (ProcessedClasses.Contains(InClass))
    {
        RecursionDepth--;
        return;
    }

    // Mark this class as processed IMMEDIATELY to prevent circular references
    ProcessedClasses.Add(InClass);

    // First, recursively process parent class if it exists and isn't UObject
    UClass* ParentClass = InClass->GetSuperClass();
    if (ParentClass && ParentClass != UObject::StaticClass())
    {
        if (!ProcessedClasses.Contains(ParentClass))
        {
            GenerateLuaMetaFilesRecursive(ParentClass, suppressWarnings);
        }
    }

    // Collect all referenced types (structs and classes) from this class
    TSet<UStruct*> ReferencedStructs;
    TSet<UClass*> ReferencedClasses;
    CollectReferencedTypes(InClass, ReferencedStructs, ReferencedClasses);

    // Generate meta files for all referenced structs
    for (UStruct* ReferencedStruct : ReferencedStructs)
    {
        if (!ProcessedStructs.Contains(ReferencedStruct))
        {
            ProcessedStructs.Add(ReferencedStruct);
            GenerateLuaMetaFileFromStruct(ReferencedStruct, suppressWarnings);
            UE_LOG(LogTemp, Log, TEXT("Generated meta file for struct: %s"), *ReferencedStruct->GetName());
        }
    }

    // Generate meta files for all referenced classes
    for (UClass* ReferencedClass : ReferencedClasses)
    {
        // Check BEFORE recursing to prevent circular references
        if (!ProcessedClasses.Contains(ReferencedClass) && ReferencedClass != UObject::StaticClass())
        {
            GenerateLuaMetaFilesRecursive(ReferencedClass, suppressWarnings);
        }
    }

    // Now generate the meta file for this class
    GenerateLuaMetaFileFromClass(InClass, suppressWarnings);
    UE_LOG(LogTemp, Log, TEXT("Generated meta file for class: %s"), *InClass->GetName());
    
    RecursionDepth--;
}

void UBarrelUtilityFunctionLibrary::GenerateBaseMetaFiles(bool suppressWarnings)
{
    GenerateLuaMetaFileFromStruct(TBaseStructure<FTransform>::Get(), suppressWarnings);
    GenerateLuaMetaFileFromStruct(TBaseStructure<FRotator>::Get(), suppressWarnings);
    GenerateLuaMetaFileFromStruct(TBaseStructure<FVector>::Get(), suppressWarnings);
    GenerateLuaMetaFileFromStruct(TBaseStructure<FVector2D>::Get(), suppressWarnings);
    GenerateLuaMetaFileFromStruct(TBaseStructure<FQuat>::Get(), suppressWarnings);
}
