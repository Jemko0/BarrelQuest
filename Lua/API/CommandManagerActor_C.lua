---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class CommandManagerActor_C : Actor
---Command Manager Actor
---
--- Properties
---
---@field UberGraphFrame PointerToUberGraphFrame
---@field Billboard BillboardComponent
---@field CommandManager CommandManager_C
local CommandManagerActor_C = {}

--- Methods
---Test
---@return nil
function CommandManagerActor_C.test() end

---Push Command
---@param Command string
---@param Executor PlayerController
---@return nil
function CommandManagerActor_C.PushCommand(Command, Executor) end

return CommandManagerActor_C
