---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class TileBase_C : BarrelNetCulledActor
---Tile Base
---
--- Properties
---
---@field UberGraphFrame PointerToUberGraphFrame
---@field Ceil StaticMeshComponent
---@field HealthComponent HealthComponent_C
---@field Box BoxComponent
---@field Mesh StaticMeshComponent
---@field TileID string
---@field TileData TileDefinitionStruct
---@field CurrentMaterialInstanceDynamic MaterialInstanceDynamic
---@field IgnoreClipping boolean
---@field RightClickOptions RightClickMenuOption[]
---@field IsPreview boolean
---@field Flipped boolean
---@field PlayerIsViewBlocked boolean
---@field LocalController BarrelPlayerController_C
local TileBase_C = {}

--- Methods
---Get Insulation Level
---@return number
function TileBase_C.GetInsulationLevel() end

---Get Item Component Data
---@return nil, string[]
function TileBase_C.GetItemComponentData() end

---Actor Get Right Click Options
---@return nil, RightClickMenuOption[]
function TileBase_C.ActorGetRightClickOptions() end

---Actor Get Subcontainer
---@return nil, ExternalSubcontainer_C
function TileBase_C.ActorGetSubcontainer() end

---Get Actor as Tile
---@return nil, TileBase_C
function TileBase_C.GetActorAsTile() end

---Get Tile Category
---@return nil, integer
function TileBase_C.GetTileCategory() end

---Cull Fully Clipped Tile
---@param PlayerIsInterior boolean
---@return nil
function TileBase_C.CullFullyClippedTile(PlayerIsInterior) end

---Is Relevant
---@param RealViewer Actor
---@param ViewTarget Actor
---@return boolean
function TileBase_C.IsRelevant(RealViewer, ViewTarget) end

---Get Barrel Custom Net Relevancy
---@param RealViewer Actor
---@param ViewTarget Actor
---@return boolean
function TileBase_C.GetBarrelCustomNetRelevancy(RealViewer, ViewTarget) end

---Snap to Grid
---@return nil
function TileBase_C.SnapToGrid() end

---Construction script, the place to spawn components and do other setup.
---@note Name used in CreateBlueprint function
---@return nil
function TileBase_C.UserConstructionScript() end

---On Loaded 2E61F6D84BEFC3EF9DDF589024BFE19E
---@param Loaded Object
---@return nil
function TileBase_C.OnLoaded_2E61F6D84BEFC3EF9DDF589024BFE19E(Loaded) end

---On Loaded AD054B51472ABF4573944ABD51CF5818
---@param Loaded Object
---@return nil
function TileBase_C.OnLoaded_AD054B51472ABF4573944ABD51CF5818(Loaded) end

---Actor Use
---@param User Character
---@return nil
function TileBase_C.ActorUse(User) end

---Actor Secondary Use
---@param User BarrelCharacter_C
---@return nil
function TileBase_C.ActorSecondaryUse(User) end

---Actor Drop
---@param Source Actor
---@return nil
function TileBase_C.ActorDrop(Source) end

---Slot Use from RCM
---@param Container ContainerComponentNew_C
---@param Slot integer
---@return nil
function TileBase_C.SlotUseFromRCM(Container, Slot) end

---Slot Drop from RCM
---@param Container ContainerComponentNew_C
---@param Slot integer
---@param Amount integer
---@return nil
function TileBase_C.SlotDropFromRCM(Container, Slot, Amount) end

---Controller Use Actor
---@param Actor Actor
---@param User Character
---@return nil
function TileBase_C.ControllerUseActor(Actor, User) end

---Controller Pick Up Actor
---@param Actor Actor
---@param Source ContainerComponentNew_C
---@return nil
function TileBase_C.ControllerPickUpActor(Actor, Source) end

---Move from Container from RCM
---@param OtherCont ContainerComponentNew_C
---@param OtherSlot integer
---@return nil
function TileBase_C.MoveFromContainerFromRCM(OtherCont, OtherSlot) end

---Move to Hotbar from RCM
---@param Slot integer
---@return nil
function TileBase_C.MoveToHotbarFromRCM(Slot) end

---Actor End Secondary Use
---@param User BarrelCharacter_C
---@return nil
function TileBase_C.ActorEndSecondaryUse(User) end

---Remove from Hotbar from RCM
---@param HotbarSlotID integer
---@return nil
function TileBase_C.RemoveFromHotbarFromRCM(HotbarSlotID) end

---Pick Up Tile
---@param TileActor Actor
---@return nil
function TileBase_C.PickUpTile(TileActor) end

---Move to Container from Inventory
---@param InventorySlot integer
---@param OtherContainer ContainerComponentNew_C
---@return nil
function TileBase_C.MoveToContainerFromInventory(InventorySlot, OtherContainer) end

---Start Load Mesh 
---Original name: "StartLoadMesh "
---@return nil
function TileBase_C.StartLoadMesh_() end

---Start Load Material
---@return nil
function TileBase_C.StartLoadMaterial() end

---Local Player Inside Changed
---@param IsInterior boolean
---@return nil
function TileBase_C.LocalPlayerInsideChanged(IsInterior) end

---Cull Fully Clip
---@param PlayerIsInterior boolean
---@return nil
function TileBase_C.CullFullyClip(PlayerIsInterior) end

---Local Player Floor Changed
---@param NewFloorZ number
---@return nil
function TileBase_C.LocalPlayerFloorChanged(NewFloorZ) end

---Actor Perform from RCM
---@param ID string
---@return nil
function TileBase_C.ActorPerformFromRCM(ID) end

---Tile Death
---@return nil
function TileBase_C.TileDeath() end

---On View Blocked
---@param Blocked boolean
---@return nil
function TileBase_C.OnViewBlocked(Blocked) end

---On Tile Death
---@return nil
function TileBase_C.OnTileDeath() end

return TileBase_C
