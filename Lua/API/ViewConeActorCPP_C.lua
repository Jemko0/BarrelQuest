---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class ViewConeActorCPP_C : ViewConeActor
---View Cone Actor CPP
---
--- Properties
---@field UberGraphFrame PointerToUberGraphFrame
---@field VisibleActors table<Object, boolean>
---@field Visible table<Actor, boolean>
---@field NonVisible table<Actor, boolean>
local ViewConeActorCPP_C = {}

--- Methods
---Run Debug
---@return nil
function ViewConeActorCPP_C.RunDebug() end

---Tick Visibility Fade
---@return nil
function ViewConeActorCPP_C.TickVisibilityFade() end

---Update Viewing Actors
---@return nil
function ViewConeActorCPP_C.UpdateViewingActors() end

---Get Visible Actors
---@return nil, table<Actor, boolean>
function ViewConeActorCPP_C.GetVisibleActors() end

---Set Visible State
---@param A Object
---@param Value boolean
---@return nil
function ViewConeActorCPP_C.SetVisibleState(A, Value) end

---Update View Cone Properties
---@return nil
function ViewConeActorCPP_C.UpdateViewConeProperties() end

---Construction script, the place to spawn components and do other setup.
---@note Name used in CreateBlueprint function
---@return nil
function ViewConeActorCPP_C.UserConstructionScript() end

---Settings Updated
---@param NewSettings UserSettingsStruct
---@return nil
function ViewConeActorCPP_C.SettingsUpdated(NewSettings) end

return ViewConeActorCPP_C
