---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class ProceduralMeshComponent : MeshComponent
---Component that allows you to specify custom triangle mesh geometry
---Beware! This feature is experimental and may be substantially changed in future releases.
---
--- Properties
---
---Controls whether the complex (Per poly) geometry should be treated as 'simple' collision.
---Should be set to false if this component is going to be given simple collision and simulated.
---@field bUseComplexAsSimpleCollision boolean
---Controls whether the physics cooking should be done off the game thread. This should be used when collision geometry doesn't have to be immediately up to date (For example streaming in far away objects)
---@field bUseAsyncCooking boolean
---Collision data
---@field ProcMeshBodySetup BodySetup
local ProceduralMeshComponent = {}

--- Methods
---Updates a section of this procedural mesh component. This is faster than CreateMeshSection, but does not let you change topology. Collision info is also updated.
---@param SectionIndex integer
---@param bSRGBConversion boolean
---@return nil
function ProceduralMeshComponent.UpdateMeshSection_LinearColor(SectionIndex, bSRGBConversion) end

---Updates a section of this procedural mesh component. This is faster than CreateMeshSection, but does not let you change topology. Collision info is also updated.
---This function is deprecated for Blueprints because it uses the unsupported 'Color' type. Use new 'Create Mesh Section' function which uses LinearColor instead.
---@param SectionIndex integer
---@return nil
function ProceduralMeshComponent.UpdateMeshSection(SectionIndex) end

---Control visibility of a particular section
---@param SectionIndex integer
---@param bNewVisibility boolean
---@return nil
function ProceduralMeshComponent.SetMeshSectionVisible(SectionIndex, bNewVisibility) end

---Returns whether a particular section is currently visible
---@param SectionIndex integer
---@return boolean
function ProceduralMeshComponent.IsMeshSectionVisible(SectionIndex) end

---Returns number of sections currently created for this component
---@return integer
function ProceduralMeshComponent.GetNumSections() end

---Create/replace a section for this procedural mesh component.
---@param SectionIndex integer
---@param bCreateCollision boolean
---@param bSRGBConversion boolean
---@return nil
function ProceduralMeshComponent.CreateMeshSection_LinearColor(SectionIndex, bCreateCollision, bSRGBConversion) end

---Create/replace a section for this procedural mesh component.
---This function is deprecated for Blueprints because it uses the unsupported 'Color' type. Use new 'Create Mesh Section' function which uses LinearColor instead.
---@param SectionIndex integer
---@param bCreateCollision boolean
---@return nil
function ProceduralMeshComponent.CreateMeshSection(SectionIndex, bCreateCollision) end

---Clear a section of the procedural mesh. Other sections do not change index.
---@param SectionIndex integer
---@return nil
function ProceduralMeshComponent.ClearMeshSection(SectionIndex) end

---Remove collision meshes from this component
---@return nil
function ProceduralMeshComponent.ClearCollisionConvexMeshes() end

---Clear all mesh sections and reset to empty state
---@return nil
function ProceduralMeshComponent.ClearAllMeshSections() end

---Add simple collision convex to this component
---@param ConvexVerts Vector[]
---@return nil
function ProceduralMeshComponent.AddCollisionConvexMesh(ConvexVerts) end

return ProceduralMeshComponent
