---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class SparseVolumeTexture
---SparseVolumeTexture base interface to communicate with material graph and shader bindings.
---
--- Properties
local SparseVolumeTexture = {}

--- Methods
---Get Size Z
---@return integer
function SparseVolumeTexture.GetSizeZ() end

---Get Size Y
---@return integer
function SparseVolumeTexture.GetSizeY() end

---Get Size X
---@return integer
function SparseVolumeTexture.GetSizeX() end

---Get Num Mip Levels
---@return integer
function SparseVolumeTexture.GetNumMipLevels() end

---Get Num Frames
---@return integer
function SparseVolumeTexture.GetNumFrames() end

---Get Frame Transform
---@return Transform
function SparseVolumeTexture.GetFrameTransform() end

return SparseVolumeTexture
