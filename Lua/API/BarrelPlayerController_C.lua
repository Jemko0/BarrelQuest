---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class BarrelPlayerController_C : PlayerController
---Barrel Player Controller
---
--- Properties
---@field UberGraphFrame PointerToUberGraphFrame
---@field inBlockingUI boolean
---@field ConstructionMode boolean
---@field AssignedChar BarrelCharacter_C
---@field BarrelPawn BarrelPawn_C
---@field ReachDistance number
---@field ObscurringActors Actor[]
---@field IsInterior boolean
---@field OnInsideChanged function
---@field OnFloorChanged function
---@field IsViewBlocked boolean
---@field LastFloorZ number
---@field DragMouseStart Vector2D
---@field CanDrag boolean
---@field IsDragging boolean
---@field CraftingQueue CraftingQueueItemStruct[]
---@field CraftingQueueQuickAmountLookup table<string, CraftingQueueQuickAmountLookupMapValueStruct>
---@field DragAllow boolean
---@field Mouse_Delta_X number -- Original name: "Mouse Delta X"
---@field moveCamera boolean
---@field OnWalkToSuccess function
---@field OnWalkToFailed function
---@field CurrentWalkToPath NavigationPath
---@field CurrentPathPointIndex integer
---@field CurrentPathPoint Vector
---@field AutoWalking boolean
---@field OnViewBlocked function
---@field AutoWalkAcceptableRange number
local BarrelPlayerController_C = {}

--- Methods
---Get Command Manager
---@return nil, CommandManagerActor_C
function BarrelPlayerController_C.GetCommandManager() end

---Get Permission Level
---@return nil, integer
function BarrelPlayerController_C.GetPermissionLevel() end

---Send Action to Object
---@param ActionData TimedActionData
---@return nil
function BarrelPlayerController_C.SendActionToObject(ActionData) end

---Walk to Target Action
---@param TargetLocation Vector
---@param AcceptableRange number
---@return nil, boolean
function BarrelPlayerController_C.WalkToTargetAction(TargetLocation, AcceptableRange) end

---Get Item Component Data
---@return nil, string[]
function BarrelPlayerController_C.GetItemComponentData() end

---Actor Get Subcontainer
---@return nil, ExternalSubcontainer_C
function BarrelPlayerController_C.ActorGetSubcontainer() end

---Actor Get Right Click Options
---@return nil, RightClickMenuOption[]
function BarrelPlayerController_C.ActorGetRightClickOptions() end

---Get Self Controller
---@return nil, BarrelPlayerController_C
function BarrelPlayerController_C.GetSelfController() end

---Can Reach
---@param Actor Actor
---@return nil, boolean
function BarrelPlayerController_C.CanReach(Actor) end

---In Construction Mode
---@return nil, boolean
function BarrelPlayerController_C.InConstructionMode() end

---Get Assigned Character
---@return nil, BarrelCharacter_C
function BarrelPlayerController_C.GetAssignedCharacter() end

---Is in Build Mode
---@return nil, boolean
function BarrelPlayerController_C.IsInBuildMode() end

---Is in Blocking UI
---@return nil, boolean
function BarrelPlayerController_C.IsInBlockingUI() end

---Try Take Off Clothing
---@param InputPin integer
---@param InputPin2 integer
---@return nil
function BarrelPlayerController_C.TryTakeOffClothing(InputPin, InputPin2) end

---Is Clothing Slot for Clothing Occupied
---@param ID string
---@return nil, boolean
function BarrelPlayerController_C.IsClothingSlotForClothingOccupied(ID) end

---Try Wear Clothing
---@param InInt integer
---@return nil
function BarrelPlayerController_C.TryWearClothing(InInt) end

---View Container
---@param ParentContainer ContainerComponentNew_C
---@return nil
function BarrelPlayerController_C.ViewContainer(ParentContainer) end

---Is Any Panel Open
---@return boolean
function BarrelPlayerController_C.IsAnyPanelOpen() end

---Bind Walk Events
---@return nil
function BarrelPlayerController_C.BindWalkEvents() end

---Move to Container from Inv
---@param OtherContainer ContainerComponentNew_C
---@param InvSlot integer
---@return nil
function BarrelPlayerController_C.MoveToContainerFromInv(OtherContainer, InvSlot) end

---Move to Inv from Container
---@param OtherContainer ContainerComponentNew_C
---@param OtherSlot integer
---@return nil
function BarrelPlayerController_C.MoveToInvFromContainer(OtherContainer, OtherSlot) end

---Build Trace
---@return boolean
function BarrelPlayerController_C.BuildTrace() end

---Is in Hotbar
---@param ItemID string
---@return boolean
function BarrelPlayerController_C.IsInHotbar(ItemID) end

---Check Interior
---@return nil
function BarrelPlayerController_C.CheckInterior() end

---Rotate Camera
---@return nil
function BarrelPlayerController_C.RotateCamera() end

---Get Mouse Rotation
---@return nil
function BarrelPlayerController_C.GetMouseRotation() end

---Move to Hotbar
---@return nil
function BarrelPlayerController_C.MoveToHotbar() end

---Find Free Hotbar Slot
---@return nil, integer[], integer
function BarrelPlayerController_C.FindFreeHotbarSlot() end

---Drop Item from Inventory
---@param ContainerComponent ContainerComponentNew_C
---@param Slot integer
---@param Amount integer
---@return nil
function BarrelPlayerController_C.DropItemFromInventory(ContainerComponent, Slot, Amount) end

---On Rep Assigned Char
---@return nil
function BarrelPlayerController_C.OnRep_AssignedChar() end

---Cancel Crafting Fully
---Original name: "Cancel Crafting Fully"
---@return nil
function BarrelPlayerController_C.Cancel_Crafting_Fully() end

---Get Crafting Result
---@param Recipe_ID string
---@return nil, InventoryItemStruct[]
function BarrelPlayerController_C.GetCraftingResult(Recipe_ID) end

---Update Crafting Queue
---@return nil
function BarrelPlayerController_C.UpdateCraftingQueue() end

---Remove Single from Crafting Queue
---@return nil
function BarrelPlayerController_C.RemoveSingleFromCraftingQueue() end

---Remove from Crafting Queue
---@return nil
function BarrelPlayerController_C.RemoveFromCraftingQueue() end

---Add to Crafting Queue
---@param RecipeID string
---@return nil
function BarrelPlayerController_C.AddToCraftingQueue(RecipeID) end

---Detect Mouse Drag
---@return nil
function BarrelPlayerController_C.DetectMouseDrag() end

---Mouse Trace from Player
---@return boolean
function BarrelPlayerController_C.MouseTraceFromPlayer() end

---Check Floor ZDelegate
---@return nil
function BarrelPlayerController_C.CheckFloorZDelegate() end

---Obscure Trace Single
---@return boolean
function BarrelPlayerController_C.ObscureTraceSingle() end

---Get Feet Z
---Original name: "Get Feet Z"
---@param DrawDebugType integer
---@return nil, number, boolean, boolean
function BarrelPlayerController_C.Get_Feet_Z(DrawDebugType) end

---Obscure Behaviour
---@return nil
function BarrelPlayerController_C.ObscureBehaviour() end

---Obscure Trace
---@return boolean
function BarrelPlayerController_C.ObscureTrace() end

---Mouse Trace
---@return boolean
function BarrelPlayerController_C.MouseTrace() end

---Get Item Drop Location
---@return nil, Vector, Rotator
function BarrelPlayerController_C.GetItemDropLocation() end

---Drop Item
---@param Container ContainerComponent_C
---@param Slot integer
---@param Amount integer
---@return nil
function BarrelPlayerController_C.DropItem(Container, Slot, Amount) end

---Use Item from Unspawned
---@param Container ContainerComponentNew_C
---@param Slot integer
---@return nil
function BarrelPlayerController_C.UseItemFromUnspawned(Container, Slot) end

---Handle ESC
---@return nil
function BarrelPlayerController_C.HandleESC() end

---Set Timed Action UIParams
---@param TotalTime number
---@return nil
function BarrelPlayerController_C.SetTimedActionUIParams(TotalTime) end

---Start Timed Action
---@param CallbackObject Object
---@param CallbackFunctionName string
---@param CallbackTime number
---@param InitActionObject Object
---@param InitActionFunctionName string
---@param TimedActionData TimedActionData
---@return nil
function BarrelPlayerController_C.StartTimedAction(CallbackObject, CallbackFunctionName, CallbackTime, InitActionObject, InitActionFunctionName, TimedActionData) end

---Cancel Timed Action
---@return nil
function BarrelPlayerController_C.CancelTimedAction() end

---Cancel Crafting
---@return nil
function BarrelPlayerController_C.CancelCrafting() end

---Cancel Crafting Element
---@param Index integer
---@return nil
function BarrelPlayerController_C.CancelCraftingElement(Index) end

---Actor Use
---@param User Character
---@return nil
function BarrelPlayerController_C.ActorUse(User) end

---Actor Secondary Use
---@param User BarrelCharacter_C
---@return nil
function BarrelPlayerController_C.ActorSecondaryUse(User) end

---Actor Drop
---@param Source Actor
---@return nil
function BarrelPlayerController_C.ActorDrop(Source) end

---Actor Perform from RCM
---@param ID string
---@return nil
function BarrelPlayerController_C.ActorPerformFromRCM(ID) end

---Actor End Secondary Use
---@param User BarrelCharacter_C
---@return nil
function BarrelPlayerController_C.ActorEndSecondaryUse(User) end

---Set in Blocking UI
---@param newBlock boolean
---@return nil
function BarrelPlayerController_C.SetInBlockingUI(newBlock) end

---Control Character
---@return nil
function BarrelPlayerController_C.ControlCharacter() end

---Control Construction Mode
---@return nil
function BarrelPlayerController_C.ControlConstructionMode() end

---Move in Same Container
---@param From_Slot integer
---@param To_Slot integer
---@return nil
function BarrelPlayerController_C.MoveInSameContainer(From_Slot, To_Slot) end

---Slot Use from RCM
---@param Container ContainerComponentNew_C
---@param Slot integer
---@return nil
function BarrelPlayerController_C.SlotUseFromRCM(Container, Slot) end

---SV Use Item from Unspawned
---Original name: "SV Use Item From Unspawned"
---@param Container ContainerComponentNew_C
---@param Slot integer
---@return nil
function BarrelPlayerController_C.SV_Use_Item_From_Unspawned(Container, Slot) end

---Slot Drop from RCM
---@param Container ContainerComponentNew_C
---@param Slot integer
---@param Amount integer
---@return nil
function BarrelPlayerController_C.SlotDropFromRCM(Container, Slot, Amount) end

---SV Drop Item from Inventory
---Original name: "SV Drop Item From Inventory"
---@param Container ContainerComponentNew_C
---@param Slot integer
---@param Amount integer
---@return nil
function BarrelPlayerController_C.SV_Drop_Item_From_Inventory(Container, Slot, Amount) end

---Controller Use Actor
---@param Actor Actor
---@param User Character
---@return nil
function BarrelPlayerController_C.ControllerUseActor(Actor, User) end

---SV Controller Use Actor
---Original name: "SV ControllerUseActor"
---@param Actor Actor
---@param User Character
---@return nil
function BarrelPlayerController_C.SV_ControllerUseActor(Actor, User) end

---CL Create Screen Message
---Original name: "CL Create Screen Message"
---@param Text string
---@return nil
function BarrelPlayerController_C.CL_Create_Screen_Message(Text) end

---Controller Pick Up Actor
---@param Actor Actor
---@param Source ContainerComponentNew_C
---@return nil
function BarrelPlayerController_C.ControllerPickUpActor(Actor, Source) end

---SV Controller Pick Up Actor
---Original name: "SV ControllerPickUpActor"
---@param Actor Actor
---@param Source ContainerComponentNew_C
---@return nil
function BarrelPlayerController_C.SV_ControllerPickUpActor(Actor, Source) end

---Move from Container from RCM
---@param OtherCont ContainerComponentNew_C
---@param OtherSlot integer
---@return nil
function BarrelPlayerController_C.MoveFromContainerFromRCM(OtherCont, OtherSlot) end

---SV Move from Container from RCM
---Original name: "SV MoveFromContainerFromRCM"
---@param otherC ContainerComponentNew_C
---@param otherS integer
---@return nil
function BarrelPlayerController_C.SV_MoveFromContainerFromRCM(otherC, otherS) end

---Move to Hotbar from RCM
---@param Slot integer
---@return nil
function BarrelPlayerController_C.MoveToHotbarFromRCM(Slot) end

---SV Move To Hotbar
---Original name: "SV Move to Hotbar"
---@param Slot integer
---@return nil
function BarrelPlayerController_C.SV_Move_to_Hotbar(Slot) end

---Craft
---@param recipeID string
---@return nil
function BarrelPlayerController_C.Craft(recipeID) end

---SV Craft
---Original name: "SV Craft"
---@param RecipeID string
---@return nil
function BarrelPlayerController_C.SV_Craft(RecipeID) end

---Client Create Game HUD
---@return nil
function BarrelPlayerController_C.ClientCreateGameHUD() end

---Remove from Hotbar from RCM
---@param HotbarSlotID integer
---@return nil
function BarrelPlayerController_C.RemoveFromHotbarFromRCM(HotbarSlotID) end

---SV Remove From Hotbar
---Original name: "SV Remove from Hotbar"
---@param Slot integer
---@return nil
function BarrelPlayerController_C.SV_Remove_from_Hotbar(Slot) end

---Pick Up Tile
---@param TileActor Actor
---@return nil
function BarrelPlayerController_C.PickUpTile(TileActor) end

---SV Pick Up Tile
---Original name: "SV Pick Up Tile"
---@param Target Object
---@return nil
function BarrelPlayerController_C.SV_Pick_Up_Tile(Target) end

---SV Execute Command
---Original name: "SV Execute Command"
---@param Command string
---@return nil
function BarrelPlayerController_C.SV_Execute_Command(Command) end

---Send Actor Action to Server
---@param ID string
---@param Actor Actor
---@return nil
function BarrelPlayerController_C.SendActorActionToServer(ID, Actor) end

---Wear Clothing
---@param SlotID integer
---@return nil
function BarrelPlayerController_C.WearClothing(SlotID) end

---Take Off Clothing
---@param ClothingSlot integer
---@param Index integer
---@return nil
function BarrelPlayerController_C.TakeOffClothing(ClothingSlot, Index) end

---Move to Container from Inventory
---@param InventorySlot integer
---@param OtherContainer ContainerComponentNew_C
---@return nil
function BarrelPlayerController_C.MoveToContainerFromInventory(InventorySlot, OtherContainer) end

---SV Move to Container from Inventory
---Original name: "SV MoveToContainerFromInventory"
---@param Slot integer
---@param ContainerComponent ContainerComponentNew_C
---@return nil
function BarrelPlayerController_C.SV_MoveToContainerFromInventory(Slot, ContainerComponent) end

---Walk to Canceled
---@return nil
function BarrelPlayerController_C.WalkToCanceled() end

---Cancel Auto Walk
---@return nil
function BarrelPlayerController_C.CancelAutoWalk() end

---Block Auto Walk
---@return nil
function BarrelPlayerController_C.BlockAutoWalk() end

---Allow Auto Walk
---@return nil
function BarrelPlayerController_C.AllowAutoWalk() end

---Player Walk to Location
---@return nil
function BarrelPlayerController_C.PlayerWalkToLocation() end

return BarrelPlayerController_C
