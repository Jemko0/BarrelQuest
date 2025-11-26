---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class EdGraph
---Ed Graph
---
--- Properties
---
---The schema that this graph obeys
---@field Schema Class
---Set of all nodes in this graph
---@field Nodes EdGraphNode[]
---If true, graph can be edited by the user
---@field bEditable boolean
---If true, graph can be deleted from the whatever container it is in. For FunctionGraphs
---this flag is reset to false on load (unless the function is the construction script or
---AnimGraph)
---@field bAllowDeletion boolean
---If true, graph can be renamed; Note: Graph can also be renamed if bAllowDeletion is true currently
---@field bAllowRenaming boolean
---Child graphs that are a part of this graph; the separation is purely visual
---@field SubGraphs EdGraph[]
---Guid for this graph
---@field GraphGuid Guid
---Guid of interface graph this graph comes from (used for conforming)
---@field InterfaceGuid Guid
local EdGraph = {}

--- Methods
return EdGraph
