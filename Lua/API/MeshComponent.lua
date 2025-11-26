---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class MeshComponent : PrimitiveComponent
---MeshComponent is an abstract base for any component that is an instance of a renderable collection of triangles.
---@see UStaticMeshComponent
---@see USkeletalMeshComponent
---
--- Properties
---Material overrides.
---@field OverrideMaterials MaterialInterface[]
---Translucent material to blend on top of this mesh. Mesh will be rendered twice - once with a base material and once with overlay material
---@field OverlayMaterial MaterialInterface
---The max draw distance for overlay material. A distance of 0 indicates that overlay will be culled using primitive max distance.
---@field OverlayMaterialMaxDrawDistance number
---Translucent material to blend on top of this mesh. Mesh will be rendered twice - once with a base material and once with overlay material.
---The difference with the  global OverlayMaterial is those are per material slot, if the entry is null or doesn't exist the global
---OverlayMaterial will be use for sections using the material slot.
---@field MaterialSlotsOverlayMaterial MaterialInterface[]
---Whether or not to cache material parameter to speed up setting scalar or vector value on materials
---@field bEnableMaterialParameterCaching boolean
local MeshComponent = {}

--- Methods
---Set all occurrences of Vector Material Parameters with ParameterName in the set of materials of the SkeletalMesh to ParameterValue
---@param ParameterName string
---@param ParameterValue Vector
---@return nil
function MeshComponent.SetVectorParameterValueOnMaterials(ParameterName, ParameterValue) end

---Set all occurrences of Scalar Material Parameters with ParameterName in the set of materials of the SkeletalMesh to ParameterValue
---@param ParameterName string
---@param ParameterValue number
---@return nil
function MeshComponent.SetScalarParameterValueOnMaterials(ParameterName, ParameterValue) end

---Change the overlay material max draw distance used by this instance
---@param InMaxDrawDistance number
---@return nil
function MeshComponent.SetOverlayMaterialMaxDrawDistance(InMaxDrawDistance) end

---Change the overlay material used by this instance
---@param NewOverlayMaterial MaterialInterface
---@return nil
function MeshComponent.SetOverlayMaterial(NewOverlayMaterial) end

---Set all occurrences of Vector Material Parameters with ParameterName in the set of materials of the SkeletalMesh to ParameterValue
---@param ParameterName string
---@param ParameterValue LinearColor
---@return nil
function MeshComponent.SetColorParameterValueOnMaterials(ParameterName, ParameterValue) end

---Tell the streaming system to start loading all textures with all mip-levels.
---@param Seconds number
---@param bPrioritizeCharacterTextures boolean
---@param CinematicTextureGroups integer
---@return nil
function MeshComponent.PrestreamTextures(Seconds, bPrioritizeCharacterTextures, CinematicTextureGroups) end

---Tell the streaming system to start streaming in all LODs for the mesh.
--- Note: this function may set bIgnoreStreamingMipBias on this component enable the FastForceResident system.
---@param Seconds number
---@return boolean
function MeshComponent.PrestreamMeshLODs(Seconds) end

---Get the overlay material used by this instance
---@return number
function MeshComponent.GetOverlayMaterialMaxDrawDistance() end

---Get the overlay material used by this instance
---@return MaterialInterface
function MeshComponent.GetOverlayMaterial() end

---Get Materials
---@return MaterialInterface[]
function MeshComponent.GetMaterials() end

return MeshComponent
