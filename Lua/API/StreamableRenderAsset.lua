---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class StreamableRenderAsset
---Streamable Render Asset
---
--- Properties
---
---WorldSettings timestamp that tells the streamer to force all miplevels to be resident up until that time.
---@field ForceMipLevelsToBeResidentTimestamp number
---Number of mip-levels to use for cinematic quality.
---@field NumCinematicMipLevels integer
---@field NoRefStreamingLODBias PerQualityLevelInt
---FStreamingRenderAsset index used by the texture streaming system.
---@field StreamingIndex integer
---@field NeverStream boolean
---Global and serialized version of ForceMiplevelsToBeResident.
---@field bGlobalForceMipLevelsToBeResident boolean
---Whether some mips might be streamed soon. If false, the texture is not planned resolution will be stable.
---@field bHasStreamingUpdatePending boolean
---Override whether to fully stream even if texture hasn't been rendered.
---@field bForceMiplevelsToBeResident boolean
---When forced fully resident, ignores the streaming mip bias used to accommodate memory constraints.
---@field bIgnoreStreamingMipBias boolean
---Object marked as being part of Editors Pool
---@field bMarkAsEditorStreamingPool boolean
---Whether to use the extra cinematic quality mip-levels, when we're forcing mip-levels to be resident.
---@field bUseCinematicMipLevels boolean
local StreamableRenderAsset = {}

--- Methods
---Tells the streaming system that it should force all mip-levels to be resident for a number of seconds.
---@param Seconds number
---@param CinematicLODGroupMask integer
---@return nil
function StreamableRenderAsset.SetForceMipLevelsToBeResident(Seconds, CinematicLODGroupMask) end

return StreamableRenderAsset
