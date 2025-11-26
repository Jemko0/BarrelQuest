---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class NiagaraVMExecutableDataId
---Struct containing all of the data necessary to look up a NiagaraScript's VM executable results from the Derived Data Cache.
---
--- Properties
---The version of the compiler that this needs to be built against.
---@field CompilerVersionID Guid
---Do we require interpolated spawning
---@field InterpolatedSpawnMode ENiagaraInterpolatedSpawnMode
---The instance id of this script usage type.
---@field ScriptUsageTypeID Guid
---The type of script this was used for.
---@field ScriptUsageType ENiagaraScriptUsage
---Configuration options
---@field AdditionalDefines string[]
---@field AdditionalVariables NiagaraVariableBase[]
---Whether or not we allow debug switches to be used.
---@field bDisableDebugSwitches boolean
---Do we require persistent IDs
---@field bRequiresPersistentIDs boolean
---Whether or not we need to bake Rapid Iteration params. True to keep params, false to bake.
---@field bUsesRapidIterationParams boolean
---The hash of the subgraph this shader primarily represents.
---@field BaseScriptCompileHash NiagaraCompileHash
---Compile hashes of any top level scripts the script was dependent on that might trigger a recompile if they change.
---@field ReferencedCompileHashes NiagaraCompileHash[]
---The version of the script that was compiled. If empty then just the latest version.
---@field ScriptVersionID Guid
local NiagaraVMExecutableDataId = {}

--- Constructor
---@return NiagaraVMExecutableDataId
---@param CompilerVersionID Guid
---@param InterpolatedSpawnMode ENiagaraInterpolatedSpawnMode
---@param ScriptUsageTypeID Guid
---@param ScriptUsageType ENiagaraScriptUsage
---@param AdditionalDefines string[]
---@param AdditionalVariables NiagaraVariableBase[]
---@param bDisableDebugSwitches boolean
---@param bRequiresPersistentIDs boolean
---@param bUsesRapidIterationParams boolean
---@param BaseScriptCompileHash NiagaraCompileHash
---@param ReferencedCompileHashes NiagaraCompileHash[]
---@param ScriptVersionID Guid
function NiagaraVMExecutableDataId.new(CompilerVersionID, InterpolatedSpawnMode, ScriptUsageTypeID, ScriptUsageType, AdditionalDefines, AdditionalVariables, bDisableDebugSwitches, bRequiresPersistentIDs, bUsesRapidIterationParams, BaseScriptCompileHash, ReferencedCompileHashes, ScriptVersionID)
    local self = {}
    self.CompilerVersionID = CompilerVersionID
    self.InterpolatedSpawnMode = InterpolatedSpawnMode
    self.ScriptUsageTypeID = ScriptUsageTypeID
    self.ScriptUsageType = ScriptUsageType
    self.AdditionalDefines = AdditionalDefines
    self.AdditionalVariables = AdditionalVariables
    self.bDisableDebugSwitches = bDisableDebugSwitches
    self.bRequiresPersistentIDs = bRequiresPersistentIDs
    self.bUsesRapidIterationParams = bUsesRapidIterationParams
    self.BaseScriptCompileHash = BaseScriptCompileHash
    self.ReferencedCompileHashes = ReferencedCompileHashes
    self.ScriptVersionID = ScriptVersionID
    return self
end

return NiagaraVMExecutableDataId
