---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class AutoThumbnail_C : Actor
---Auto Thumbnail
---
--- Properties
---
---@field UberGraphFrame PointerToUberGraphFrame
---@field SpotLight SpotLightComponent
---@field Cube StaticMeshComponent
---@field SceneCaptureComponent2D SceneCaptureComponent2D
---@field SpringArm SpringArmComponent
---@field DefaultSceneRoot SceneComponent
---@field FinishedLoading FinishedLoadingDelegate
local AutoThumbnail_C = {}

--- Methods
return AutoThumbnail_C
