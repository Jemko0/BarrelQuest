---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class PostProcessVolume : Volume
---for FPostprocessSettings
---
--- Properties
---
---Post process settings to use for this volume.
---@field Settings PostProcessSettings
---Priority of this volume. In the case of overlapping volumes the one with the highest priority
---overrides the lower priority ones. The order is undefined if two or more overlapping volumes have the same priority.
---@field Priority number
---World space radius around the volume that is used for blending (only if not unbound).
---@field BlendRadius number
---0:no effect, 1:full effect
---@field BlendWeight number
---Whether this volume is enabled or not.
---@field bEnabled boolean
---Whether this volume covers the whole world, or just the area inside its bounds.
---@field bUnbound boolean
local PostProcessVolume = {}

--- Methods
---Adds an Blendable (implements IBlendableInterface) to the array of Blendables (if it doesn't exist) and update the weight
---@param InBlendableObject any
---@param InWeight number
---@return nil
function PostProcessVolume.AddOrUpdateBlendable(InBlendableObject, InWeight) end

return PostProcessVolume
