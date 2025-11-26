---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class VersionedNiagaraScriptData
---Struct containing all of the data that can be different between different script versions.
---
--- Properties
---@field Version NiagaraAssetVersion
---What changed in this version compared to the last? Displayed to the user when upgrading to a new script version.
---@field VersionChangeDescription string
---When used as a module, what are the appropriate script types for referencing this module?
---@field ModuleUsageBitmask integer
---Used to break up scripts of the same Usage type in UI display.
---@field Category string
---@field AssetTagDefinitionReferences NiagaraAssetTagDefinitionReference[]
---If true, this script will be added to a 'Suggested' category at the top of menus during searches
---@field bSuggested boolean
---Array of Ids of dependencies provided by this module to other modules on the stack (e.g. 'ProvidesNormalizedAge')
---@field ProvidedDependencies string[]
---Dependencies required by this module from other modules on the stack
---@field RequiredDependencies NiagaraModuleDependency[]
---If this script is no longer meant to be used, this option should be set.
---@field bDeprecated boolean
---Message to display when the script is deprecated.
---@field DeprecationMessage string
---Which script to use if this is deprecated.
---@field DeprecationRecommendation NiagaraScript
---If true then a python script will be executed when changing from this script to the selected deprectation recommendation. This allows the current script to transfer its inputs to the new script.
---@field bUsePythonScriptConversion boolean
---Reference to a python script that is executed when the user updates from a previous version to this version.
---@field ConversionScriptExecution ENiagaraPythonUpdateScriptReference
---Python script to run when converting this script to the recommended deprecation update script.
---@field PythonConversionScript string
---Asset reference to a python script to run when converting this script to the recommended deprecation update script.
---@field ConversionScriptAsset FilePath
---Custom logic to convert the contents of an existing script assignment to this script.
---@field ConversionUtility Class
---Is this script experimental and less supported?
---@field bExperimental boolean
---The message to display when a function is marked experimental.
---@field ExperimentalMessage string
---A message to display when adding the module to the stack. This is useful to highlight pitfalls or weird behavior of the module.
---@field NoteMessage string
---A message to display on UI actions handling debug draw state.
---@field DebugDrawMessage string
---Defines if this script is visible to the user when searching for modules to add to an emitter.
---@field LibraryVisibility ENiagaraScriptLibraryVisibility
---The mode to use when deducing the type of numeric output pins from the types of the input pins.
---@field NumericOutputTypeSelectionMode ENiagaraNumericOutputTypeSelectionMode
---@field Description string
---A list of space separated keywords which can be used to find this script in editor menus.
---@field Keywords string
---The format for the text to display in the stack if the value is collapsed.
---This supports formatting placeholders for the function inputs, for example "myfunc({0}, {1})" will be converted to "myfunc(1.23, Particles.Position)".
---@field CollapsedViewFormat string
---@field InlineExpressionFormat NiagaraInlineDynamicInputFormatToken[]
---@field InlineGraphFormat NiagaraInlineDynamicInputFormatToken[]
---If used as a dynamic input with exactly one input and output of different types, setting this to true will auto-insert this script to convert from one type to another when dragging and dropping parameters in the stack.
---         For example, a script with a bool as input and a float as output will be automatically inserted in the stack when dropping a bool parameter into the float input of a module in the stack.
---@field bCanBeUsedForTypeConversions boolean
---Script Metadata
---@field ScriptMetaData table<string, string>
---Adjusted every time ComputeVMCompilationId is called.
---@field LastGeneratedVMId NiagaraVMExecutableDataId
---Reference to a python script that is executed when the user updates from a previous version to this version.
---@field UpdateScriptExecution ENiagaraPythonUpdateScriptReference
---Python script to run when updating to this script version.
---@field PythonUpdateScript string
---Asset reference to a python script to run when updating to this script version.
---@field ScriptAsset FilePath
---Subscriptions to parameter definitions for this script version
---@field ParameterDefinitionsSubscriptions ParameterDefinitionsSubscription[]
---@field InputSections NiagaraStackSection[]
---'Source' data/graphs for this script
---@field Source NiagaraScriptSourceBase
local VersionedNiagaraScriptData = {}

--- Constructor
---@return VersionedNiagaraScriptData
---@param Version NiagaraAssetVersion
---@param VersionChangeDescription string
---@param ModuleUsageBitmask integer
---@param Category string
---@param AssetTagDefinitionReferences NiagaraAssetTagDefinitionReference[]
---@param bSuggested boolean
---@param ProvidedDependencies string[]
---@param RequiredDependencies NiagaraModuleDependency[]
---@param bDeprecated boolean
---@param DeprecationMessage string
---@param DeprecationRecommendation NiagaraScript
---@param bUsePythonScriptConversion boolean
---@param ConversionScriptExecution ENiagaraPythonUpdateScriptReference
---@param PythonConversionScript string
---@param ConversionScriptAsset FilePath
---@param ConversionUtility Class
---@param bExperimental boolean
---@param ExperimentalMessage string
---@param NoteMessage string
---@param DebugDrawMessage string
---@param LibraryVisibility ENiagaraScriptLibraryVisibility
---@param NumericOutputTypeSelectionMode ENiagaraNumericOutputTypeSelectionMode
---@param Description string
---@param Keywords string
---@param CollapsedViewFormat string
---@param InlineExpressionFormat NiagaraInlineDynamicInputFormatToken[]
---@param InlineGraphFormat NiagaraInlineDynamicInputFormatToken[]
---@param bCanBeUsedForTypeConversions boolean
---@param ScriptMetaData table<string, string>
---@param LastGeneratedVMId NiagaraVMExecutableDataId
---@param UpdateScriptExecution ENiagaraPythonUpdateScriptReference
---@param PythonUpdateScript string
---@param ScriptAsset FilePath
---@param ParameterDefinitionsSubscriptions ParameterDefinitionsSubscription[]
---@param InputSections NiagaraStackSection[]
---@param Source NiagaraScriptSourceBase
function VersionedNiagaraScriptData.new(Version, VersionChangeDescription, ModuleUsageBitmask, Category, AssetTagDefinitionReferences, bSuggested, ProvidedDependencies, RequiredDependencies, bDeprecated, DeprecationMessage, DeprecationRecommendation, bUsePythonScriptConversion, ConversionScriptExecution, PythonConversionScript, ConversionScriptAsset, ConversionUtility, bExperimental, ExperimentalMessage, NoteMessage, DebugDrawMessage, LibraryVisibility, NumericOutputTypeSelectionMode, Description, Keywords, CollapsedViewFormat, InlineExpressionFormat, InlineGraphFormat, bCanBeUsedForTypeConversions, ScriptMetaData, LastGeneratedVMId, UpdateScriptExecution, PythonUpdateScript, ScriptAsset, ParameterDefinitionsSubscriptions, InputSections, Source)
    local self = {}
    self.Version = Version
    self.VersionChangeDescription = VersionChangeDescription
    self.ModuleUsageBitmask = ModuleUsageBitmask
    self.Category = Category
    self.AssetTagDefinitionReferences = AssetTagDefinitionReferences
    self.bSuggested = bSuggested
    self.ProvidedDependencies = ProvidedDependencies
    self.RequiredDependencies = RequiredDependencies
    self.bDeprecated = bDeprecated
    self.DeprecationMessage = DeprecationMessage
    self.DeprecationRecommendation = DeprecationRecommendation
    self.bUsePythonScriptConversion = bUsePythonScriptConversion
    self.ConversionScriptExecution = ConversionScriptExecution
    self.PythonConversionScript = PythonConversionScript
    self.ConversionScriptAsset = ConversionScriptAsset
    self.ConversionUtility = ConversionUtility
    self.bExperimental = bExperimental
    self.ExperimentalMessage = ExperimentalMessage
    self.NoteMessage = NoteMessage
    self.DebugDrawMessage = DebugDrawMessage
    self.LibraryVisibility = LibraryVisibility
    self.NumericOutputTypeSelectionMode = NumericOutputTypeSelectionMode
    self.Description = Description
    self.Keywords = Keywords
    self.CollapsedViewFormat = CollapsedViewFormat
    self.InlineExpressionFormat = InlineExpressionFormat
    self.InlineGraphFormat = InlineGraphFormat
    self.bCanBeUsedForTypeConversions = bCanBeUsedForTypeConversions
    self.ScriptMetaData = ScriptMetaData
    self.LastGeneratedVMId = LastGeneratedVMId
    self.UpdateScriptExecution = UpdateScriptExecution
    self.PythonUpdateScript = PythonUpdateScript
    self.ScriptAsset = ScriptAsset
    self.ParameterDefinitionsSubscriptions = ParameterDefinitionsSubscriptions
    self.InputSections = InputSections
    self.Source = Source
    return self
end

return VersionedNiagaraScriptData
