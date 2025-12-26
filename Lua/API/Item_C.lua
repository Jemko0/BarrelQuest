---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class Item_C : Actor
---Item
---
--- Properties
---
---@field UberGraphFrame PointerToUberGraphFrame
---@field Billboard BillboardComponent
---@field InteractUIComponent InteractUIComponent_C
---@field StaticMesh StaticMeshComponent
---@field ID string
---@field CachedData ItemDataStruct
---@field Amount integer
---@field Data string[]
---@field CanBePickedUp boolean
---@field SimulatesPhysics boolean
---@field HasCollision boolean
---@field Holder BarrelCharacter_C
local Item_C = {}

--- Methods
---Get Item Component Data
---@return nil, string[]
function Item_C.GetItemComponentData() end

---Actor Get Subcontainer
---@return nil, ExternalSubcontainer_C
function Item_C.ActorGetSubcontainer() end

---Actor Get Right Click Options
---@return nil, RightClickMenuOption[]
function Item_C.ActorGetRightClickOptions() end

---Get Container
---@return nil, ContainerComponentNew_C
function Item_C.GetContainer() end

---Get Item Data
---@return nil, boolean, ItemDataStruct
function Item_C.GetItemData() end

---Can be Interacted With
---@return nil, boolean
function Item_C.CanBeInteractedWith() end

---Get Data Component
---@param component string
---@return nil, string
function Item_C.GetDataComponent(component) end

---Set Data Component
---@param Component string
---@param NewValue string
---@return nil
function Item_C.SetDataComponent(Component, NewValue) end

---On Rep ID
---@return nil
function Item_C.OnRep_ID() end

---On Rep Has Collision
---@return nil
function Item_C.OnRep_HasCollision() end

---On Rep Simulates Physics
---@return nil
function Item_C.OnRep_SimulatesPhysics() end

---Construct Item
---@param CustomID string
---@return nil
function Item_C.ConstructItem(CustomID) end

---Get Property
---@param Data table<string, string>
---@param Key string
---@return nil, string, boolean
function Item_C.GetProperty(Data, Key) end

---Init Default Data
---@param DefaultData table<string, string>
---@return nil
function Item_C.InitDefaultData(DefaultData) end

---Construction script, the place to spawn components and do other setup.
---@note Name used in CreateBlueprint function
---@return nil
function Item_C.UserConstructionScript() end

---Move to Hotbar from RCM
---@param Slot integer
---@return nil
function Item_C.MoveToHotbarFromRCM(Slot) end

---Actor End Secondary Use
---@param User BarrelCharacter_C
---@return nil
function Item_C.ActorEndSecondaryUse(User) end

---Remove from Hotbar from RCM
---@param HotbarSlotID integer
---@return nil
function Item_C.RemoveFromHotbarFromRCM(HotbarSlotID) end

---Pick Up Tile
---@param TileActor Actor
---@return nil
function Item_C.PickUpTile(TileActor) end

---Move to Container from Inventory
---@param InventorySlot integer
---@param OtherContainer ContainerComponentNew_C
---@return nil
function Item_C.MoveToContainerFromInventory(InventorySlot, OtherContainer) end

---Mark Slot Dirty
---@return nil
function Item_C.MarkSlotDirty() end

---Actor Perform from RCM
---@param ID string
---@return nil
function Item_C.ActorPerformFromRCM(ID) end

---Move from Container from RCM
---@param OtherCont ContainerComponentNew_C
---@param OtherSlot integer
---@return nil
function Item_C.MoveFromContainerFromRCM(OtherCont, OtherSlot) end

---Slot Drop from RCM
---@param Container ContainerComponentNew_C
---@param Slot integer
---@param Amount integer
---@return nil
function Item_C.SlotDropFromRCM(Container, Slot, Amount) end

---Controller Pick Up Actor
---@param Actor Actor
---@param Source ContainerComponentNew_C
---@return nil
function Item_C.ControllerPickUpActor(Actor, Source) end

---Slot Use from RCM
---@param Container ContainerComponentNew_C
---@param Slot integer
---@return nil
function Item_C.SlotUseFromRCM(Container, Slot) end

---Actor Drop
---@param Source Actor
---@return nil
function Item_C.ActorDrop(Source) end

---Actor Secondary Use
---@param User BarrelCharacter_C
---@return nil
function Item_C.ActorSecondaryUse(User) end

---Controller Use Actor
---@param Actor Actor
---@param User Character
---@return nil
function Item_C.ControllerUseActor(Actor, User) end

---Interact
---@param Character BarrelCharacter_C
---@return nil
function Item_C.Interact(Character) end

---Pick Up
---@param Source ContainerComponentNew_C
---@return nil
function Item_C.PickUp(Source) end

---Actor Use
---@param User Character
---@return nil
function Item_C.ActorUse(User) end

---SVUse
---@param User Character
---@return nil
function Item_C.SVUse(User) end

---Local Use
---@return nil
function Item_C.LocalUse() end

return Item_C
