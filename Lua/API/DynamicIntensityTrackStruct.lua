---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class DynamicIntensityTrackStruct
---Dynamic Intensity Track Struct
---
--- Properties
---
---@field protected Layers_6_4310ACCC40B767D6C809BA8C3D91B93E table<integer, SoundBase>
local DynamicIntensityTrackStruct = {}

--- Constructor
---@return DynamicIntensityTrackStruct
---@param Layers_6_4310ACCC40B767D6C809BA8C3D91B93E table<integer, SoundBase>
function DynamicIntensityTrackStruct.new(Layers_6_4310ACCC40B767D6C809BA8C3D91B93E)
    local self = {}
    self.Layers_6_4310ACCC40B767D6C809BA8C3D91B93E = Layers_6_4310ACCC40B767D6C809BA8C3D91B93E
    return self
end

return DynamicIntensityTrackStruct
