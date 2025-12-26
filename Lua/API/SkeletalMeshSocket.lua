---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class SkeletalMeshSocket
---Skeletal Mesh Socket
---
--- Properties
---
---Defines a named attachment location on the USkeletalMesh.
---These are set up in editor and used as a shortcut instead of specifying
---everything explicitly to AttachComponent in the SkeletalMeshComponent.
---The Outer of a SkeletalMeshSocket should always be the USkeletalMesh.
---@field SocketName string
---@field BoneName string
---@field RelativeLocation Vector
---@field RelativeRotation Rotator
---@field RelativeScale Vector
---If true then the hierarchy of bones this socket is attached to will always be
---          evaluated, even if it had previously been removed due to the current lod setting
---@field bForceAlwaysAnimated boolean
local SkeletalMeshSocket = {}

--- Methods
---Change the sockets parent to a new bone. The skeleton is used to validate that the bone exists
---@param InSkeletalMesh SkeletalMesh
---@param InBoneName string
---@return nil
function SkeletalMeshSocket.SetSocketParent(InSkeletalMesh, InBoneName) end

---Sets the relative transform parameters of the socket to the given local FTransform
---@param InTransform Transform
---@return nil
function SkeletalMeshSocket.SetSocketLocalTransform(InTransform) end

---Sets BoneName, RelativeLocation and RelativeRotation based on closest bone to WorldLocation and WorldNormal
---@param SkelComp SkeletalMeshComponent
---@param WorldLocation Vector
---@param WorldNormal Vector
---@return nil
function SkeletalMeshSocket.InitializeSocketFromLocation(SkelComp, WorldLocation, WorldNormal) end

---Get Socket Location
---@param SkelComp SkeletalMeshComponent
---@return Vector
function SkeletalMeshSocket.GetSocketLocation(SkelComp) end

---returns FTransform of Socket local transform
---@return Transform
function SkeletalMeshSocket.GetSocketLocalTransform() end

return SkeletalMeshSocket
