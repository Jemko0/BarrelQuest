---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class ClothingSimulationInteractor
---If a clothing simulation is able to be interacted with at runtime then a derived
---interactor should be created, and at least the basic API implemented for that
---simulation.
---Only write to the simulation and context during the call to Sync, as that is
---guaranteed to be a safe place to access this data.
---
--- Properties
---
---Cloth interactors currently created.
---@field ClothingInteractors table<string, ClothingInteractor>
local ClothingSimulationInteractor = {}

--- Methods
---Set the number of substeps or subdivisions.
---@param NumSubsteps integer
---@return nil
function ClothingSimulationInteractor.SetNumSubsteps(NumSubsteps) end

---Set the number of time dependent solver iterations.
---@param NumIterations integer
---@return nil
function ClothingSimulationInteractor.SetNumIterations(NumIterations) end

---Set the maximum number of solver iterations.
---@param MaxNumIterations integer
---@return nil
function ClothingSimulationInteractor.SetMaxNumIterations(MaxNumIterations) end

---Set the stiffness of the spring force for the animation drive.
---@param InStiffness number
---@return nil
function ClothingSimulationInteractor.SetAnimDriveSpringStiffness(InStiffness) end

---Called to update collision status without restarting the simulation.
---@return nil
function ClothingSimulationInteractor.PhysicsAssetUpdated() end

---Return the instant average simulation time in ms.
---@return number
function ClothingSimulationInteractor.GetSimulationTime() end

---Return the solver number of subdivisions./
---This could be different from the number set if the simulation hasn't updated yet.
---@return integer
function ClothingSimulationInteractor.GetNumSubsteps() end

---Return the number of kinematic (animated) particles.
---@return integer
function ClothingSimulationInteractor.GetNumKinematicParticles() end

---Return the solver number of iterations.
---This could be different from the number set if the simulation hasn't updated yet.
---@return integer
function ClothingSimulationInteractor.GetNumIterations() end

---Return the number of dynamic (simulated) particles.
---@return integer
function ClothingSimulationInteractor.GetNumDynamicParticles() end

---Return the number of cloths run by the simulation.
---@return integer
function ClothingSimulationInteractor.GetNumCloths() end

---Return a cloth interactor for this simulation.
---@param ClothingAssetName string
---@return ClothingInteractor
function ClothingSimulationInteractor.GetClothingInteractor(ClothingAssetName) end

---Set a new gravity override and enable the override.
---@return nil
function ClothingSimulationInteractor.EnableGravityOverride() end

---Disable any currently set gravity override.
---@return nil
function ClothingSimulationInteractor.DisableGravityOverride() end

---Called to update the cloth config without restarting the simulation.
---@return nil
function ClothingSimulationInteractor.ClothConfigUpdated() end

return ClothingSimulationInteractor
