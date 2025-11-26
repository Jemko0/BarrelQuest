---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class SparseVolumeTextureParameterValue
---Editable sparse volume texture parameter.
---
--- Properties
---
---@field ParameterInfo MaterialParameterInfo
---@field ParameterValue SparseVolumeTexture
---@field ExpressionGUID Guid
local SparseVolumeTextureParameterValue = {}

--- Constructor
---@return SparseVolumeTextureParameterValue
---@param ParameterInfo MaterialParameterInfo
---@param ParameterValue SparseVolumeTexture
---@param ExpressionGUID Guid
function SparseVolumeTextureParameterValue.new(ParameterInfo, ParameterValue, ExpressionGUID)
    local self = {}
    self.ParameterInfo = ParameterInfo
    self.ParameterValue = ParameterValue
    self.ExpressionGUID = ExpressionGUID
    return self
end

return SparseVolumeTextureParameterValue
