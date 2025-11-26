---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class BarrelPlayerState_C : PlayerState
---Barrel Player State
---
--- Properties
---
---@field UberGraphFrame PointerToUberGraphFrame
---@field DefaultSceneRoot SceneComponent
---@field IsReadyOnServer boolean
---@field IsReadyOnClient boolean
---@field ClientUserID string
---@field ReadyForSpawning boolean
---@field currentFileIndex integer
---@field Net_Load_Client_Lua_Files string[] -- Original name: "Net Load Client Lua Files"
---@field CurrenLuaFileContent string
---@field LuaFileChunks integer
---@field CurrentChunkIndex integer
---@field LuaFileChunkSize integer
---@field CurrentChunkContent string
---@field CurrentLuaFile string
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

---Spawn Player
---@return nil
function BarrelPlayerState_C.SpawnPlayer() end

---Wait for Spawn
---@return nil
function BarrelPlayerState_C.WaitForSpawn() end

---Show Joining Widget
---@return nil
function BarrelPlayerState_C.ShowJoiningWidget() end

---Remove Joining Widget
---@return nil
function BarrelPlayerState_C.RemoveJoiningWidget() end

---SVSend Client Lua
---@return nil
function BarrelPlayerState_C.SVSendClientLua() end

---CLReceive Client Lua Chunk
---@param file string
---@param chunk string
---@param cIndex integer
---@param maxChunks integer
---@return nil
function BarrelPlayerState_C.CLReceiveClientLuaChunk(file, chunk, cIndex, maxChunks) end

---Iterate Next File
---@return nil
function BarrelPlayerState_C.IterateNextFile() end

---Next Chunk Iteration
---@return nil
function BarrelPlayerState_C.NextChunkIteration() end

---Client Run Lua
---@return nil
function BarrelPlayerState_C.ClientRunLua() end

return BarrelPlayerState_C
