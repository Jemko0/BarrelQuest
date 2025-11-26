---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class BPInterfaceDescription
---Struct containing information about what interfaces are implemented in this blueprint
---
--- Properties
---Reference to the interface class we're adding to this blueprint
---@field Interface Class
---References to the graphs associated with the required functions for this interface
---@field Graphs EdGraph[]
local BPInterfaceDescription = {}

--- Constructor
---@return BPInterfaceDescription
---@param Interface Class
---@param Graphs EdGraph[]
function BPInterfaceDescription.new(Interface, Graphs)
    local self = {}
    self.Interface = Interface
    self.Graphs = Graphs
    return self
end

return BPInterfaceDescription
