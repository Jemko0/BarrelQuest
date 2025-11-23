---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class SceneCaptureComponent : SceneComponent
----> will be exported to EngineDecalClasses.h
---
--- Properties
---Controls what primitives get rendered into the scene capture.
---@field PrimitiveRenderMode ESceneCapturePrimitiveRenderMode
---@field CaptureSource integer
---Whether to update the capture's contents every frame.  If disabled, the component will render once on load and then only when moved.
---@field bCaptureEveryFrame boolean
---Whether to update the capture's contents on movement.  Disable if you are going to capture manually from blueprint.
---@field bCaptureOnMovement boolean
---Capture a GPU frame for this scene capture, next time it renders (capture program must be connected).
---@field bCaptureGpuNextRender boolean
---Run DumpGPU for this scene capture, next time it renders.
---@field bDumpGpuNextRender boolean
---Whether this capture should be excluded from tracking scene texture extents.  This should be set when this capture is not expected to be
---frequently used, especially if the capture resolution is very large.  Setting this for a single-use capture will avoid influencing other
---scene texture extent decisions and avoid a possible ongoing increase in memory usage.
---@field bExcludeFromSceneTextureExtents boolean
---Whether to persist the rendering state even if bCaptureEveryFrame==false.  This allows velocities for Motion Blur and Temporal AA to be computed.
---@field bAlwaysPersistRenderingState boolean
---The components won't rendered by current component.
---@field HiddenComponents any[]
---The actors to hide in the scene capture.
---@field HiddenActors Actor[]
---The only components to be rendered by this scene capture, if PrimitiveRenderMode is set to UseShowOnlyList.
---@field ShowOnlyComponents any[]
---The only actors to be rendered by this scene capture, if PrimitiveRenderMode is set to UseShowOnlyList.
---@field ShowOnlyActors Actor[]
---Scales the distance used by LOD. Set to values greater than 1 to cause the scene capture to use lower LODs than the main view to speed up the scene capture pass.
---@field LODDistanceFactor number
---if > 0, sets a maximum render distance override.  Can be used to cull distant objects from a reflection if the reflecting plane is in an enclosed area like a hallway or room
---@field MaxViewDistanceOverride number
---Capture priority within the frame to sort scene capture on GPU to resolve interdependencies between multiple capture components. Highest come first.
---@field CaptureSortPriority integer
---Whether to use ray tracing for this capture. Ray Tracing must be enabled in the project.
---@field bUseRayTracingIfEnabled boolean
---Store WorldToLocal and/or Projection matrices (2D capture only) to a Material Parameter Collection on render.
---@field CollectionTransform MaterialParameterCollection
---Parameter name of the first element of the transform in the CollectionTransform Material Parameter Collection set above.  Requires space for 5 vectors (large world coordinate transform).
---@field CollectionTransformWorldToLocal string
---Parameter name of the first element of the transform in the CollectionTransform Material Parameter Collection set above.  Requires space for 4 vectors.
---@field CollectionTransformProjection string
---View / light masking support.  Controls which lights should affect this view.
---@field ViewLightingChannels ViewLightingChannels
---@field ShowFlagSettings EngineShowFlagsSetting[]
---Name of the profiling event.
---@field ProfilingEventName string
---The mesh used by ProxyMeshComponent
---@field CaptureMesh StaticMesh
local SceneCaptureComponent = {}

--- Methods
---Adds the component to our list of show-only components.
---@param InComponent PrimitiveComponent
---@return nil
function SceneCaptureComponent.ShowOnlyComponent(InComponent) end

---Adds all primitive components in the actor to our list of show-only components.
---@param InActor Actor
---@param bIncludeFromChildActors boolean
---@return nil
function SceneCaptureComponent.ShowOnlyActorComponents(InActor, bIncludeFromChildActors) end

---Set the show flag settings.
---@return nil
function SceneCaptureComponent.SetShowFlagSettings() end

---Changes the value of TranslucentSortPriority.
---@param NewCaptureSortPriority integer
---@return nil
function SceneCaptureComponent.SetCaptureSortPriority(NewCaptureSortPriority) end

---Removes a component from the Show Only list.
---@param InComponent PrimitiveComponent
---@return nil
function SceneCaptureComponent.RemoveShowOnlyComponent(InComponent) end

---Removes an actor's components from the Show Only list.
---@param InActor Actor
---@param bIncludeFromChildActors boolean
---@return nil
function SceneCaptureComponent.RemoveShowOnlyActorComponents(InActor, bIncludeFromChildActors) end

---Adds the component to our list of hidden components.
---@param InComponent PrimitiveComponent
---@return nil
function SceneCaptureComponent.HideComponent(InComponent) end

---Adds all primitive components in the actor to our list of hidden components.
---@param InActor Actor
---@param bIncludeFromChildActors boolean
---@return nil
function SceneCaptureComponent.HideActorComponents(InActor, bIncludeFromChildActors) end

---Get the show flag settings.
---@return EngineShowFlagsSetting[]
function SceneCaptureComponent.GetShowFlagSettings() end

---Clears the Show Only list.
---@return nil
function SceneCaptureComponent.ClearShowOnlyComponents() end

---Clears the hidden list.
---@return nil
function SceneCaptureComponent.ClearHiddenComponents() end

return SceneCaptureComponent
