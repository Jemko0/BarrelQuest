---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class BarrelCharacter_C : Character
---Barrel Character
---
--- Properties
---
---@field UberGraphFrame PointerToUberGraphFrame
---@field BodyTemperature BodyTemperatureComponent
---@field ViewCone ChildActorComponent
---@field DangerSensingComponent DangerSensingComponent_C
---@field AIPerceptionStimuliSource AIPerceptionStimuliSourceComponent
---@field BoneHealthComponent BoneHealthComponent_C
---@field ContainerComponentNew ContainerComponentNew_C
---@field ActionProgressBar WidgetComponent
---@field PlayerStatComponent PlayerStatComponent_C
---@field InteractionRange SphereComponent
---@field NameTag WidgetComponent
---@field DropShadow DecalComponent
---@field Camera CameraComponent
---@field SpringArm SpringArmComponent
---@field ClimbState_alpha_77B7D6C04A72BDC526BC7587F744D7E3 number
---@field ClimbState__Direction_77B7D6C04A72BDC526BC7587F744D7E3 integer
---@field ClimbState TimelineComponent
---@field InteractableActors Actor[]
---@field InteractionUIPairs table<Actor, InteractionBillboardActor_C>
---@field Sprinting boolean
---@field BaseWalkSpeed number
---@field DefaultWalkSpeed number
---@field SprintMultiplier number
---@field WalkSpeedMultiplier number
---@field AssignedMusicManager MusicManager_C
---@field CurrentBiome integer
---@field Drink_Type integer -- Original name: "Drink Type"
---@field AnimationStaticMesh StaticMeshComponent
---@field FallOverType integer
---@field ZoomFactor number
---@field CurrentRoom table<Vector, boolean>
---@field CurrentRoomTiles Actor[]
---@field RoomFindTimer TimerHandle
---@field DrawRoomDebug boolean
---@field FindRoomIterationCount integer
---@field FindRoomMaxIterations integer
---@field CurrentTimedAction TimedActionData
---@field CurrentTimedActionTimer_Server TimerHandle -- Original name: "CurrentTimedActionTimer Server"
---@field CurrentTimedActionReplicatedTime number
---@field deathType integer
---@field CurrentUsingItem Item_C
---@field Hotbar integer[]
---@field SelectedItem integer
---@field HeldItemActor Item_C
---@field New_Aim_State integer -- Original name: "New Aim State"
---@field IsAiming boolean
---@field AllowedToUseItems boolean
---@field CamRotXAmount number
---@field PlaceTileID string
---@field CurrentClientBuildPreviewActor TileBase_C
---@field TileInfoUI PlaceTileInfoUI_C
---@field BuildRotation Rotator
---@field LastValidLocation Vector
---@field LastValidRotation Rotator
---@field CanAim boolean
---@field UseTimeMultiplier number
---@field PlacingTile boolean
---@field LastDamageType Class
---@field RecentKnock boolean
---@field CurrentWindow WindowActor_C
---@field WindowEntry SceneComponent
---@field WindowExit SceneComponent
---@field ShirtMID MaterialInstanceDynamic
---@field PantsMID MaterialInstanceDynamic
---@field ShoesMID MaterialInstanceDynamic
---@field ClothingUpperBody ClothingItemDataStruct[]
---@field ClothingLowerBody ClothingItemDataStruct[]
---@field ClothingFeet ClothingItemDataStruct[]
---@field TemperatureManager BPTemperatureManager_C
local BarrelCharacter_C = {}

--- Methods
---Get Worn Clothing Data
---@return WearingClothingData[]
function BarrelCharacter_C.GetWornClothingData() end

---Get Clothing Insulation Level
---@return nil, number
function BarrelCharacter_C.GetClothingInsulationLevel() end

---Get Clothing Slots
---@return nil, CharacterClothingStruct
function BarrelCharacter_C.GetClothingSlots() end

---Get Focus Point
---@return Vector
function BarrelCharacter_C.GetFocusPoint() end

---Get View Cone
---@return ViewConeActor
function BarrelCharacter_C.GetViewCone() end

---Has Been Knocked Recently
---@return nil, boolean
function BarrelCharacter_C.HasBeenKnockedRecently() end

---Get Sensed Danger
---@return nil, integer
function BarrelCharacter_C.GetSensedDanger() end

---Get Danger
---@return nil, number
function BarrelCharacter_C.GetDanger() end

---Get Character Mesh
---@return nil, SkeletalMeshComponent
function BarrelCharacter_C.GetCharacterMesh() end

---Get Is Alive
---@return nil, boolean
function BarrelCharacter_C.GetIsAlive() end

---Get Current Timed Action Data
---@return nil, TimedActionData
function BarrelCharacter_C.GetCurrentTimedActionData() end

---Can Use Items
---@return nil, boolean
function BarrelCharacter_C.CanUseItems() end

---Walk to Target Action
---@param TargetLocation Vector
---@param AcceptableRange number
---@return nil, boolean
function BarrelCharacter_C.WalkToTargetAction(TargetLocation, AcceptableRange) end

---Get Stat Component
---@return nil, StatsComponent_C
function BarrelCharacter_C.GetStatComponent() end

---Get Bone Health Component
---@return nil, BoneHealthComponent_C
function BarrelCharacter_C.GetBoneHealthComponent() end

---Get Health Component
---@return nil, HealthComponent_C
function BarrelCharacter_C.GetHealthComponent() end

---Get Item Data
---@return nil, boolean, ItemDataStruct
function BarrelCharacter_C.GetItemData() end

---Get Container
---@return nil, ContainerComponentNew_C
function BarrelCharacter_C.GetContainer() end

---Is Moving
---@return boolean
function BarrelCharacter_C.IsMoving() end

---Get Body Heat Production
---@return nil, number
function BarrelCharacter_C.GetBodyHeatProduction() end

---Init Temperature
---@return nil
function BarrelCharacter_C.InitTemperature() end

---Update Body Temperature
---@return nil
function BarrelCharacter_C.UpdateBodyTemperature() end

---Get Clothing Slot
---@param Slot integer
---@return nil, ClothingItemDataStruct[]
function BarrelCharacter_C.GetClothingSlot(Slot) end

---Handle Montage Notify
---@param Notify string
---@return nil
function BarrelCharacter_C.HandleMontageNotify(Notify) end

---Get Up
---@return nil
function BarrelCharacter_C.GetUp() end

---Finalize Taking Off Clothes
---@return nil
function BarrelCharacter_C.FinalizeTakingOffClothes() end

---Start Taking Off Clothes
---@return nil
function BarrelCharacter_C.StartTakingOffClothes() end

---Reapply Current Clothing
---@return nil
function BarrelCharacter_C.ReapplyCurrentClothing() end

---On Rep Clothing Feet
---@return nil
function BarrelCharacter_C.OnRep_ClothingFeet() end

---On Rep Clothing Lower Body
---@return nil
function BarrelCharacter_C.OnRep_ClothingLowerBody() end

---On Rep Clothing Upper Body
---@return nil
function BarrelCharacter_C.OnRep_ClothingUpperBody() end

---Finalize Wearing Clothes
---@return nil
function BarrelCharacter_C.FinalizeWearingClothes() end

---Start Wearing Clothes
---@return nil
function BarrelCharacter_C.StartWearingClothes() end

---Set Clothes from IDs
---@return nil, string[], string[], string[]
function BarrelCharacter_C.SetClothesFromIDs() end

---Apply Clothes
---@param Clothes CharacterClothingStruct
---@return nil
function BarrelCharacter_C.ApplyClothes(Clothes) end

---Setup MIDs
---@return nil
function BarrelCharacter_C.SetupMIDs() end

---Handle Climb Through Window
---@param InputPin number
---@return nil
function BarrelCharacter_C.HandleClimbThroughWindow(InputPin) end

---Set View Cone Parameters
---@return nil
function BarrelCharacter_C.SetViewConeParameters() end

---Reset Stun
---@return nil
function BarrelCharacter_C.resetStun() end

---Stun
---@param newWalkSpeed number
---@param Time number
---@return nil
function BarrelCharacter_C.Stun(newWalkSpeed, Time) end

---Reset Knock
---@return nil
function BarrelCharacter_C.resetKnock() end

---Perform Timed Action
---@param Callback_Object Object
---@param Callback_Function_Name string
---@param Callback_Time number
---@param Action_Object Object
---@param Action_Function_Name string
---@param CurrentTimedAction TimedActionData
---@return nil
function BarrelCharacter_C.PerformTimedAction(Callback_Object, Callback_Function_Name, Callback_Time, Action_Object, Action_Function_Name, CurrentTimedAction) end

---Barrel Char Makecorpse
---@return nil
function BarrelCharacter_C.barrel_char_makecorpse() end

---Get Max Throwing Velocity
---@return nil, number
function BarrelCharacter_C.GetMaxThrowingVelocity() end

---Update Tile Info UIPosition
---@return nil
function BarrelCharacter_C.UpdateTileInfoUIPosition() end

---Update Temperature Stat
---@return nil
function BarrelCharacter_C.UpdateTemperatureStat() end

---Cancel Placing Tile
---@return nil
function BarrelCharacter_C.CancelPlacingTile() end

---On Rep Placing Tile
---@return nil
function BarrelCharacter_C.OnRep_PlacingTile() end

---Finalize Placing Tile
---@return nil
function BarrelCharacter_C.FinalizePlacingTile() end

---Start Placing Tile
---@return nil
function BarrelCharacter_C.StartPlacingTile() end

---Check Invalid Movement Base
---@return nil
function BarrelCharacter_C.CheckInvalidMovementBase() end

---Destroy Held Item
---@return nil
function BarrelCharacter_C.DestroyHeldItem() end

---Is Selected Item Valid
---@return boolean
function BarrelCharacter_C.IsSelectedItemValid() end

---SVFinalize Place Tile
---@return nil
function BarrelCharacter_C.SVFinalizePlaceTile() end

---Can Place
---@param Location Vector
---@return boolean
function BarrelCharacter_C.CanPlace(Location) end

---Server Try Place Tile
---@param Location Vector
---@param Rotation Rotator
---@param ID string
---@return nil
function BarrelCharacter_C.ServerTryPlaceTile(Location, Rotation, ID) end

---Try Place Tile
---@return nil
function BarrelCharacter_C.TryPlaceTile() end

---Set Place Tile ID
---@param ID string
---@return nil
function BarrelCharacter_C.SetPlaceTileID(ID) end

---Barrel Char Set Tileplaceid
---@param PlaceID string
---@return nil
function BarrelCharacter_C.barrel_char_set_tileplaceid(PlaceID) end

---Get Build Location
---@param Target BarrelPlayerController_C
---@return nil, Vector
function BarrelCharacter_C.GetBuildLocation(Target) end

---Can Build
---@return boolean
function BarrelCharacter_C.CanBuild() end

---Client Update Build Mode
---@return nil
function BarrelCharacter_C.ClientUpdateBuildMode() end

---Update Camera Rotation
---@param Delta number
---@return nil
function BarrelCharacter_C.UpdateCameraRotation(Delta) end

---Finalize Bandage
---@return nil
function BarrelCharacter_C.FinalizeBandage() end

---Put on Bandage
---@return nil
function BarrelCharacter_C.PutOnBandage() end

---On Rep Fall Over Type
---@return nil
function BarrelCharacter_C.OnRep_FallOverType() end

---Damage Anim
---@return nil
function BarrelCharacter_C.DamageAnim() end

---Fall Backwards
---@return nil
function BarrelCharacter_C.FallBackwards() end

---Handle Point Damage
---@param Damage number
---@param DamageType DamageType
---@param HitLocation Vector
---@param HitNormal Vector
---@param ShotFromDir Vector
---@param DamageCauser Actor
---@param HitInfo HitResult
---@return nil
function BarrelCharacter_C.HandlePointDamage(Damage, DamageType, HitLocation, HitNormal, ShotFromDir, DamageCauser, HitInfo) end

---Set Player Data
---@param Data PlayerSaveDataStruct
---@return nil
function BarrelCharacter_C.SetPlayerData(Data) end

---Update Aiming
---@return nil
function BarrelCharacter_C.UpdateAiming() end

---On Rep New Aim State
---Original name: "OnRep_New Aim State"
---@return nil
function BarrelCharacter_C.OnRep_New_Aim_State() end

---Update Held Item
---@return nil
function BarrelCharacter_C.UpdateHeldItem() end

---On Rep Held Item Actor
---@return nil
function BarrelCharacter_C.OnRep_HeldItemActor() end

---On Rep Selected Item
---@return nil
function BarrelCharacter_C.OnRep_SelectedItem() end

---Set Selected Item Index
---@param newIndex integer
---@return nil
function BarrelCharacter_C.SetSelectedItemIndex(newIndex) end

---Process Death
---@param LastDamageType Class
---@return nil
function BarrelCharacter_C.ProcessDeath(LastDamageType) end

---On Rep Death Type
---@return nil
function BarrelCharacter_C.OnRep_deathType() end

---Get Alive
---@return nil, boolean
function BarrelCharacter_C.GetAlive() end

---Apply Stat Movement Changes
---@return nil
function BarrelCharacter_C.ApplyStatMovementChanges() end

---Get Fitness Multiplier
---@return number, number
function BarrelCharacter_C.GetFitnessMultiplier() end

---Update Stats
---@return nil
function BarrelCharacter_C.UpdateStats() end

---Can Currently Perform Timed Action
---@return boolean
function BarrelCharacter_C.CanCurrentlyPerformTimedAction() end

---Update Action
---@return nil
function BarrelCharacter_C.UpdateAction() end

---Test Completion
---@return nil
function BarrelCharacter_C.testCompletion() end

---Test Action
---@return nil
function BarrelCharacter_C.testAction() end

---On Rep Current Timed Action
---@return nil
function BarrelCharacter_C.OnRep_CurrentTimedAction() end

---Get Neighbor Tiles
---@param Center Vector
---@return nil
function BarrelCharacter_C.GetNeighborTiles(Center) end

---Find Room Process
---@return nil
function BarrelCharacter_C.FindRoomProcess() end

---Stats Tick Update Character
---@return nil
function BarrelCharacter_C.StatsTickUpdateCharacter() end

---Reset Drink
---@return nil
function BarrelCharacter_C.resetDrink() end

---On Rep Drink Type
---Original name: "OnRep_Drink Type"
---@return nil
function BarrelCharacter_C.OnRep_Drink_Type() end

---Process Damage
---@param Damage number
---@param DamageType DamageType
---@param Controller Controller
---@param SourceActor Actor
---@return nil
function BarrelCharacter_C.ProcessDamage(Damage, DamageType, Controller, SourceActor) end

---On Rep Current Biome
---@return nil
function BarrelCharacter_C.OnRep_CurrentBiome() end

---Init Tag
---@return nil
function BarrelCharacter_C.InitTag() end

---Camera Zoom
---@param Zoom number
---@return nil
function BarrelCharacter_C.CameraZoom(Zoom) end

---Remove Interaction UI
---@param InputPin Actor
---@return nil
function BarrelCharacter_C.RemoveInteractionUI(InputPin) end

---Update Item Interactions
---@return nil
function BarrelCharacter_C.UpdateItemInteractions() end

---Set Shadow Scale
---@return nil
function BarrelCharacter_C.SetShadowScale() end

---Construction script, the place to spawn components and do other setup.
---@note Name used in CreateBlueprint function
---@return nil
function BarrelCharacter_C.UserConstructionScript() end

---On Notify End 7F57F1CA46B3892C082533991F9E40F2
---@param NotifyName string
---@return nil
function BarrelCharacter_C.OnNotifyEnd_7F57F1CA46B3892C082533991F9E40F2(NotifyName) end

---On Notify Begin 7F57F1CA46B3892C082533991F9E40F2
---@param NotifyName string
---@return nil
function BarrelCharacter_C.OnNotifyBegin_7F57F1CA46B3892C082533991F9E40F2(NotifyName) end

---On Interrupted 7F57F1CA46B3892C082533991F9E40F2
---@param NotifyName string
---@return nil
function BarrelCharacter_C.OnInterrupted_7F57F1CA46B3892C082533991F9E40F2(NotifyName) end

---On Blend Out 7F57F1CA46B3892C082533991F9E40F2
---@param NotifyName string
---@return nil
function BarrelCharacter_C.OnBlendOut_7F57F1CA46B3892C082533991F9E40F2(NotifyName) end

---On Completed 7F57F1CA46B3892C082533991F9E40F2
---@param NotifyName string
---@return nil
function BarrelCharacter_C.OnCompleted_7F57F1CA46B3892C082533991F9E40F2(NotifyName) end

---On Notify End 6D39FB5548836393871F3DA323AB5F4F
---@param NotifyName string
---@return nil
function BarrelCharacter_C.OnNotifyEnd_6D39FB5548836393871F3DA323AB5F4F(NotifyName) end

---On Notify Begin 6D39FB5548836393871F3DA323AB5F4F
---@param NotifyName string
---@return nil
function BarrelCharacter_C.OnNotifyBegin_6D39FB5548836393871F3DA323AB5F4F(NotifyName) end

---On Interrupted 6D39FB5548836393871F3DA323AB5F4F
---@param NotifyName string
---@return nil
function BarrelCharacter_C.OnInterrupted_6D39FB5548836393871F3DA323AB5F4F(NotifyName) end

---On Blend Out 6D39FB5548836393871F3DA323AB5F4F
---@param NotifyName string
---@return nil
function BarrelCharacter_C.OnBlendOut_6D39FB5548836393871F3DA323AB5F4F(NotifyName) end

---On Completed 6D39FB5548836393871F3DA323AB5F4F
---@param NotifyName string
---@return nil
function BarrelCharacter_C.OnCompleted_6D39FB5548836393871F3DA323AB5F4F(NotifyName) end

---Set Timed Action UIParams
---@param TotalTime number
---@return nil
function BarrelCharacter_C.SetTimedActionUIParams(TotalTime) end

---Send Action to Object
---@param ActionData TimedActionData
---@return nil
function BarrelCharacter_C.SendActionToObject(ActionData) end

---Add Value to Stat
---@param statName string
---@param value number
---@return nil
function BarrelCharacter_C.AddValueToStat(statName, value) end

---Mark Slot Dirty
---@return nil
function BarrelCharacter_C.MarkSlotDirty() end

---Pick Up
---@param Source ContainerComponentNew_C
---@return nil
function BarrelCharacter_C.PickUp(Source) end

---SVInteract
---@return nil
function BarrelCharacter_C.SVInteract() end

---CLInteract
---@return nil
function BarrelCharacter_C.CLInteract() end

---CLSprint
---@param Sprint boolean
---@return nil
function BarrelCharacter_C.CLSprint(Sprint) end

---SVSprint
---@param Sprint boolean
---@return nil
function BarrelCharacter_C.SVSprint(Sprint) end

---SVDrink
---@param DrinkType integer
---@return nil
function BarrelCharacter_C.SVDrink(DrinkType) end

---Drink
---@param Type integer
---@return nil
function BarrelCharacter_C.Drink(Type) end

---Shared Stats Ticked
---@return nil
function BarrelCharacter_C.SharedStatsTicked() end

---Bind Inside Change
---@param Target Object
---@return nil
function BarrelCharacter_C.BindInsideChange(Target) end

---On Inside Changed
---@param IsInterior boolean
---@return nil
function BarrelCharacter_C.OnInsideChanged(IsInterior) end

---Find Room
---@return nil
function BarrelCharacter_C.FindRoom() end

---Clear Room Brightness
---@return nil
function BarrelCharacter_C.ClearRoomBrightness() end

---SVPerform Timed Action
---Original name: "SVPerformTimed Action"
---@param CallbackObject Object
---@param CallbackFunctionName string
---@param CallbackTime number
---@param ActionObject Object
---@param ActionFunctionName string
---@param CallbackActionData TimedActionData
---@return nil
function BarrelCharacter_C.SVPerformTimed_Action(CallbackObject, CallbackFunctionName, CallbackTime, ActionObject, ActionFunctionName, CallbackActionData) end

---Start Timed Action
---@param CallbackObject Object
---@param CallbackFunctionName string
---@param CallbackTime number
---@param InitActionObject Object
---@param InitActionFunctionName string
---@param TimedActionData TimedActionData
---@return nil
function BarrelCharacter_C.StartTimedAction(CallbackObject, CallbackFunctionName, CallbackTime, InitActionObject, InitActionFunctionName, TimedActionData) end

---Cancel Timed Action
---@return nil
function BarrelCharacter_C.CancelTimedAction() end

---SVCancel Current Timed Action
---@return nil
function BarrelCharacter_C.SVCancelCurrentTimedAction() end

---SVDeath
---@param Last_Damage_Type Class
---@return nil
function BarrelCharacter_C.SVDeath(Last_Damage_Type) end

---SVSet Selected Item Index
---@param newIndex integer
---@return nil
function BarrelCharacter_C.SVSetSelectedItemIndex(newIndex) end

---SVChar Start Aim
---@param New_Aim_State integer
---@return nil
function BarrelCharacter_C.SVCharStartAim(New_Aim_State) end

---SVChar Stop Aim
---@return nil
function BarrelCharacter_C.SVCharStopAim() end

---Set Can Use Items
---@param NewState boolean
---@return nil
function BarrelCharacter_C.SetCanUseItems(NewState) end

---Set Use Item Cooldown
---@param Seconds number
---@return nil
function BarrelCharacter_C.SetUseItemCooldown(Seconds) end

---Reset Can Use Items
---@return nil
function BarrelCharacter_C.ResetCanUseItems() end

---MULSpawn Particles
---@param EmitterTemplate ParticleSystem
---@param Location Vector
---@param Rotation Rotator
---@return nil
function BarrelCharacter_C.MULSpawnParticles(EmitterTemplate, Location, Rotation) end

---MULPlay Montage
---@param MontageToPlay AnimMontage
---@return nil
function BarrelCharacter_C.MULPlayMontage(MontageToPlay) end

---SVPlay Montage
---@param MontageToPlay AnimMontage
---@return nil
function BarrelCharacter_C.SVPlayMontage(MontageToPlay) end

---SVTry Place Tile
---@param Location Vector
---@param TileID string
---@param Rotation Rotator
---@return nil
function BarrelCharacter_C.SVTryPlaceTile(Location, TileID, Rotation) end

---On Client Posess
---@param Target Object
---@return nil
function BarrelCharacter_C.OnClientPosess(Target) end

---SVTurn Into Corpse
---@return nil
function BarrelCharacter_C.SVTurnIntoCorpse() end

---Knock
---@return nil
function BarrelCharacter_C.Knock() end

---Trip
---@return nil
function BarrelCharacter_C.Trip() end

---Stood Up
---@return nil
function BarrelCharacter_C.StoodUp() end

---CLDeath
---@return nil
function BarrelCharacter_C.CLDeath() end

---MULClimb Through Window
---@param Window WindowActor_C
---@return nil
function BarrelCharacter_C.MULClimbThroughWindow(Window) end

---SVClimb Through Window
---@param Window WindowActor_C
---@return nil
function BarrelCharacter_C.SVClimbThroughWindow(Window) end

return BarrelCharacter_C
