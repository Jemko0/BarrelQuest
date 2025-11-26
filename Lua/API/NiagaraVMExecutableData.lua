---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class NiagaraVMExecutableData
---Struct containing all of the data needed to run a Niagara VM executable script.
---
--- Properties
---
---Byte code to execute for this system.
---@field ByteCode NiagaraVMExecutableByteCode
---Optimized version of the byte code to execute for this system
---@field OptimizedByteCode NiagaraVMExecutableByteCode
---Number of temp registers used by this script.
---@field NumTempRegisters integer
---Number of user pointers we must pass to the VM.
---@field NumUserPtrs integer
---All the data for using external constants in the script, laid out in the order they are expected in the uniform table.
---@field Parameters NiagaraParameters
---All the data for using external constants in the script, laid out in the order they are expected in the uniform table.
---@field InternalParameters NiagaraParameters
---List of all external dependencies of this script. If not met, linking should result in an error.
---@field ExternalDependencies NiagaraCompileDependency[]
---The default set of rapid iteration parameters defined by the script that this data represents.  In the case of baked
---          in RI parameters this will be the values that are baked in, otherwise it will be the set of defaults based on the graphs.
---@field BakedRapidIterationParameters NiagaraVariable[]
---@field CompileTagsEditorOnly NiagaraCompilerTag[]
---@field CompileTags NiagaraCompilerTag[]
---@field ScriptLiterals integer[]
---Attributes used by this script.
---@field Attributes NiagaraVariableBase[]
---Contains various usage information for this script.
---@field DataUsage NiagaraScriptDataUsageInfo
---@field DataSetToParameters table<string, NiagaraParameters>
---@field AdditionalExternalFunctions NiagaraFunctionSignature[]
---Information about all the UObjects used by this script.
---@field UObjectInfos NiagaraScriptUObjectCompileInfo[]
---Information about all data interfaces used by this script.
---@field DataInterfaceInfo NiagaraScriptDataInterfaceCompileInfo[]
---Array of ordered vm external functions to place in the function table.
---@field CalledVMExternalFunctions VMExternalFunctionBindingInfo[]
---@field ReadDataSets NiagaraDataSetID[]
---@field WriteDataSets NiagaraDataSetProperties[]
---Scopes we'll track with stats.
---@field StatScopes NiagaraStatScope[]
---@field LastHlslTranslation string
---Note that this is currently needed to be non-transient because of how we kick off compilation of GPUComputeScripts
---@field LastHlslTranslationGPU string
---@field LastAssemblyTranslation string
---@field LastOpCount integer
---@field ShaderScriptParametersMetadata NiagaraShaderScriptParametersMetadata
---The parameter collections used by this script.
---@field ParameterCollectionPaths string[]
---Last known compile status. Lets us determine the latest state of the script byte buffer.
---@field LastCompileStatus ENiagaraScriptCompileStatus
---@field SimulationStageMetaData SimulationStageMetaData[]
---@field bReadsAttributeData boolean
---List of all attributes explicitly written by this VM script graph. Used to verify external dependencies.
---@field AttributesWritten NiagaraVariableBase[]
---List of all attributes explicitly written by this VM script graph. Used to verify external dependencies.
---@field StaticVariablesWritten NiagaraVariable[]
---@field ErrorMsg string
---Array of all compile events generated last time the script was compiled.
---@field LastCompileEvents NiagaraCompileEvent[]
---@field ExperimentalContextData integer[]
---@field LastExperimentalAssemblyScript string
---@field bReadsSignificanceIndex boolean
---@field bNeedsGPUContextInit boolean
local NiagaraVMExecutableData = {}

--- Constructor
---@return NiagaraVMExecutableData
---@param ByteCode NiagaraVMExecutableByteCode
---@param OptimizedByteCode NiagaraVMExecutableByteCode
---@param NumTempRegisters integer
---@param NumUserPtrs integer
---@param Parameters NiagaraParameters
---@param InternalParameters NiagaraParameters
---@param ExternalDependencies NiagaraCompileDependency[]
---@param BakedRapidIterationParameters NiagaraVariable[]
---@param CompileTagsEditorOnly NiagaraCompilerTag[]
---@param CompileTags NiagaraCompilerTag[]
---@param ScriptLiterals integer[]
---@param Attributes NiagaraVariableBase[]
---@param DataUsage NiagaraScriptDataUsageInfo
---@param DataSetToParameters table<string, NiagaraParameters>
---@param AdditionalExternalFunctions NiagaraFunctionSignature[]
---@param UObjectInfos NiagaraScriptUObjectCompileInfo[]
---@param DataInterfaceInfo NiagaraScriptDataInterfaceCompileInfo[]
---@param CalledVMExternalFunctions VMExternalFunctionBindingInfo[]
---@param ReadDataSets NiagaraDataSetID[]
---@param WriteDataSets NiagaraDataSetProperties[]
---@param StatScopes NiagaraStatScope[]
---@param LastHlslTranslation string
---@param LastHlslTranslationGPU string
---@param LastAssemblyTranslation string
---@param LastOpCount integer
---@param ShaderScriptParametersMetadata NiagaraShaderScriptParametersMetadata
---@param ParameterCollectionPaths string[]
---@param LastCompileStatus ENiagaraScriptCompileStatus
---@param SimulationStageMetaData SimulationStageMetaData[]
---@param bReadsAttributeData boolean
---@param AttributesWritten NiagaraVariableBase[]
---@param StaticVariablesWritten NiagaraVariable[]
---@param ErrorMsg string
---@param LastCompileEvents NiagaraCompileEvent[]
---@param ExperimentalContextData integer[]
---@param LastExperimentalAssemblyScript string
---@param bReadsSignificanceIndex boolean
---@param bNeedsGPUContextInit boolean
function NiagaraVMExecutableData.new(ByteCode, OptimizedByteCode, NumTempRegisters, NumUserPtrs, Parameters, InternalParameters, ExternalDependencies, BakedRapidIterationParameters, CompileTagsEditorOnly, CompileTags, ScriptLiterals, Attributes, DataUsage, DataSetToParameters, AdditionalExternalFunctions, UObjectInfos, DataInterfaceInfo, CalledVMExternalFunctions, ReadDataSets, WriteDataSets, StatScopes, LastHlslTranslation, LastHlslTranslationGPU, LastAssemblyTranslation, LastOpCount, ShaderScriptParametersMetadata, ParameterCollectionPaths, LastCompileStatus, SimulationStageMetaData, bReadsAttributeData, AttributesWritten, StaticVariablesWritten, ErrorMsg, LastCompileEvents, ExperimentalContextData, LastExperimentalAssemblyScript, bReadsSignificanceIndex, bNeedsGPUContextInit)
    local self = {}
    self.ByteCode = ByteCode
    self.OptimizedByteCode = OptimizedByteCode
    self.NumTempRegisters = NumTempRegisters
    self.NumUserPtrs = NumUserPtrs
    self.Parameters = Parameters
    self.InternalParameters = InternalParameters
    self.ExternalDependencies = ExternalDependencies
    self.BakedRapidIterationParameters = BakedRapidIterationParameters
    self.CompileTagsEditorOnly = CompileTagsEditorOnly
    self.CompileTags = CompileTags
    self.ScriptLiterals = ScriptLiterals
    self.Attributes = Attributes
    self.DataUsage = DataUsage
    self.DataSetToParameters = DataSetToParameters
    self.AdditionalExternalFunctions = AdditionalExternalFunctions
    self.UObjectInfos = UObjectInfos
    self.DataInterfaceInfo = DataInterfaceInfo
    self.CalledVMExternalFunctions = CalledVMExternalFunctions
    self.ReadDataSets = ReadDataSets
    self.WriteDataSets = WriteDataSets
    self.StatScopes = StatScopes
    self.LastHlslTranslation = LastHlslTranslation
    self.LastHlslTranslationGPU = LastHlslTranslationGPU
    self.LastAssemblyTranslation = LastAssemblyTranslation
    self.LastOpCount = LastOpCount
    self.ShaderScriptParametersMetadata = ShaderScriptParametersMetadata
    self.ParameterCollectionPaths = ParameterCollectionPaths
    self.LastCompileStatus = LastCompileStatus
    self.SimulationStageMetaData = SimulationStageMetaData
    self.bReadsAttributeData = bReadsAttributeData
    self.AttributesWritten = AttributesWritten
    self.StaticVariablesWritten = StaticVariablesWritten
    self.ErrorMsg = ErrorMsg
    self.LastCompileEvents = LastCompileEvents
    self.ExperimentalContextData = ExperimentalContextData
    self.LastExperimentalAssemblyScript = LastExperimentalAssemblyScript
    self.bReadsSignificanceIndex = bReadsSignificanceIndex
    self.bNeedsGPUContextInit = bNeedsGPUContextInit
    return self
end

return NiagaraVMExecutableData
