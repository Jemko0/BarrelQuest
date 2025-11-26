---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class SaveGame
---This class acts as a base class for a save game object that can be used to save state about the game.
---When you create your own save game subclass, you would add member variables for the information that you want to save.
---Then when you want to save a game, create an instance of this object using CreateSaveGameObject, fill in the data, and use SaveGameToSlot, providing a slot name.
---To load the game you then just use LoadGameFromSlot, and read the data from the resulting object.
---@see https://docs.unrealengine.com/latest/INT/Gameplay/SaveGame
---
--- Properties
local SaveGame = {}

--- Methods
return SaveGame
