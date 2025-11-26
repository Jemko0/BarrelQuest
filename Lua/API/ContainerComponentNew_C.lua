---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class ContainerComponentNew_C : ActorComponent
---Container Component New
---
--- Properties
---@field UberGraphFrame PointerToUberGraphFrame
---@field InitialItems InventoryItemStruct[]
---@field Items InventoryItemStruct[]
---@field MaxWeight number
---@field CurrentWeight number
---@field WeightReductionPercent number
---@field WeightUpdated function
local ContainerComponentNew_C = {}

--- Methods
---Tick Spoilage
---@return nil
function ContainerComponentNew_C.TickSpoilage() end

---Tick Container Items
---@return nil
function ContainerComponentNew_C.TickContainerItems() end

---Has Any Item
---@return nil, string[], boolean, table<string, integer>
function ContainerComponentNew_C.HasAnyItem() end

---Set Data Component
---@param Index integer
---@param Component string
---@param NewValue string
---@return nil
function ContainerComponentNew_C.SetDataComponent(Index, Component, NewValue) end

---Get All Of
---@param Tag TagDataAsset_C
---@return nil, table<integer, string>
function ContainerComponentNew_C.GetAllOf(Tag) end

---Get Data Component Value
---@param Index integer
---@param component string
---@return nil, string
function ContainerComponentNew_C.GetDataComponentValue(Index, component) end

---Has Enough
---@param Query table<string, CraftingRecipeIngredientStruct>
---@return nil, boolean
function ContainerComponentNew_C.HasEnough(Query) end

---Clear Slot
---@param Slot integer
---@return nil
function ContainerComponentNew_C.ClearSlot(Slot) end

---Remove Item by Slot
---@param Slot integer
---@param Amount integer
---@return nil
function ContainerComponentNew_C.RemoveItem_BySlot(Slot, Amount) end

---Remove Item
---@param ItemID string
---@param Amount integer
---@return nil
function ContainerComponentNew_C.RemoveItem(ItemID, Amount) end

---On Rep Items
---@return nil
function ContainerComponentNew_C.OnRep_Items() end

---Get Total Weight
---@return nil, number
function ContainerComponentNew_C.GetTotalWeight() end

---Can be Added
---@param Item InventoryItemStruct
---@return nil, boolean
function ContainerComponentNew_C.CanBeAdded(Item) end

---Find Item
---@param ItemID string
---@return nil, integer
function ContainerComponentNew_C.FindItem(ItemID) end

---Has Item
---@param ItemID string
---@return boolean
function ContainerComponentNew_C.HasItem(ItemID) end

---Add Item
---@param Item InventoryItemStruct
---@return nil, boolean
function ContainerComponentNew_C.AddItem(Item) end

---Recalc Weight
---@return nil
function ContainerComponentNew_C.RecalcWeight() end

---Tick Items
---@return nil
function ContainerComponentNew_C.TickItems() end

return ContainerComponentNew_C
