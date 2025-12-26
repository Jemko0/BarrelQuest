---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class CameraShakeSourceComponent : SceneComponent
---Camera Shake Source Component
---
--- Properties
---
---The attenuation profile for how camera shakes' intensity falls off with distance
---@field Attenuation ECameraShakeAttenuation
---Under this distance from the source, the camera shakes are at full intensity
---@field InnerAttenuationRadius number
---Outside of this distance from the source, the camera shakes don't apply at all
---@field OuterAttenuationRadius number
---The camera shake class to use for this camera shake source actor
---@field CameraShake Class
---Whether to auto start when created
---@field bAutoStart boolean
---Sprite to display in the editor.
---@field EditorSpriteTexture Texture2D
---Sprite scaling for display in the editor.
---@field EditorSpriteTextureScale number
local CameraShakeSourceComponent = {}

--- Methods
---Stops a camera shake originating from this source
---@param InCameraShake Class
---@param bImmediately boolean
---@return nil
function CameraShakeSourceComponent.StopAllCameraShakesOfType(InCameraShake, bImmediately) end

---Stops all currently active camera shakes that are originating from this source from all player controllers
---@param bImmediately boolean
---@return nil
function CameraShakeSourceComponent.StopAllCameraShakes(bImmediately) end

---Starts a new camera shake originating from this source, and apply it on all player controllers
---@param InCameraShake Class
---@param Scale number
---@param PlaySpace ECameraShakePlaySpace
---@param UserPlaySpaceRot Rotator
---@return nil
function CameraShakeSourceComponent.StartCameraShake(InCameraShake, Scale, PlaySpace, UserPlaySpaceRot) end

---Start
---@return nil
function CameraShakeSourceComponent.Start() end

---Computes an attenuation factor from this source
---@return number
function CameraShakeSourceComponent.GetAttenuationFactor() end

return CameraShakeSourceComponent
