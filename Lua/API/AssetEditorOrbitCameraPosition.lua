---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class AssetEditorOrbitCameraPosition
---Asset Editor Orbit Camera Position
---
--- Properties
---Whether or not this has been set to a valid value
---@field bIsSet boolean
---The position to orbit the camera around
---@field CamOrbitPoint Vector
---The distance of the camera from the orbit point
---@field CamOrbitZoom Vector
---The rotation to apply around the orbit point
---@field CamOrbitRotation Rotator
local AssetEditorOrbitCameraPosition = {}

--- Constructor
---@return AssetEditorOrbitCameraPosition
---@param bIsSet boolean
---@param CamOrbitPoint Vector
---@param CamOrbitZoom Vector
---@param CamOrbitRotation Rotator
function AssetEditorOrbitCameraPosition.new(bIsSet, CamOrbitPoint, CamOrbitZoom, CamOrbitRotation)
    local self = {}
    self.bIsSet = bIsSet
    self.CamOrbitPoint = CamOrbitPoint
    self.CamOrbitZoom = CamOrbitZoom
    self.CamOrbitRotation = CamOrbitRotation
    return self
end

return AssetEditorOrbitCameraPosition
