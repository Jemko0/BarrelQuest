---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class DebugCameraController : PlayerController
---Camera controller that allows you to fly around a level mostly unrestricted by normal movement rules.
---To turn it on, please press Alt+C or both (left and right) analogs on XBox pad,
---or use the "ToggleDebugCamera" console command. Check the debug camera bindings
---in DefaultPawn.cpp for the camera controls.
---
--- Properties
---Whether to show information about the selected actor on the debug camera HUD.
---@field bShowSelectedInfo boolean
---Saves whether the FreezeRendering console command is active
---@field bIsFrozenRendering boolean
---Whether to orbit selected actor.
---@field bIsOrbitingSelectedActor boolean
---When orbiting, true if using actor center as pivot, false if using last selected hitpoint
---@field bOrbitPivotUseCenter boolean
---Whether set view mode to display GBuffer visualization overview
---@field bEnableBufferVisualization boolean
---Whether set view mode to display GBuffer visualization full
---@field bEnableBufferVisualizationFullMode boolean
---Whether GBuffer visualization overview inputs are set up
---@field bIsBufferVisualizationInputSetup boolean
---Last display enabled setting before toggling buffer visualization overview
---@field bLastDisplayEnabled boolean
---Visualizes the frustum of the camera
---@field DrawFrustum DrawFrustumComponent
---Currently selected actor, may be invalid
---@field SelectedActor any
---Currently selected component, may be invalid
---@field SelectedComponent any
---Selected hit point
---@field SelectedHitPoint HitResult
---Controller that was active before this was spawned
---@field OriginalControllerRef PlayerController
---Player object that was active before this was spawned
---@field OriginalPlayer Player
---Allows control over the speed of the spectator pawn. This scales the speed based on the InitialMaxSpeed. Use Set Pawn Movement Speed Scale during runtime
---@field SpeedScale number
---Initial max speed of the spectator pawn when we start possession.
---@field InitialMaxSpeed number
---Initial acceleration of the spectator pawn when we start possession.
---@field InitialAccel number
---Initial deceleration of the spectator pawn when we start possession.
---@field InitialDecel number
local DebugCameraController = {}

--- Methods
---Toggles the display of debug info and input commands for the Debug Camera.
---@return nil
function DebugCameraController.ToggleDisplay() end

---Sets the pawn movement speed scale.
---@param NewSpeedScale number
---@return nil
function DebugCameraController.SetPawnMovementSpeedScale(NewSpeedScale) end

---Returns the currently selected actor, or null if it is invalid or not set
---@return Actor
function DebugCameraController.GetSelectedActor() end

return DebugCameraController
