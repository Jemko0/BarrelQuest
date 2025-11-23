---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class ContainerComponent_C : ActorComponent
---Container Component
---
--- Properties
---@field UberGraphFrame PointerToUberGraphFrame
---@field ContainerSize integer
---@field Items InventoryItemStruct[]
---@field SlotChanged function
local ContainerComponent_C = {}

--- Methods
---Move from Container
---@param OtherCont ContainerComponent_C
---@param OtherSlot integer
---@return nil
function ContainerComponent_C.MoveFromContainer(OtherCont, OtherSlot) end

---returns true if any empty slot exists
---@param ID string
---@param Potential_Add integer
---@return nil, integer
function ContainerComponent_C.FindFreeSlotForItem(ID, Potential_Add) end

---Remove Item from Slot
---@param Slot integer
---@param Amount integer
---@return nil
function ContainerComponent_C.RemoveItemFromSlot(Slot, Amount) end

---Clear Slot
---@param Slot integer
---@return nil
function ContainerComponent_C.ClearSlot(Slot) end

---Move Slot
---@param FromSlot integer
---@param ToSlot integer
---@return nil
function ContainerComponent_C.MoveSlot(FromSlot, ToSlot) end

---returns true if any empty slot exists
---@return nil, integer
function ContainerComponent_C.FindFreeSlot() end

---returns true if any item ID and Data matches
---@param ID string
---@param Amount_To_Add integer
---@return nil, string[], integer, integer
function ContainerComponent_C.FindItemAdvanced(ID, Amount_To_Add) end

---Add Item
---@param newItem InventoryItemStruct
---@return nil, boolean
function ContainerComponent_C.AddItem(newItem) end

---Init Container
---@return nil
function ContainerComponent_C.InitContainer() end

---SV Broadcast Slot Change
---Original name: "SV BroadcastSlotChange"
---@return nil
function ContainerComponent_C.SV_BroadcastSlotChange() end

---SV Remove Item
---Original name: "SV Remove Item"
---@param Slot integer
---@param Amount integer
---@return nil
function ContainerComponent_C.SV_Remove_Item(Slot, Amount) end

return ContainerComponent_C
