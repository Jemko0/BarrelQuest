---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class NiagaraSimCacheCreateParameters
---Niagara Sim Cache Create Parameters
---
--- Properties
---How do we want to capture attributes for the simulation cache.
---The mode selected depends on what situations the cache can be used in.
---@field AttributeCaptureMode ENiagaraSimCacheAttributeCaptureMode
---When enabled allows the SimCache to be re-based.
---i.e. World space emitters can be moved to the new component's location
---@field bAllowRebasing boolean
---When enabled Data Interface data will be stored in the SimCache.
---This can result in a large increase to the cache size, depending on what Data Interfaces are used
---@field bAllowDataInterfaceCaching boolean
---When enabled we allow the cache to be generated for interpolation.
---This will increase the memory usage for the cache slightly but can allow you to reduce the capture rate.
---By default we will capture and interpolate all Position & Quat types, you can adjust this using the include / exclude list.
---@field bAllowInterpolation boolean
---When enabled we allow the cache to be generated for extrapolation.
---This will force the velocity attribute to be maintained.
---@field bAllowVelocityExtrapolation boolean
---When enabled the cache will support serializing large amounts of cache data.
---@field bAllowSerializeLargeCache boolean
---When enabled additional information is stored that can be useful for debugging a simulation
---@field bIncludeDebugData boolean
---List of Attributes to force include in the SimCache rebase, they should be the full path to the attribute
---For example, MyEmitter.Particles.MyQuat would force the particle attribute MyQuat to be included for MyEmitter
---@field RebaseIncludeAttributes string[]
---List of Attributes to force exclude from the SimCache rebase, they should be the full path to the attribute
---For example, MyEmitter.Particles.MyQuat would force the particle attribute MyQuat to be included for MyEmitter
---@field RebaseExcludeAttributes string[]
---List of specific Attributes to include when using interpolation.  They must be types that are supported for interpolation.
---For example, MyEmitter.Particles.MyPosition would force MyPosition to be interpolated.
---@field InterpolationIncludeAttributes string[]
---List of specific Attributes to exclude interpolation for.  They must be types that are supported for interpolation.
---For example, MyEmitter.Particles.MyPosition would force MyPosition to be interpolated.
---@field InterpolationExcludeAttributes string[]
---List of attributes to capture when the capture attribute capture mode is set to explicit.
---For example, adding MyEmitter.Particles.Position will only gather that attribute inside the cache.
---@field ExplicitCaptureAttributes string[]
local NiagaraSimCacheCreateParameters = {}

--- Constructor
---@return NiagaraSimCacheCreateParameters
---@param AttributeCaptureMode ENiagaraSimCacheAttributeCaptureMode
---@param bAllowRebasing boolean
---@param bAllowDataInterfaceCaching boolean
---@param bAllowInterpolation boolean
---@param bAllowVelocityExtrapolation boolean
---@param bAllowSerializeLargeCache boolean
---@param bIncludeDebugData boolean
---@param RebaseIncludeAttributes string[]
---@param RebaseExcludeAttributes string[]
---@param InterpolationIncludeAttributes string[]
---@param InterpolationExcludeAttributes string[]
---@param ExplicitCaptureAttributes string[]
function NiagaraSimCacheCreateParameters.new(AttributeCaptureMode, bAllowRebasing, bAllowDataInterfaceCaching, bAllowInterpolation, bAllowVelocityExtrapolation, bAllowSerializeLargeCache, bIncludeDebugData, RebaseIncludeAttributes, RebaseExcludeAttributes, InterpolationIncludeAttributes, InterpolationExcludeAttributes, ExplicitCaptureAttributes)
    local self = {}
    self.AttributeCaptureMode = AttributeCaptureMode
    self.bAllowRebasing = bAllowRebasing
    self.bAllowDataInterfaceCaching = bAllowDataInterfaceCaching
    self.bAllowInterpolation = bAllowInterpolation
    self.bAllowVelocityExtrapolation = bAllowVelocityExtrapolation
    self.bAllowSerializeLargeCache = bAllowSerializeLargeCache
    self.bIncludeDebugData = bIncludeDebugData
    self.RebaseIncludeAttributes = RebaseIncludeAttributes
    self.RebaseExcludeAttributes = RebaseExcludeAttributes
    self.InterpolationIncludeAttributes = InterpolationIncludeAttributes
    self.InterpolationExcludeAttributes = InterpolationExcludeAttributes
    self.ExplicitCaptureAttributes = ExplicitCaptureAttributes
    return self
end

return NiagaraSimCacheCreateParameters
