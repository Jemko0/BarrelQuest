---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class BarrelPlayerState_C : PlayerState
---Barrel Player State
---
--- Properties
---@field UberGraphFrame PointerToUberGraphFrame
---@field DefaultSceneRoot SceneComponent
---@field IsReadyOnServer boolean
---@field IsReadyOnClient boolean
---@field ClientUserID string
local BarrelPlayerState_C = {}

--- Methods
---On Rep Is Ready on Client
---@return nil
function BarrelPlayerState_C.OnRep_IsReadyOnClient() end

---Client Set Ready
---@return nil
function BarrelPlayerState_C.ClientSetReady() end

---Client Get User IDAnd Send
---@return nil
function BarrelPlayerState_C.ClientGetUserIDAndSend() end

---SV Get Client User ID
---Original name: "SV Get Client User ID"
---@param UserID string
---@return nil
function BarrelPlayerState_C.SV_Get_Client_User_ID(UserID) end

return BarrelPlayerState_C
