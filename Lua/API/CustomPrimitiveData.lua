---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class CustomPrimitiveData
---Custom primitive data payload.
---
--- Properties
---
---@field Data number[]
local CustomPrimitiveData = {}

--- Constructor
---@return CustomPrimitiveData
---@param Data number[]
function CustomPrimitiveData.new(Data)
    local self = {}
    self.Data = Data
    return self
end

return CustomPrimitiveData
