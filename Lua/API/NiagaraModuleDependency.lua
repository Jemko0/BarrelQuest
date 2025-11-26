---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class NiagaraModuleDependency
---Niagara Module Dependency
---
--- Properties
---
---Specifies the provided id of the required dependent module (e.g. 'ProvidesNormalizedAge')
---@field Id string
---Whether the dependency belongs before or after this module
---@field Type ENiagaraModuleDependencyType
---Specifies constraints related to the source script a modules provides as dependency.
---@field ScriptConstraint ENiagaraModuleDependencyScriptConstraint
---Specifies the version constraint that module providing the dependency must fulfill.
---Example usages:
---'1.2' requires the exact version 1.2 of the source script
---'1.2+' requires at least version 1.2, but any higher version is also ok
---'1.2-2.0' requires any version between 1.2 and 2.0
---@field RequiredVersion string
---This property can limit where the dependency is evaluated. By default, the dependency is enforced in all script usages
---@field OnlyEvaluateInScriptUsage integer
---Detailed description of the dependency
---@field Description string
local NiagaraModuleDependency = {}

--- Constructor
---@return NiagaraModuleDependency
---@param Id string
---@param Type ENiagaraModuleDependencyType
---@param ScriptConstraint ENiagaraModuleDependencyScriptConstraint
---@param RequiredVersion string
---@param OnlyEvaluateInScriptUsage integer
---@param Description string
function NiagaraModuleDependency.new(Id, Type, ScriptConstraint, RequiredVersion, OnlyEvaluateInScriptUsage, Description)
    local self = {}
    self.Id = Id
    self.Type = Type
    self.ScriptConstraint = ScriptConstraint
    self.RequiredVersion = RequiredVersion
    self.OnlyEvaluateInScriptUsage = OnlyEvaluateInScriptUsage
    self.Description = Description
    return self
end

return NiagaraModuleDependency
