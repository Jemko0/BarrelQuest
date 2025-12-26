---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class StaticMeshDescription : MeshDescriptionBase
---A wrapper for MeshDescription, customized for static meshes
---
--- Properties
---
local StaticMeshDescription = {}

--- Methods
---Set Vertex Instance UV
---@param VertexInstanceID VertexInstanceID
---@param UV Vector2D
---@param UVIndex integer
---@return nil
function StaticMeshDescription.SetVertexInstanceUV(VertexInstanceID, UV, UVIndex) end

---Set Polygon Group Material Slot Name
---@param PolygonGroupID PolygonGroupID
---@return nil
function StaticMeshDescription.SetPolygonGroupMaterialSlotName(PolygonGroupID) end

---Get Vertex Instance UV
---@param VertexInstanceID VertexInstanceID
---@param UVIndex integer
---@return Vector2D
function StaticMeshDescription.GetVertexInstanceUV(VertexInstanceID, UVIndex) end

---Create Cube
---@param Center Vector
---@param HalfExtents Vector
---@param PolygonGroup PolygonGroupID
---@return nil, PolygonID, PolygonID, PolygonID, PolygonID, PolygonID, PolygonID
function StaticMeshDescription.CreateCube(Center, HalfExtents, PolygonGroup) end

return StaticMeshDescription
