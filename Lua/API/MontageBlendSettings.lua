---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class MontageBlendSettings
---Montage blend settings. Can be used to overwrite default Montage settings on Play/Stop
---
--- Properties
---Blend Profile to use for this blend
---@field BlendProfile BlendProfile
---AlphaBlend options (time, curve, etc.)
---@field Blend AlphaBlendArgs
---Type of blend mode (Standard vs Inertial)
---@field BlendMode EMontageBlendMode
local MontageBlendSettings = {}

--- Constructor
---@return MontageBlendSettings
---@param BlendProfile BlendProfile
---@param Blend AlphaBlendArgs
---@param BlendMode EMontageBlendMode
function MontageBlendSettings.new(BlendProfile, Blend, BlendMode)
    local self = {}
    self.BlendProfile = BlendProfile
    self.Blend = Blend
    self.BlendMode = BlendMode
    return self
end

return MontageBlendSettings
