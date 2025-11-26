---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class NiagaraSimCache
---Recording of multiple frames of simulation data from a running Niagara system.
---Can be used to play back the captured recording or to inspect the captured data for debug purposes.
---Depending on the capture settings, not all attributes from the simulation are present in the cache.
---To capture a cache, either
---(1) use the baker tool in the system editor,
---(2) use the Niagara component cache track in sequencer or
---(3) manually capture a running system with the "CaptureNiagaraSimCache" Blueprint functions
---
--- Properties
---
local NiagaraSimCache = {}

--- Methods
---Reads Niagara Vec3 attributes by name from the cache frame and appends them into the OutValues array.
---EmitterName - If left blank will return the system simulation attributes.
---@param AttributeName string
---@param EmitterName string
---@param FrameIndex integer
---@return nil, Vector[]
function NiagaraSimCache.ReadVectorAttribute(AttributeName, EmitterName, FrameIndex) end

---Reads Niagara Vec4 attributes by name from the cache frame and appends them into the OutValues array.
---EmitterName - If left blank will return the system simulation attributes.
---@param AttributeName string
---@param EmitterName string
---@param FrameIndex integer
---@return nil, Vector4[]
function NiagaraSimCache.ReadVector4Attribute(AttributeName, EmitterName, FrameIndex) end

---Reads Niagara Vec2 attributes by name from the cache frame and appends them into the OutValues array.
---EmitterName - If left blank will return the system simulation attributes.
---@param AttributeName string
---@param EmitterName string
---@param FrameIndex integer
---@return nil, Vector2D[]
function NiagaraSimCache.ReadVector2Attribute(AttributeName, EmitterName, FrameIndex) end

---Reads Niagara Quaternion attributes by name from the cache frame and appends them into the OutValues array.
---Only attributes that in the rebase list will be transform into the provided Quat space.  Therefore the cache
---must be captured with rebasing enabled to have any impact.
---EmitterName - If left blank will return the system simulation attributes.
---@param Quat Quat
---@param AttributeName string
---@param EmitterName string
---@param FrameIndex integer
---@return nil, Quat[]
function NiagaraSimCache.ReadQuatAttributeWithRebase(Quat, AttributeName, EmitterName, FrameIndex) end

---Reads Niagara Quaternion attributes by name from the cache frame and appends them into the OutValues array.
---Local space emitters provide data at local rotation unless bLocalSpaceToWorld is true.
---EmitterName - If left blank will return the system simulation attributes.
---LocalSpaceToWorld - Caches are always stored in the emitters space, i.e. local or world space.  You can set this to false if you want the local Quat rather than the world Quat.
---@param AttributeName string
---@param EmitterName string
---@param bLocalSpaceToWorld boolean
---@param FrameIndex integer
---@return nil, Quat[]
function NiagaraSimCache.ReadQuatAttribute(AttributeName, EmitterName, bLocalSpaceToWorld, FrameIndex) end

---Reads Niagara Position attributes by name from the cache frame and appends them into the OutValues array.
---All attributes read with this method will be re-based from the captured space into the provided transform space,
---this will occur even if the cache was not captured with re-basing enabled.
---EmitterName - If left blank will return the system simulation attributes.
---@param Transform Transform
---@param AttributeName string
---@param EmitterName string
---@param FrameIndex integer
---@return nil, Vector[]
function NiagaraSimCache.ReadPositionAttributeWithRebase(Transform, AttributeName, EmitterName, FrameIndex) end

---Reads Niagara Position attributes by name from the cache frame and appends them into the OutValues array.
---Local space emitters provide data at local locations unless bLocalSpaceToWorld is true.
---EmitterName - If left blank will return the system simulation attributes.
---LocalSpaceToWorld - Caches are always stored in the emitters space, i.e. local or world space.  You can set this to false if you want the local position rather than the world position.
---@param AttributeName string
---@param EmitterName string
---@param bLocalSpaceToWorld boolean
---@param FrameIndex integer
---@return nil, Vector[]
function NiagaraSimCache.ReadPositionAttribute(AttributeName, EmitterName, bLocalSpaceToWorld, FrameIndex) end

---Reads Niagara int attributes by name from the cache frame and appends them into the OutValues array.
---EmitterName - If left blank will return the system simulation attributes.
---@param AttributeName string
---@param EmitterName string
---@param FrameIndex integer
---@return nil, integer[]
function NiagaraSimCache.ReadIntAttribute(AttributeName, EmitterName, FrameIndex) end

---Reads Niagara ID attributes by name from the cache frame and appends them into the OutValues array.
---EmitterName - If left blank will return the system simulation attributes.
---@param AttributeName string
---@param EmitterName string
---@param FrameIndex integer
---@return nil, NiagaraID[]
function NiagaraSimCache.ReadIDAttribute(AttributeName, EmitterName, FrameIndex) end

---Reads Niagara float attributes by name from the cache frame and appends them into the OutValues array.
---EmitterName - If left blank will return the system simulation attributes.
---@param AttributeName string
---@param EmitterName string
---@param FrameIndex integer
---@return nil, number[]
function NiagaraSimCache.ReadFloatAttribute(AttributeName, EmitterName, FrameIndex) end

---Reads data interface data from the cache as the requested type.
---This method will return nullptr if the attribute does not exists or the requests type is not supported by the storage type.
---@param RequestedType Class
---@param AttributeName string
---@param FrameIndex integer
---@return Object
function NiagaraSimCache.ReadDataInterfaceAs(RequestedType, AttributeName, FrameIndex) end

---Reads Niagara Color attributes by name from the cache frame and appends them into the OutValues array.
---EmitterName - If left blank will return the system simulation attributes.
---@param AttributeName string
---@param EmitterName string
---@param FrameIndex integer
---@return nil, LinearColor[]
function NiagaraSimCache.ReadColorAttribute(AttributeName, EmitterName, FrameIndex) end

---An empty cache contains no frame data and can not be used
---@return boolean
function NiagaraSimCache.IsEmpty() end

---A valid cache is one that contains at least 1 frames worth of data.
---@return boolean
function NiagaraSimCache.IsCacheValid() end

---Get the time the simulation was at when recorded.
---@return number
function NiagaraSimCache.GetStartSeconds() end

---Get number of frames stored in the cache.
---@return integer
function NiagaraSimCache.GetNumFrames() end

---Get number of emitters stored inside the cache.
---@return integer
function NiagaraSimCache.GetNumEmitters() end

---Returns a list of emitters we have captured in the SimCache.
---@return string[]
function NiagaraSimCache.GetEmitterNames() end

---Get the emitter name at the provided index.
---@param EmitterIndex integer
---@return string
function NiagaraSimCache.GetEmitterName(EmitterIndex) end

---How were the attributes captured for this sim cache.
---@return ENiagaraSimCacheAttributeCaptureMode
function NiagaraSimCache.GetAttributeCaptureMode() end

return NiagaraSimCache
