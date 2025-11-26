---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class SpecularProfileStruct
---struct with all the settings we want in USpecularProfile, separate to make it easer to pass this data around in the engine.
---
--- Properties
---Define the format driving the sampling of the specular LUT.
---@field Format ESpecularProfileFormat
---Define the view facing color.
---Exemple with View/Light mode: color at 0 is applied when NoV=0 (view grazing angle)  while color at 1 is applied when NoV=1 (view facing angle).
---@field ViewColor RuntimeCurveLinearColor
---Define the light facing color
---Exemple with View/Light mode: color at 0 is applied when NoL=0 (light hit the surface at grazing angle)  while color at 1 is applied when NoV=1 (light hit the surface at facing angle).
---@field LightColor RuntimeCurveLinearColor
---Define the texture used as a specular profile
---@field Texture Texture2D
local SpecularProfileStruct = {}

--- Constructor
---@return SpecularProfileStruct
---@param Format ESpecularProfileFormat
---@param ViewColor RuntimeCurveLinearColor
---@param LightColor RuntimeCurveLinearColor
---@param Texture Texture2D
function SpecularProfileStruct.new(Format, ViewColor, LightColor, Texture)
    local self = {}
    self.Format = Format
    self.ViewColor = ViewColor
    self.LightColor = LightColor
    self.Texture = Texture
    return self
end

return SpecularProfileStruct
