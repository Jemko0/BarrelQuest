---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class BPVariableMetaDataEntry
---One metadata entry for a variable
---
--- Properties
---Name of metadata key
---@field DataKey string
---Name of metadata value
---@field DataValue string
local BPVariableMetaDataEntry = {}

--- Constructor
---@return BPVariableMetaDataEntry
---@param DataKey string
---@param DataValue string
function BPVariableMetaDataEntry.new(DataKey, DataValue)
    local self = {}
    self.DataKey = DataKey
    self.DataValue = DataValue
    return self
end

return BPVariableMetaDataEntry
