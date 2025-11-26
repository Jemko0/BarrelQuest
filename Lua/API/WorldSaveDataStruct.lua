---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class WorldSaveDataStruct
---World Save Data Struct
---
--- Properties
---@field DestroyedTrees_7_FE9DA9A743048ABDF5C047AC5ACDACA1 table<Vector, integer>
---@field Subcontainers_17_A3C896AA47DC532158193AAA49D99A8B table<string, SavedSubcontainerStruct>
local WorldSaveDataStruct = {}

--- Constructor
---@return WorldSaveDataStruct
---@param DestroyedTrees_7_FE9DA9A743048ABDF5C047AC5ACDACA1 table<Vector, integer>
---@param Subcontainers_17_A3C896AA47DC532158193AAA49D99A8B table<string, SavedSubcontainerStruct>
function WorldSaveDataStruct.new(DestroyedTrees_7_FE9DA9A743048ABDF5C047AC5ACDACA1, Subcontainers_17_A3C896AA47DC532158193AAA49D99A8B)
    local self = {}
    self.DestroyedTrees_7_FE9DA9A743048ABDF5C047AC5ACDACA1 = DestroyedTrees_7_FE9DA9A743048ABDF5C047AC5ACDACA1
    self.Subcontainers_17_A3C896AA47DC532158193AAA49D99A8B = Subcontainers_17_A3C896AA47DC532158193AAA49D99A8B
    return self
end

return WorldSaveDataStruct
