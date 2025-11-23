---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class ActorDataLayer
---This class is deprecated and only present for backward compatibility purposes.
---Instead of using FActorDatalayer, directly save the DataLayerInstance FName if the DataLayer not exposed in data.
---If the DataLayer is exposed in Data, then use DataLayerAssets.
---
--- Properties
---The name of this layer
---@field Name string
local ActorDataLayer = {}
return ActorDataLayer
