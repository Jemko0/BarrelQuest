---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class InteractionBillboardActor_C : Actor
---Interaction Billboard Actor
---
--- Properties
---
---@field UberGraphFrame PointerToUberGraphFrame
---@field Widget WidgetComponent
local InteractionBillboardActor_C = {}

--- Methods
---Set Component
---@param RefActor InteractUIComponent_C
---@param Item Item_C
---@return nil
function InteractionBillboardActor_C.SetComponent(RefActor, Item) end

return InteractionBillboardActor_C
