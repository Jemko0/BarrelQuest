---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class CommandManager_C : ActorComponent
---Command Manager
---
--- Properties
---@field UberGraphFrame PointerToUberGraphFrame
---@field CommandStack table<string, PlayerController>
---@field CurrentStackItem string
---@field CurrentStackItemExecutor PlayerController
---@field CurrentArguments string[]
local CommandManager_C = {}

--- Methods
---Push to Stack
---@return nil
function CommandManager_C.PushToStack() end

---Get Argument Primitive Type
---@param arg string
---@param __WorldContext Object
---@return nil, integer
function CommandManager_C.GetArgumentPrimitiveType(arg, __WorldContext) end

---Parse Command
---@param executionString string
---@return nil, string, string, string[]
function CommandManager_C.ParseCommand(executionString) end

---Get Command
---@param command string
---@return nil, GameCommandStruct, boolean
function CommandManager_C.GetCommand(command) end

---Exec
---@param PlayerController PlayerController
---@param Command string
---@return nil
function CommandManager_C.Exec(PlayerController, Command) end

---Can Execute Command
---@param PlayerController PlayerController
---@param Command string
---@return boolean, integer, integer
function CommandManager_C.CanExecuteCommand(PlayerController, Command) end

---Get Command Permission
---@return nil, integer
function CommandManager_C.GetCommandPermission() end

---Process Next Stack Item
---@return nil
function CommandManager_C.ProcessNextStackItem() end

return CommandManager_C
