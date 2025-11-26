---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
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

---Interpolates the scalar and vector parameters of this material instance based on two other material instances, and an alpha blending factor
---The output is the object itself (this).
---Supports the case SourceA==this || SourceB==this
---Both material have to be from the same base material
---@param SourceA MaterialInstance
---@param SourceB MaterialInstance
---@param Alpha number
---@return nil
function MaterialInstanceDynamic.K2_InterpolateMaterialInstanceParams(SourceA, SourceB, Alpha) end

---Get the current MID vector parameter value, using MPI (to allow access to layer parameters)
---@return LinearColor
function MaterialInstanceDynamic.K2_GetVectorParameterValueByInfo() end

---Get the current MID vector parameter value
---@param ParameterName string
---@return LinearColor
function MaterialInstanceDynamic.K2_GetVectorParameterValue(ParameterName) end

---Get the current MID texture parameter value, using MPI (to allow access to layer parameters)
---@return Texture
function MaterialInstanceDynamic.K2_GetTextureParameterValueByInfo() end

---Get the current MID texture parameter value
---@param ParameterName string
---@return Texture
function MaterialInstanceDynamic.K2_GetTextureParameterValue(ParameterName) end

---Get the current MID texture collection parameter value, using MPI (to allow access to layer parameters)
---@return TextureCollection
function MaterialInstanceDynamic.K2_GetTextureCollectionParameterValueByInfo() end

---Get the current MID texture collection parameter value
---@param ParameterName string
---@return TextureCollection
function MaterialInstanceDynamic.K2_GetTextureCollectionParameterValue(ParameterName) end

---Get the current scalar (float) parameter value from an MID, using MPI (to allow access to layer parameters)
---@return number
function MaterialInstanceDynamic.K2_GetScalarParameterValueByInfo() end

---Get the current scalar (float) parameter value from an MID
---@param ParameterName string
---@return number
function MaterialInstanceDynamic.K2_GetScalarParameterValue(ParameterName) end

---Copies over parameters given a material interface (copy each instance following the hierarchy)
---Very slow implementation, avoid using at runtime. Hopefully we can replace it later with something like CopyInterpParameters()
---The output is the object itself (this). Copying 'quick parameters only' will result in a much
---faster copy process but will only copy dynamic scalar, vector and texture parameters on clients.
---@param Source MaterialInterface
---@param bQuickParametersOnly boolean
---@return nil
function MaterialInstanceDynamic.K2_CopyMaterialInstanceParameters(Source, bQuickParametersOnly) end

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
