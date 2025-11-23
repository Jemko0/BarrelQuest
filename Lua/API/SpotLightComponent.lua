---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class SpotLightComponent : PointLightComponent
---A spot light component emits a directional cone shaped light (Eg a Torch).
---
--- Properties
---Degrees.
---@field InnerConeAngle number
---Degrees.
---@field OuterConeAngle number
local SpotLightComponent = {}

--- Methods
---Set Outer Cone Angle
---@param NewOuterConeAngle number
---@return nil
function SpotLightComponent.SetOuterConeAngle(NewOuterConeAngle) end

---Set Inner Cone Angle
---@param NewInnerConeAngle number
---@return nil
function SpotLightComponent.SetInnerConeAngle(NewInnerConeAngle) end

return SpotLightComponent
