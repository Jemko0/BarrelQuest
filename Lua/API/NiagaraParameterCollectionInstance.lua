---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class NiagaraParameterCollectionInstance
---Can be used to override selected parameters from a Niagara parameter collection with another value.
---The values in the parameter collection instance can be set from Blueprint or C++, same as the regular parameter collection.
---
--- Properties
---TODO: Abstract to some interface to allow a hierarchy like UMaterialInstance?
---@field Collection NiagaraParameterCollection
---When editing instances, we must track which parameters are overridden so we can pull in any changes to the default.
---@field OverridenParameters NiagaraVariable[]
local NiagaraParameterCollectionInstance = {}

--- Methods
---Set Vector Parameter
---@param InVariableName string
---@param InValue Vector
---@return nil
function NiagaraParameterCollectionInstance.SetVectorParameter(InVariableName, InValue) end

---TODO[mg]: add position setter for LWC
---@param InVariableName string
---@return nil
function NiagaraParameterCollectionInstance.SetVector4Parameter(InVariableName) end

---Set Vector 2DParameter
---@param InVariableName string
---@param InValue Vector2D
---@return nil
function NiagaraParameterCollectionInstance.SetVector2DParameter(InVariableName, InValue) end

---Set Quat Parameter
---@param InVariableName string
---@return nil
function NiagaraParameterCollectionInstance.SetQuatParameter(InVariableName) end

---Set Int Parameter
---@param InVariableName string
---@param InValue integer
---@return nil
function NiagaraParameterCollectionInstance.SetIntParameter(InVariableName, InValue) end

---Set Float Parameter
---@param InVariableName string
---@param InValue number
---@return nil
function NiagaraParameterCollectionInstance.SetFloatParameter(InVariableName, InValue) end

---Set Color Parameter
---@param InVariableName string
---@param InValue LinearColor
---@return nil
function NiagaraParameterCollectionInstance.SetColorParameter(InVariableName, InValue) end

---Set Bool Parameter
---@param InVariableName string
---@param InValue boolean
---@return nil
function NiagaraParameterCollectionInstance.SetBoolParameter(InVariableName, InValue) end

---Get Vector Parameter
---@param InVariableName string
---@return Vector
function NiagaraParameterCollectionInstance.GetVectorParameter(InVariableName) end

---Get Vector 4Parameter
---@param InVariableName string
---@return Vector4
function NiagaraParameterCollectionInstance.GetVector4Parameter(InVariableName) end

---Get Vector 2DParameter
---@param InVariableName string
---@return Vector2D
function NiagaraParameterCollectionInstance.GetVector2DParameter(InVariableName) end

---Get Quat Parameter
---@param InVariableName string
---@return Quat
function NiagaraParameterCollectionInstance.GetQuatParameter(InVariableName) end

---Get Int Parameter
---@param InVariableName string
---@return integer
function NiagaraParameterCollectionInstance.GetIntParameter(InVariableName) end

---Get Float Parameter
---@param InVariableName string
---@return number
function NiagaraParameterCollectionInstance.GetFloatParameter(InVariableName) end

---Get Color Parameter
---@param InVariableName string
---@return LinearColor
function NiagaraParameterCollectionInstance.GetColorParameter(InVariableName) end

---Accessors from Blueprint. For now just exposing common types but ideally we can expose any somehow in future.
---@param InVariableName string
---@return boolean
function NiagaraParameterCollectionInstance.GetBoolParameter(InVariableName) end

return NiagaraParameterCollectionInstance
