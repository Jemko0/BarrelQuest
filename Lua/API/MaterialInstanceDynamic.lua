---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class MaterialInstanceDynamic : MaterialInstance
---Material Instance Dynamic
---
--- Properties
local MaterialInstanceDynamic = {}

--- Methods
---Set an MID vector parameter value, using MPI (to allow access to layer parameters)
---@param Value LinearColor
---@return nil
function MaterialInstanceDynamic.SetVectorParameterValueByInfo(Value) end

---Set an MID vector parameter value
---@param ParameterName string
---@param Value LinearColor
---@return nil
function MaterialInstanceDynamic.SetVectorParameterValue(ParameterName, Value) end

---Set an MID texture parameter value using MPI (to allow access to layer parameters)
---@param Value Texture
---@return nil
function MaterialInstanceDynamic.SetTextureParameterValueByInfo(Value) end

---Set an MID texture parameter value
---@param ParameterName string
---@param Value Texture
---@return nil
function MaterialInstanceDynamic.SetTextureParameterValue(ParameterName, Value) end

---Set an MID texture collection parameter value using MPI (to allow access to layer parameters)
---@param Value TextureCollection
---@return nil
function MaterialInstanceDynamic.SetTextureCollectionParameterValueByInfo(Value) end

---Set an MID texture collection parameter value
---@param ParameterName string
---@param Value TextureCollection
---@return nil
function MaterialInstanceDynamic.SetTextureCollectionParameterValue(ParameterName, Value) end

---Set an MID texture parameter value
---@param ParameterName string
---@param Value SparseVolumeTexture
---@return nil
function MaterialInstanceDynamic.SetSparseVolumeTextureParameterValue(ParameterName, Value) end

---Set a MID scalar (float) parameter value using MPI (to allow access to layer parameters)
---@param Value number
---@return nil
function MaterialInstanceDynamic.SetScalarParameterValueByInfo(Value) end

---Set a MID scalar (float) parameter value
---@param ParameterName string
---@param Value number
---@return nil
function MaterialInstanceDynamic.SetScalarParameterValue(ParameterName, Value) end

---Use the cached value of OutParameterIndex from InitializeScalarParameterAndGetIndex to set the scalar parameter
---ONLY on the exact same MID.  Do NOT presume the index can be used from one instance on another.  Only use this
---pair of functions when optimization is critical; otherwise use either SetScalarParameterValueByInfo or
---SetScalarParameterValue.
---@param ParameterIndex integer
---@param Value number
---@return boolean
function MaterialInstanceDynamic.SetScalarParameterByIndex(ParameterIndex, Value) end

---Set an MID texture parameter value using MPI (to allow access to layer parameters)
---@param Value RuntimeVirtualTexture
---@return nil
function MaterialInstanceDynamic.SetRuntimeVirtualTextureParameterValueByInfo(Value) end

---Set an MID texture parameter value
---@param ParameterName string
---@param Value RuntimeVirtualTexture
---@return nil
function MaterialInstanceDynamic.SetRuntimeVirtualTextureParameterValue(ParameterName, Value) end

---Set an MID vector parameter value
---@param ParameterName string
---@param Value Vector4
---@return nil
function MaterialInstanceDynamic.SetDoubleVectorParameterValue(ParameterName, Value) end

---Use this function to set an initial value and fetch the index for use in SetScalarParameterByIndex.  This
---function should only be called once for a particular name, and then use SetScalarParameterByIndex for subsequent
---calls.  However, beware using this except in cases where optimization is critical, which is generally only if
---you're using an unusually high number of parameters in a material and setting a large number of parameters in the
---same frame.  Also, if the material is changed in any way that can change the parameter list, the index can be
---invalidated.
---@param Value number
---@return boolean
function MaterialInstanceDynamic.InitializeScalarParameterAndGetIndex(Value) end

---Copy parameter values from another material instance. This will copy only
---parameters explicitly overridden in that material instance!!
---@param MaterialInstance MaterialInstance
---@return nil
function MaterialInstanceDynamic.CopyParameterOverrides(MaterialInstance) end

return MaterialInstanceDynamic
