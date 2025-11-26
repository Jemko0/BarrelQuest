---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class WindowActor_C : Actor
---Window Actor
---
--- Properties
---
---@field UberGraphFrame PointerToUberGraphFrame
---@field Billboard1 BillboardComponent
---@field Billboard BillboardComponent
---@field Pos2 SceneComponent
---@field Pos1 SceneComponent
---@field StaticMesh StaticMeshComponent
---@field DrawDebug boolean
local WindowActor_C = {}

--- Methods
---Actor Get Right Click Options
---@return nil, RightClickMenuOption[]
function WindowActor_C.ActorGetRightClickOptions() end

---Actor Get Subcontainer
---@return nil, ExternalSubcontainer_C
function WindowActor_C.ActorGetSubcontainer() end

---Get Item Component Data
---@return nil, string[]
function WindowActor_C.GetItemComponentData() end

---Get Closest Entry
---@param FromPoint Vector
---@return nil, SceneComponent, SceneComponent
function WindowActor_C.GetClosestEntry(FromPoint) end

---Construction script, the place to spawn components and do other setup.
---@note Name used in CreateBlueprint function
---@return nil
function WindowActor_C.UserConstructionScript() end

---Actor Use
---@param User Character
---@return nil
function WindowActor_C.ActorUse(User) end

---Actor Secondary Use
---@param User BarrelCharacter_C
---@return nil
function WindowActor_C.ActorSecondaryUse(User) end

---Actor Drop
---@param Source Actor
---@return nil
function WindowActor_C.ActorDrop(Source) end

---Slot Use from RCM
---@param Container ContainerComponentNew_C
---@param Slot integer
---@return nil
function WindowActor_C.SlotUseFromRCM(Container, Slot) end

---Slot Drop from RCM
---@param Container ContainerComponentNew_C
---@param Slot integer
---@param Amount integer
---@return nil
function WindowActor_C.SlotDropFromRCM(Container, Slot, Amount) end

---Controller Use Actor
---@param Actor Actor
---@param User Character
---@return nil
function WindowActor_C.ControllerUseActor(Actor, User) end

---Controller Pick Up Actor
---@param Actor Actor
---@param Source ContainerComponentNew_C
---@return nil
function WindowActor_C.ControllerPickUpActor(Actor, Source) end

---Move from Container from RCM
---@param OtherCont ContainerComponentNew_C
---@param OtherSlot integer
---@return nil
function WindowActor_C.MoveFromContainerFromRCM(OtherCont, OtherSlot) end

---Move to Hotbar from RCM
---@param Slot integer
---@return nil
function WindowActor_C.MoveToHotbarFromRCM(Slot) end

---Actor End Secondary Use
---@param User BarrelCharacter_C
---@return nil
function WindowActor_C.ActorEndSecondaryUse(User) end

---Remove from Hotbar from RCM
---@param HotbarSlotID integer
---@return nil
function WindowActor_C.RemoveFromHotbarFromRCM(HotbarSlotID) end

---Pick Up Tile
---@param TileActor Actor
---@return nil
function WindowActor_C.PickUpTile(TileActor) end

---Move to Container from Inventory
---@param InventorySlot integer
---@param OtherContainer ContainerComponentNew_C
---@return nil
function WindowActor_C.MoveToContainerFromInventory(InventorySlot, OtherContainer) end

---Actor Perform from RCM
---@param ID string
---@return nil
function WindowActor_C.ActorPerformFromRCM(ID) end

return WindowActor_C
