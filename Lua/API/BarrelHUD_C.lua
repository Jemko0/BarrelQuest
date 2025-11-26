---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class BarrelHUD_C : HUD
---Barrel HUD
---
--- Properties
---
---@field UberGraphFrame PointerToUberGraphFrame
---@field DefaultSceneRoot SceneComponent
---@field MainUI MainUI_C
---@field DebugStringBuffer DebugStringBufferData[]
---@field debugRightClickOptions boolean
---@field CurrentConsole ConsoleUI_C
---@field EscMenu EscapeMenu_C
---@field Settings CollapsablePanel_C
---@field DeathUI DeathUI_C
---@field ClientJoinLoading ClientJoinLoadingScreenUI_C
local BarrelHUD_C = {}

--- Methods
---Create Settings
---@return nil, CollapsablePanelChild_C
function BarrelHUD_C.CreateSettings() end

---Get Debug RCMButtons
---@return nil, boolean
function BarrelHUD_C.GetDebugRCMButtons() end

---Create Client Loading Screen
---@param destroy boolean
---@return nil
function BarrelHUD_C.CreateClientLoadingScreen(destroy) end

---On Settings Closed
---@return nil
function BarrelHUD_C.OnSettingsClosed() end

---Draw Debug String
---@param Text string
---@param TextColor LinearColor
---@param ScreenX number
---@param ScreenY number
---@param Font Font
---@param Scale number
---@param bScalePosition boolean
---@return nil
function BarrelHUD_C.DrawDebugString(Text, TextColor, ScreenX, ScreenY, Font, Scale, bScalePosition) end

---Create HUD
---@return nil
function BarrelHUD_C.CreateHUD() end

---Create Console
---@return nil
function BarrelHUD_C.CreateConsole() end

---Create ESCMenu
---@return nil
function BarrelHUD_C.CreateESCMenu() end

---On ESCClosed
---@return nil
function BarrelHUD_C.OnESCClosed() end

---Create Death
---@return nil
function BarrelHUD_C.CreateDeath() end

return BarrelHUD_C
