---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class CameraShakeBase
---Base class for a camera shake. A camera shake contains a root shake "pattern" which is
---the object that contains the actual logic driving how the camera is shaken. Keeping the two
---separate makes it possible to completely change how a shake works without having to create
---a completely different asset.
---
--- Properties
---
---If true to only allow a single instance of this shake class to play at any given time.
---Subsequent attempts to play this shake will simply restart the timer.
---@field bSingleInstance boolean
---The overall scale to apply to the shake. Only valid when the shake is active.
---@field ShakeScale number
local CameraShakeBase = {}

--- Methods
---Sets the root pattern of this camera shake
---@param InPattern CameraShakePattern
---@return nil
function CameraShakeBase.SetRootShakePattern(InPattern) end

---Gets the root pattern of this camera shake
---@return CameraShakePattern
function CameraShakeBase.GetRootShakePattern() end

return CameraShakeBase
