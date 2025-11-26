---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class CheatManager
---Cheat Manager is a central blueprint to implement test and debug code and actions that are not to ship with the game.
---As the Cheat Manager is not instanced in shipping builds, it is for debugging purposes only
---
--- Properties
---Debug camera - used to have independent camera without stopping gameplay
---@field DebugCameraControllerRef DebugCameraController
---Debug camera - used to have independent camera without stopping gameplay
---@field DebugCameraControllerClass Class
---List of registered cheat manager extensions
---@field CheatManagerExtensions CheatManagerExtension[]
local CheatManager = {}

--- Methods
---Return to walking movement mode from Fly or Ghost cheat.
---@return nil
function CheatManager.Walk() end

---Teleport to surface player is looking at.
---@return nil
function CheatManager.Teleport() end

---Modify time dilation to change apparent speed of passage of time. e.g. "Slomo 0.1" makes everything move very slowly, while "Slomo 10" makes everything move very fast.
---@param NewTimeDilation number
---@return nil
function CheatManager.Slomo(NewTimeDilation) end

---Freeze everything in the level except for players.
---@return nil
function CheatManager.PlayersOnly() end

---Invulnerability cheat.
---@return nil
function CheatManager.God() end

---Pawn no longer collides with the world, and can fly
---@return nil
function CheatManager.Ghost() end

---Get Player Controller
---@return PlayerController
function CheatManager.GetPlayerController() end

---Pause the game for Delay seconds.
---@param Delay number
---@return nil
function CheatManager.FreezeFrame(Delay) end

---Pawn can fly.
---@return nil
function CheatManager.Fly() end

---Switch controller to debug camera without locking gameplay and with locking local player controller input
---@return nil
function CheatManager.EnableDebugCamera() end

---Switch controller from debug camera back to normal controller
---@return nil
function CheatManager.DisableDebugCamera() end

---Destroy the actor you're looking at.
---@return nil
function CheatManager.DestroyTarget() end

---Damage the actor you're looking at (sourced from the player).
---@param DamageAmount number
---@return nil
function CheatManager.DamageTarget(DamageAmount) end

---Scale the player's size to be F * default size.
---@param F number
---@return nil
function CheatManager.ChangeSize(F) end

return CheatManager
