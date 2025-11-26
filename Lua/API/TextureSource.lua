---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class TextureSource
---Texture source data management.
---
--- Properties
---
---GUID used to track changes to the source data.
---      Typically with UseHashAsGuid , this "Id" is the hash of the BulkData.
---      Note that GetId() is not == Id.
---@field Id Guid
---Position of texture block0, only relevant if source has multiple blocks
---@field BaseBlockX integer
---@field BaseBlockY integer
---Width of the texture.
---@field SizeX integer
---Height of the texture.
---@field SizeY integer
---Depth (volume textures) or faces (cube maps).
---@field NumSlices integer
---Number of mips provided as source data for the texture.
---@field NumMips integer
---Number of layers (for multi-layered virtual textures) provided as source data for the texture.
---@field NumLayers integer
---RGBA8 source data is optionally compressed as PNG.
---      Deprecated, use CompressionFormat instead.  To be removed.
---      Deprecated uproperties are loaded but not saved.
---@field bPNGCompressed boolean
---Source represents a cubemap in long/lat format, will have only 1 slice per cube, rather than 6 slices.
---Not needed for non-array cubemaps, since we can just look at NumSlices == 1 or 6
---But for cube arrays, no way of determining whether NumSlices=6 means 1 cubemap, or 6 long/lat cubemaps
---@field bLongLatCubemap boolean
---Compression format that source data is stored as.
---@field CompressionFormat integer
---Uses hash instead of guid to identify content to improve DDC cache hit.
---@field bGuidIsHash boolean
---Per layer color info. If this is empty we don't have the data, otherwise count is == NumLayers.
---      Protected by BulkDataLock for thread safety.  Use Get/Set accessors which do the locking for you.
---@field LayerColorInfo_LockProtected TextureSourceLayerColorInfo[]
---Format in which the source data is stored.
---@field Format integer
---For multi-layered sources, each layer may have a different format (in this case LayerFormat[0] == Format) .
---@field LayerFormat integer[]
---All sources have 1 implicit block defined by BaseBlockXY/SizeXY members.  Textures imported as UDIM may have additional blocks defined here.
---These are stored sequentially in the source's bulk data.
---@field Blocks TextureSourceBlock[]
---Offsets of each block (including Block0) in the bulk data.
---Blocks are not necessarily stored in order, since block indices are sorted by X/Y location.
---For non-UDIM textures, this will always have a single entry equal to 0
---@field BlockDataOffsets integer[]
local TextureSource = {}

--- Constructor
---@return TextureSource
---@param Id Guid
---@param BaseBlockX integer
---@param BaseBlockY integer
---@param SizeX integer
---@param SizeY integer
---@param NumSlices integer
---@param NumMips integer
---@param NumLayers integer
---@param bPNGCompressed boolean
---@param bLongLatCubemap boolean
---@param CompressionFormat integer
---@param bGuidIsHash boolean
---@param LayerColorInfo_LockProtected TextureSourceLayerColorInfo[]
---@param Format integer
---@param LayerFormat integer[]
---@param Blocks TextureSourceBlock[]
---@param BlockDataOffsets integer[]
function TextureSource.new(Id, BaseBlockX, BaseBlockY, SizeX, SizeY, NumSlices, NumMips, NumLayers, bPNGCompressed, bLongLatCubemap, CompressionFormat, bGuidIsHash, LayerColorInfo_LockProtected, Format, LayerFormat, Blocks, BlockDataOffsets)
    local self = {}
    self.Id = Id
    self.BaseBlockX = BaseBlockX
    self.BaseBlockY = BaseBlockY
    self.SizeX = SizeX
    self.SizeY = SizeY
    self.NumSlices = NumSlices
    self.NumMips = NumMips
    self.NumLayers = NumLayers
    self.bPNGCompressed = bPNGCompressed
    self.bLongLatCubemap = bLongLatCubemap
    self.CompressionFormat = CompressionFormat
    self.bGuidIsHash = bGuidIsHash
    self.LayerColorInfo_LockProtected = LayerColorInfo_LockProtected
    self.Format = Format
    self.LayerFormat = LayerFormat
    self.Blocks = Blocks
    self.BlockDataOffsets = BlockDataOffsets
    return self
end

return TextureSource
