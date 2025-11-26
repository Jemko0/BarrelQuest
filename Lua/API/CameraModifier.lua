---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class CameraModifier
---A CameraModifier is a base class for objects that may adjust the final camera properties after
---being computed by the APlayerCameraManager (@see ModifyCamera). A CameraModifier
---can be stateful, and is associated uniquely with a specific APlayerCameraManager.
---
--- Properties
---If true, enables certain debug visualization features.
---@field bDebug boolean
---If true, no other modifiers of same priority allowed.
---@field bExclusive boolean
---Priority value that determines the order in which modifiers are applied. 0 = highest priority, 255 = lowest.
---@field Priority integer
---Camera this object is associated with.
---@field CameraOwner PlayerCameraManager
---When blending in, alpha proceeds from 0 to 1 over this time
---@field AlphaInTime number
---When blending out, alpha proceeds from 1 to 0 over this time
---@field AlphaOutTime number
---Current blend alpha.
---@field Alpha number
local CameraModifier = {}

--- Methods
---@return boolean
function CameraModifier.IsPendingDisable() end

---@return boolean
function CameraModifier.IsDisabled() end

---@return Actor
function CameraModifier.GetViewTarget() end

---Enables this modifier.
---@return nil
function CameraModifier.EnableModifier() end

---Disables this modifier.
---@param bImmediate boolean
---@return nil
function CameraModifier.DisableModifier(bImmediate) end

return CameraModifier
