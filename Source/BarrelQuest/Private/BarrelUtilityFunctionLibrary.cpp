#include "BarrelUtilityFunctionLibrary.h"
#include "UObject/Class.h"
#include "UObject/UnrealType.h"
#include "Misc/FileHelper.h"
#include "Misc/Paths.h"
#include "HAL/PlatformFileManager.h"

FLinearColor UBarrelUtilityFunctionLibrary::HexStringToLinearColor(FString hexString)
{
    // Remove leading #
    hexString = hexString.Replace(TEXT("#"), TEXT(""));

    // Must be either 6 (RGB) or 8 (RGBA) characters
    if (hexString.Len() != 6 && hexString.Len() != 8)
    {
        return FLinearColor::Black;
    }

    auto HexToFloat = [](const FString& Hex)
    {
        return static_cast<float>(FParse::HexNumber(*Hex)) / 255.0f;
    };

    float R = HexToFloat(hexString.Mid(0, 2));
    float G = HexToFloat(hexString.Mid(2, 2));
    float B = HexToFloat(hexString.Mid(4, 2));
    float A = 1.0f;

    if (hexString.Len() == 8)
    {
        A = HexToFloat(hexString.Mid(6, 2));
    }

    return FLinearColor(R, G, B, A);
}

FString UBarrelUtilityFunctionLibrary::LinearColorToHexString(const FLinearColor& color)
{
    const FColor SRGBColor = color.ToFColor(true); // true = sRGB conversion

    return FString::Printf(
        TEXT("#%02X%02X%02X%02X"),
        SRGBColor.R,
        SRGBColor.G,
        SRGBColor.B,
        SRGBColor.A
    );
}

void UBarrelUtilityFunctionLibrary::GenerateAssetPathFile()
{
    FString filePath = GetLuaMetaOutputDirectory();
    
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
        LuaMetaContent += FString::Printf(TEXT("---@diagnostic disable: undefined-doc-name\n\n"));
        LuaMetaContent += FString::Printf(TEXT("---@diagnostic disable: redundant-parameter\n\n"));
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
        // Add blank line before properties section
        LuaMetaContent += TEXT("---\n");
        
        // Generate fields/properties
        LuaMetaContent += TEXT("--- Properties\n");
        LuaMetaContent += TEXT("---\n"); // Add blank line after section header
        
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
                TArray<FString> TooltipLines;
                PropTooltip.ParseIntoArray(TooltipLines, TEXT("\n"), true);
    
                bool bStartsWithDeprecated = false;
                if (TooltipLines.Num() > 0)
                {
                    FString FirstLine = TooltipLines[0].TrimStartAndEnd();
                    bStartsWithDeprecated = FirstLine.StartsWith(TEXT("@deprecated"));
                }
    
                if (bStartsWithDeprecated)
                {
                    LuaMetaContent += TEXT("---\n");
                }
    
                bool bIsDelegate = Property->IsA<FMulticastDelegateProperty>();
    
                for (const FString& Line : TooltipLines)
                {
                    FString ProcessedLine = Line;
                    ProcessedLine.ReplaceInline(TEXT("@see"), TEXT("\\@see"));
        
                    // Skip @param lines for delegates as they're now in the type definition
                    if (bIsDelegate)
                    {
                        FString TrimmedLine = ProcessedLine.TrimStart();
                        if (TrimmedLine.StartsWith(TEXT("@param")))
                        {
                            continue;
                        }
                    }
        
                    LuaMetaContent += FString::Printf(TEXT("---%s\n"), *ProcessedLine);
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
                    FString ProcessedLine = Line;
                    // Escape @see and other @ tags that shouldn't be LuaLS annotations
                    ProcessedLine.ReplaceInline(TEXT("@see"), TEXT("\\@see"));
                    LuaMetaContent += FString::Printf(TEXT("---%s\n"), *ProcessedLine);
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

    if (FMulticastDelegateProperty* DelegateProperty = CastField<FMulticastDelegateProperty>(Property))
    {
        FString DelegateName = Property->GetName();
        DelegateName.ReplaceInline(TEXT(" "), TEXT("_"));
        return FString::Printf(TEXT("%sDelegate"), *DelegateName);
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
        LuaMetaContent += FString::Printf(TEXT("---@diagnostic disable: undefined-doc-name\n\n"));
    }
    
    // Collect delegate types first (before main class declaration)
    TArray<FString> DelegateTypeDefinitions;
    for (TFieldIterator<FProperty> PropIt(InStruct); PropIt; ++PropIt)
    {
        FProperty* Property = *PropIt;
        
        if (FMulticastDelegateProperty* DelegateProperty = CastField<FMulticastDelegateProperty>(Property))
        {
            FString DelegateTypeDef = GenerateDelegateTypeDefinition(DelegateProperty);
            if (!DelegateTypeDef.IsEmpty())
            {
                DelegateTypeDefinitions.Add(DelegateTypeDef);
            }
        }
    }
    
    // Add delegate type definitions before the main class
    for (const FString& DelegateTypeDef : DelegateTypeDefinitions)
    {
        LuaMetaContent += DelegateTypeDef + TEXT("\n");
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

    LuaMetaContent += TEXT("---\n--- Properties\n---\n");
    
    TArray<FLuaStructField> CollectedFields;

    // Collect field mappings for wrapper generation
    TMap<FString, FString> FieldMappings; // CleanName -> UglyName
    TMap<FString, FString> FieldTypes;    // CleanName -> Type
    bool bHasUglyNames = false;

    // Generate fields
    for (TFieldIterator<FProperty> PropIt(InStruct); PropIt; ++PropIt)
    {
        FProperty* Property = *PropIt;
        
        FString PropName = Property->GetName();
        FString PropNameDisplay = PropName;
        PropNameDisplay.ReplaceInline(TEXT(" "), TEXT("_"));
        
        FString LuaType = GetLuaTypeFromProperty(Property);
        
        // Extract clean name (remove GUID suffix pattern like "_7_DF6FEDCF...")
        FString CleanName = PropNameDisplay;
        bool bIsUglyName = false;
        
        // Check for pattern: SomeName_Number_GUID
        int32 LastUnderscoreIndex;
        if (CleanName.FindLastChar('_', LastUnderscoreIndex))
        {
            FString AfterUnderscore = CleanName.RightChop(LastUnderscoreIndex + 1);
            
            // If it's all hex or long enough to be a GUID, it's likely generated
            if (AfterUnderscore.Len() > 8 || (AfterUnderscore.Len() > 0 && AfterUnderscore.IsNumeric()))
            {
                // Look for the pattern before: Name_Number_GUID
                FString BeforeLastUnderscore = CleanName.Left(LastUnderscoreIndex);
                int32 SecondLastUnderscoreIndex;
                if (BeforeLastUnderscore.FindLastChar('_', SecondLastUnderscoreIndex))
                {
                    FString NumberPart = BeforeLastUnderscore.RightChop(SecondLastUnderscoreIndex + 1);
                    if (NumberPart.IsNumeric())
                    {
                        // It's the pattern: Name_Number_GUID
                        CleanName = BeforeLastUnderscore.Left(SecondLastUnderscoreIndex);
                        bIsUglyName = true;
                        bHasUglyNames = true;
                    }
                }
            }
        }
        
        if (bIsUglyName)
        {
            FieldMappings.Add(CleanName, PropNameDisplay);
            FieldTypes.Add(CleanName, LuaType);
        }
        
        // Store for constructor generation (skip delegates in constructor)
        if (!Property->IsA<FMulticastDelegateProperty>())
        {
            CollectedFields.Add({PropName, PropNameDisplay, LuaType, CleanName});
        }

        // Add property documentation
        FString PropTooltip = Property->GetToolTipText().ToString();
        if (!PropTooltip.IsEmpty())
        {
            TArray<FString> TooltipLines;
            PropTooltip.ParseIntoArray(TooltipLines, TEXT("\n"), true);
            
            bool bStartsWithDeprecated = false;
            if (TooltipLines.Num() > 0)
            {
                FString FirstLine = TooltipLines[0].TrimStartAndEnd();
                bStartsWithDeprecated = FirstLine.StartsWith(TEXT("@deprecated"));
            }
            
            if (bStartsWithDeprecated)
            {
                LuaMetaContent += TEXT("---\n");
            }
            
            for (const FString& Line : TooltipLines)
            {
                FString ProcessedLine = Line;
                ProcessedLine.ReplaceInline(TEXT("@see"), TEXT("\\@see"));
                
                // Skip @param lines for delegates as they're now in the type definition
                if (Property->IsA<FMulticastDelegateProperty>() && ProcessedLine.TrimStart().StartsWith(TEXT("@param")))
                {
                    continue;
                }
                
                LuaMetaContent += FString::Printf(TEXT("---%s\n"), *ProcessedLine);
            }
        }
        
        // Mark ugly names as protected to hide from autocomplete but allow internal access
        FString FieldVisibility = bIsUglyName ? TEXT("protected ") : TEXT("");
        
        if (PropName.Contains(TEXT(" ")))
        {
            LuaMetaContent += FString::Printf(TEXT("---@field %s%s %s -- Original name: \"%s\"\n"), 
                *FieldVisibility, *PropNameDisplay, *LuaType, *PropName);
        }
        else
        {
            LuaMetaContent += FString::Printf(TEXT("---@field %s%s %s\n"), *FieldVisibility, *PropNameDisplay, *LuaType);
        }
    }

    LuaMetaContent += FString::Printf(TEXT("local %s = {}\n"), *StructName);

    // Constructor (only for non-delegate fields)
    if (CollectedFields.Num() > 0)
    {
        LuaMetaContent += TEXT("\n--- Constructor\n");
        LuaMetaContent += FString::Printf(TEXT("---@return %s\n"), *StructName);

        for (const FLuaStructField& Field : CollectedFields)
        {
            LuaMetaContent += FString::Printf(TEXT("---@param %s %s\n"), *Field.DisplayName, *Field.Type);
        }

        TArray<FString> ParamNames;
        for (const FLuaStructField& Field : CollectedFields)
        {
            ParamNames.Add(Field.DisplayName);
        }
        FString ParamList = FString::Join(ParamNames, TEXT(", "));

        LuaMetaContent += FString::Printf(TEXT("function %s.new(%s)\n"), *StructName, *ParamList);
        LuaMetaContent += TEXT("    local self = {}\n");
        
        for (const FLuaStructField& Field : CollectedFields)
        {
            LuaMetaContent += FString::Printf(TEXT("    self.%s = %s\n"), *Field.DisplayName, *Field.DisplayName);
        }

        LuaMetaContent += TEXT("    return self\n");
        LuaMetaContent += TEXT("end\n\n");
    }

    LuaMetaContent += FString::Printf(TEXT("return %s\n"), *StructName);

    // Save main struct file
    FString ProjectDir = FPaths::ProjectDir();
    FString MetaDir = FPaths::Combine(ProjectDir, GetLuaMetaOutputDirectory());
    FString FilePath = FPaths::Combine(MetaDir, FString::Printf(TEXT("%s.lua"), *StructName));

    IPlatformFile& PlatformFile = FPlatformFileManager::Get().GetPlatformFile();
    if (!PlatformFile.DirectoryExists(*MetaDir))
    {
        PlatformFile.CreateDirectoryTree(*MetaDir);
    }

    if (FFileHelper::SaveStringToFile(LuaMetaContent, *FilePath))
    {
        UE_LOG(LogTemp, Log, TEXT("Successfully generated Lua meta file: %s"), *FilePath);
    }
    else
    {
        UE_LOG(LogTemp, Error, TEXT("Failed to write Lua meta file: %s"), *FilePath);
    }

    // Generate wrapper if struct has ugly generated names
    if (bHasUglyNames && FieldMappings.Num() > 0)
    {
        FString WrappersDir = FPaths::Combine(MetaDir, TEXT("wrappers"));
        GenerateStructWrapper(StructName, CollectedFields, FieldMappings, FieldTypes, WrappersDir);
    }
}

void UBarrelUtilityFunctionLibrary::GenerateStructWrapper(
    const FString& StructName,
    const TArray<FLuaStructField>& Fields,
    const TMap<FString, FString>& FieldMappings,
    const TMap<FString, FString>& FieldTypes,
    const FString& OutputDir)
{
    // ... (Directory setup is correct) ...

    IPlatformFile& PlatformFile = FPlatformFileManager::Get().GetPlatformFile();
    if (!PlatformFile.DirectoryExists(*OutputDir))
    {
        PlatformFile.CreateDirectoryTree(*OutputDir);
    }
    
    FString WrapperName = StructName;
    if (WrapperName.EndsWith(TEXT("Struct")))
    {
        WrapperName = WrapperName.LeftChop(6);
    }
    
    WrapperName += TEXT("_W");
    
    FString WrapperContent;
    
    // Header & Class Definitions (Unchanged)
    WrapperContent += TEXT("---@meta\n");
    WrapperContent += FString::Printf(TEXT("local %s = require(\"API.%s\")\n\n"), *StructName, *StructName);
    WrapperContent += FString::Printf(TEXT("---@class %s : %s\n"), *WrapperName, *StructName);
    WrapperContent += FString::Printf(TEXT("---@field private _raw %s\n"), *StructName);
    for (const TPair<FString, FString>& Pair : FieldTypes)
    {
        WrapperContent += FString::Printf(TEXT("---@field %s %s\n"), *Pair.Key, *Pair.Value);
    }
    WrapperContent += FString::Printf(TEXT("local %s = {}\n"), *WrapperName);
    WrapperContent += FString::Printf(TEXT("%s.__index = %s\n\n"), *WrapperName, *WrapperName);
    
// Constructor - Support both positional and table-based initialization
    TArray<FString> ConstructorParamNames;
    FString ParamAnnotations;

    for (const FLuaStructField& Field : Fields)
    {
        FString ParamName = FieldMappings.Contains(Field.CleanName) ? Field.CleanName : Field.DisplayName;
        ConstructorParamNames.Add(ParamName);
        ParamAnnotations += FString::Printf(TEXT("---@param %s %s\n"), *ParamName, *Field.Type);
    }

    // Generate constructor with overload support
    WrapperContent += TEXT("--- Constructor (supports both positional arguments and table initialization)\n");
    WrapperContent += TEXT("---@overload fun(data: table): ") + WrapperName + TEXT("\n");
    WrapperContent += ParamAnnotations;
    WrapperContent += FString::Printf(TEXT("---@return %s\n"), *WrapperName);
    
    // Build full parameter list for function signature
    FString ParamListString = FString::Join(ConstructorParamNames, TEXT(", "));
    FString FirstParamName = ConstructorParamNames.Num() > 0 ? ConstructorParamNames[0] : TEXT("arg1");
    
    WrapperContent += FString::Printf(TEXT("function %s.new(%s)\n"), *WrapperName, *ParamListString);
    WrapperContent += TEXT("    local raw\n");
    WrapperContent += TEXT("    \n");
    WrapperContent += TEXT("    -- Check if first argument is a table (table-based initialization)\n");
    WrapperContent += FString::Printf(TEXT("    if type(%s) == \"table\" then\n"), *FirstParamName);
    WrapperContent += TEXT("    ---@type table\n");
    WrapperContent += TEXT("        local data = ") + FirstParamName + TEXT("\n");
    WrapperContent += TEXT("        raw = ") + StructName + TEXT(".new(\n");
    
    // Generate field extraction from table for raw struct constructor
    for (int32 i = 0; i < ConstructorParamNames.Num(); i++)
    {
        const FString& ParamName = ConstructorParamNames[i];
        FString Comma = (i < ConstructorParamNames.Num() - 1) ? TEXT(",") : TEXT("");
        WrapperContent += FString::Printf(TEXT("            data[\"%s\"] or data.%s%s\n"), *ParamName, *ParamName, *Comma);
    }
    
    WrapperContent += TEXT("        )\n");
    WrapperContent += TEXT("    else\n");
    WrapperContent += TEXT("        -- Positional arguments\n");
    WrapperContent += FString::Printf(TEXT("        raw = %s.new(%s)\n"), *StructName, *ParamListString);
    WrapperContent += TEXT("    end\n");
    WrapperContent += TEXT("    \n");
    WrapperContent += FString::Printf(TEXT("    local self = setmetatable({}, %s)\n"), *WrapperName);
    WrapperContent += TEXT("    rawset(self, \"_raw\", raw)\n");
    WrapperContent += TEXT("    return self\n");
    WrapperContent += TEXT("end\n\n");

    
    // --- __index (Getter) - Stack Overflow prevention maintained ---
    WrapperContent += FString::Printf(TEXT("function %s:__index(key)\n"), *WrapperName);
    
    // Lookup Mappings
    WrapperContent += TEXT("    local mappings = {\n");
    for (const TPair<FString, FString>& Pair : FieldMappings)
    {
        WrapperContent += FString::Printf(TEXT("        %s = \"%s\",\n"), *Pair.Key, *Pair.Value);
    }
    WrapperContent += TEXT("    }\n\n");

    // 1. Check the metatable for functions (methods)
    WrapperContent += TEXT("    local mt = getmetatable(self)\n");
    WrapperContent += TEXT("    local value = rawget(mt, key)\n");
    
    // If a value is found AND it's a function (method) or the value is not the metatable itself (avoids recursion), return it.
    WrapperContent += TEXT("    if value and (type(value) == 'function' or value ~= mt) then return value end\n\n");
    
    // 2. Perform the delegation lookup
    WrapperContent += TEXT("    local uglyKey = mappings[key]\n");
    WrapperContent += TEXT("    local finalKey = uglyKey or key\n");
    
    // 3. Delegate to the raw struct.
    WrapperContent += TEXT("    local raw = rawget(self, \"_raw\")\n");
    WrapperContent += TEXT("    return raw[finalKey]\n");
    WrapperContent += FString::Printf(TEXT("end\n\n"));


    // --- __newindex (Setter) - Recursion prevention maintained ---
    WrapperContent += FString::Printf(TEXT("function %s:__newindex(key, value)\n"), *WrapperName);
    
    // Lookup Mappings
    WrapperContent += TEXT("    local mappings = {\n");
    for (const TPair<FString, FString>& Pair : FieldMappings)
    {
        WrapperContent += FString::Printf(TEXT("        %s = \"%s\",\n"), *Pair.Key, *Pair.Value);
    }
    WrapperContent += TEXT("    }\n\n");

    WrapperContent += TEXT("    local uglyKey = mappings[key]\n");
    WrapperContent += TEXT("    local finalKey = uglyKey or key\n"); 
    
    // FIX: Use rawget to safely retrieve the _raw table without triggering infinite __newindex recursion.
    WrapperContent += TEXT("    local raw = rawget(self, \"_raw\")\n");
    WrapperContent += TEXT("    raw[finalKey] = value\n");
    
    WrapperContent += FString::Printf(TEXT("end\n\n"));

    
    // 🌟 FIX: Add GetRaw() method for engine compatibility 
    // This allows user code to call InventoryItem.new(...):GetRaw()
    WrapperContent += FString::Printf(TEXT("--- Returns the raw underlying C++ struct (flat table format).\n"));
    WrapperContent += FString::Printf(TEXT("---@return %s\n"), *StructName);
    WrapperContent += FString::Printf(TEXT("function %s:GetRaw()\n"), *WrapperName);
    WrapperContent += TEXT("    return rawget(self, \"_raw\")\n"); 
    WrapperContent += FString::Printf(TEXT("end\n\n"));

    // 🌟 OPTIONAL: Add __unm (Unary Minus) for easy shorthand: -i 
    WrapperContent += FString::Printf(TEXT("--- Unary Minus (-) operator shorthand for GetRaw().\n"));
    WrapperContent += FString::Printf(TEXT("---@return %s\n"), *StructName);
    WrapperContent += FString::Printf(TEXT("function %s:__unm()\n"), *WrapperName);
    WrapperContent += TEXT("    return rawget(self, \"_raw\")\n"); 
    WrapperContent += FString::Printf(TEXT("end\n\n"));


    WrapperContent += FString::Printf(TEXT("return %s\n"), *WrapperName);

    // 💥 FIX: Define FilePath before saving!
    FString FilePath = FPaths::Combine(OutputDir, FString::Printf(TEXT("%s.lua"), *WrapperName));

    // --- File Saving ---
    if (FFileHelper::SaveStringToFile(WrapperContent, *FilePath))
    {
        UE_LOG(LogTemp, Log, TEXT("Successfully generated Lua wrapper: %s"), *FilePath);
    }
    else
    {
        UE_LOG(LogTemp, Error, TEXT("Failed to write Lua wrapper: %s"), *FilePath);
    }
}

void UBarrelUtilityFunctionLibrary::GenerateLuaMetaFilesRecursive(UClass* InClass, bool suppressWarnings)
{
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

FString UBarrelUtilityFunctionLibrary::GenerateDelegateTypeDefinition(FMulticastDelegateProperty* DelegateProperty)
{
    if (!DelegateProperty)
    {
        return FString();
    }
    
    FString DelegateName = DelegateProperty->GetName();
    DelegateName.ReplaceInline(TEXT(" "), TEXT("_"));
    FString DelegateTypeName = FString::Printf(TEXT("%sDelegate"), *DelegateName);
    
    // Get the signature function
    UFunction* SignatureFunction = DelegateProperty->SignatureFunction;
    if (!SignatureFunction)
    {
        return FString();
    }
    
    // Build parameter list for the callback function
    TArray<FString> ParamList;
    for (TFieldIterator<FProperty> ParamIt(SignatureFunction); ParamIt; ++ParamIt)
    {
        FProperty* Param = *ParamIt;
        
        // Skip return parameters
        if (Param->HasAnyPropertyFlags(CPF_ReturnParm))
        {
            continue;
        }
        
        FString ParamName = Param->GetName();
        FString ParamType = GetLuaTypeFromProperty(Param);
        
        ParamList.Add(FString::Printf(TEXT("%s: %s"), *ParamName, *ParamType));
    }
    
    FString ParamSignature = FString::Join(ParamList, TEXT(", "));
    
    // Generate the delegate type definition
    FString TypeDef;
    TypeDef += FString::Printf(TEXT("---@class %s\n"), *DelegateTypeName);
    TypeDef += FString::Printf(TEXT("---@field Add fun(self: %s, callback: fun(%s))\n"), 
        *DelegateTypeName, *ParamSignature);
    TypeDef += FString::Printf(TEXT("---@field Remove fun(self: %s, callback: fun(%s))\n"), 
        *DelegateTypeName, *ParamSignature);
    TypeDef += FString::Printf(TEXT("---@field Broadcast fun(self: %s, %s)\n"), 
        *DelegateTypeName, *ParamSignature);
    
    return TypeDef;
}

void UBarrelUtilityFunctionLibrary::GenerateBaseMetaFiles(bool suppressWarnings)
{
    GenerateLuaMetaFileFromStruct(TBaseStructure<FTransform>::Get(), suppressWarnings);
    GenerateLuaMetaFileFromStruct(TBaseStructure<FRotator>::Get(), suppressWarnings);
    GenerateLuaMetaFileFromStruct(TBaseStructure<FVector>::Get(), suppressWarnings);
    GenerateLuaMetaFileFromStruct(TBaseStructure<FVector2D>::Get(), suppressWarnings);
    GenerateLuaMetaFileFromStruct(TBaseStructure<FQuat>::Get(), suppressWarnings);
}

UClass* UBarrelUtilityFunctionLibrary::GetClassFromBlueprintPackage(FString PackagePath)
{
    return ConstructorHelpersInternal::FindOrLoadClass(PackagePath, UObject::StaticClass());;
}