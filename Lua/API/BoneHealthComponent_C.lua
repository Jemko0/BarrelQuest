---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class BoneHealthComponent_C : ActorComponent
---Bone Health Component
---
--- Properties
---
---@field UberGraphFrame PointerToUberGraphFrame
---@field Bones BoneHealthStruct[]
---@field FastLookup table<string, BoneHealthStruct>
---@field Indices table<string, integer>
---@field BoneDamageMultiplier table<string, number>
---@field BoneWeights table<string, number>
---@field Exclude string[]
---@field FatalBones table<string, boolean>
---@field bone_index integer
---@field ExtraOverallDamage number
---@field HC_Death HC_DeathDelegate -- Original name: "HC Death"
---@field TickTimerHandle TimerHandle
---@field BonesClientCache BoneHealthStruct[]
local BoneHealthComponent_C = {}

--- Methods
---Tick Healing
---@return nil
function BoneHealthComponent_C.TickHealing() end

---Stop Ticking
---@return nil
function BoneHealthComponent_C.StopTicking() end

---Get Bandage Efficiency from Item
---@return nil, boolean, integer
function BoneHealthComponent_C.GetBandageEfficiencyFromItem() end

---Get Bandage Efficiency
---@param Bone string
---@return nil, boolean, integer
function BoneHealthComponent_C.GetBandageEfficiency(Bone) end

---On Rep Bones
---@return nil
function BoneHealthComponent_C.OnRep_Bones() end

---Get Overall Body Health
---@return nil, number
function BoneHealthComponent_C.GetOverallBodyHealth() end

---Bandage Bone
---@param Bone string
---@param Item InventoryItemStruct
---@return nil
function BoneHealthComponent_C.BandageBone(Bone, Item) end

---Add Bone Flag
---@param Name string
---@param flag integer
---@return nil
function BoneHealthComponent_C.AddBoneFlag(Name, flag) end

---Tick Injuries
---@return nil
function BoneHealthComponent_C.TickInjuries() end

---Add Bone Health
---@param Name string
---@param Amount number
---@return nil
function BoneHealthComponent_C.AddBoneHealth(Name, Amount) end

---Has Flags
---@param Name string
---@return nil, integer[], boolean
function BoneHealthComponent_C.HasFlags(Name) end

---Has Flag
---@param Bone string
---@param Flag integer
---@return nil, boolean
function BoneHealthComponent_C.HasFlag(Bone, Flag) end

---Get Bone
---@param Name string
---@return nil, BoneHealthStruct, integer
function BoneHealthComponent_C.GetBone(Name) end

---Set Bones from Mesh
---@param Mesh SkeletalMeshComponent
---@return nil
function BoneHealthComponent_C.SetBonesFromMesh(Mesh) end

---Tick Bones
---@return nil
function BoneHealthComponent_C.TickBones() end

---Spawn Blood Particles
---@param Bone string
---@param Rotation Rotator
---@param EmitterTemplate ParticleSystem
---@return nil
function BoneHealthComponent_C.SpawnBloodParticles(Bone, Rotation, EmitterTemplate) end

---MUL Spawn Blood Particles
---Original name: "MUL SpawnBloodParticles"
---@param EmitterTemplate ParticleSystem
---@param Location Vector
---@param Rotation Rotator
---@return nil
function BoneHealthComponent_C.MUL_SpawnBloodParticles(EmitterTemplate, Location, Rotation) end

---On Any Damage
---@param DamagedActor Actor
---@param Damage number
---@param DamageType DamageType
---@param InstigatedBy Controller
---@param DamageCauser Actor
---@return nil
function BoneHealthComponent_C.OnAnyDamage(DamagedActor, Damage, DamageType, InstigatedBy, DamageCauser) end

return BoneHealthComponent_C
