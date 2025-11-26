---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class PlatformUserId
---Handle that defines a local user on this platform.
---This used to be just a typedef int32 that was used interchangeably as ControllerId and LocalUserIndex.
---Moving forward these will be allocated by the platform application layer.
---Opaque struct for the FPlatformUserId struct defined in CoreMiscDefines.h
---
--- Properties
---
---@field InternalId integer
local PlatformUserId = {}

--- Constructor
---@return PlatformUserId
---@param InternalId integer
function PlatformUserId.new(InternalId)
    local self = {}
    self.InternalId = InternalId
    return self
end

return PlatformUserId
