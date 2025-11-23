---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class DecalComponent : SceneComponent
---A material that is rendered onto the surface of a mesh. A kind of 'bumper sticker' for a model.
---@see https://docs.unrealengine.com/latest/INT/Engine/Actors/DecalActor
---@see UDecalActor
---
--- Properties
---Decal material.
---@field DecalMaterial MaterialInterface
---Controls the order in which decal elements are rendered.  Higher values draw later (on top).
---Setting many different sort orders on many different decals prevents sorting by state and can reduce performance.
---@field SortOrder integer
---@field FadeScreenSize number
---Time in seconds to wait before beginning to fade out the decal. Set fade duration and start delay to 0 to make persistent.
---@field FadeStartDelay number
---Time in seconds for the decal to fade out. Set fade duration and start delay to 0 to make persistent. Only fades in active simulation or game.
---@field FadeDuration number
---@field FadeInDuration number
---@field FadeInStartDelay number
---Automatically destroys the owning actor after fully fading out.
---@field bDestroyOwnerAfterFade boolean
---Decal size in local space (does not include the component scale), technically redundant but there for convenience
---@field DecalSize Vector
---Decal color, can be accessed using the material Decal Color node.
---@field DecalColor LinearColor
local DecalComponent = {}

--- Methods
---Sets the sort order for the decal component. Higher values draw later (on top). This will force the decal to reattach
---@param Value integer
---@return nil
function DecalComponent.SetSortOrder(Value) end

---Set the FadeScreenSize for this decal component
---@param NewFadeScreenSize number
---@return nil
function DecalComponent.SetFadeScreenSize(NewFadeScreenSize) end

---Sets the decal's fade start time, duration and if the owning actor should be destroyed after the decal is fully faded out.
---The default value of 0 for FadeStartDelay and FadeDuration makes the decal persistent. See DecalLifetimeOpacity material
---node to control the look of "fading out."
---@param StartDelay number
---@param Duration number
---@param DestroyOwnerAfterFade boolean
---@return nil
function DecalComponent.SetFadeOut(StartDelay, Duration, DestroyOwnerAfterFade) end

---Set Fade In
---@param StartDelay number
---@param Duration number
---@return nil
function DecalComponent.SetFadeIn(StartDelay, Duration) end

---setting decal material on decal component. This will force the decal to reattach
---@param NewDecalMaterial MaterialInterface
---@return nil
function DecalComponent.SetDecalMaterial(NewDecalMaterial) end

---Sets the decal color.
---@return nil
function DecalComponent.SetDecalColor() end

---Get Fade Start Delay
---@return number
function DecalComponent.GetFadeStartDelay() end

---Get Fade in Start Delay
---@return number
function DecalComponent.GetFadeInStartDelay() end

---Get Fade in Duration
---@return number
function DecalComponent.GetFadeInDuration() end

---Get Fade Duration
---@return number
function DecalComponent.GetFadeDuration() end

---Accessor for decal material
---@return MaterialInterface
function DecalComponent.GetDecalMaterial() end

---Utility to allocate a new Dynamic Material Instance, set its parent to the currently applied material, and assign it
---@return MaterialInstanceDynamic
function DecalComponent.CreateDynamicMaterialInstance() end

return DecalComponent
