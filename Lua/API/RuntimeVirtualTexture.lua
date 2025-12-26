---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class RuntimeVirtualTexture
---Runtime virtual texture UObject
---
--- Properties
---
---Size of virtual texture in tiles. (Actual values increase in powers of 2).
---This is applied to the largest axis in world space and the size for any shorter axis is chosen to maintain aspect ratio.
---@field TileCount integer
---Page tile size. (Actual values increase in powers of 2)
---@field TileSize integer
---Page tile border size divided by 2 (Actual values increase in multiples of 2). Higher values trigger a higher anisotropic sampling level.
---@field TileBorderSize integer
---Contents of virtual texture.
---@field MaterialType ERuntimeVirtualTextureMaterialType
---Enable storing the virtual texture in GPU supported compression formats. Using uncompressed is only recommended for debugging and quality comparisons.
---@field bCompressTextures boolean
---Use low quality textures (RGB565/RGB555A1) to replace runtime compression
---@field bUseLowQualityCompression boolean
---Allows to override the default priority that this runtime virtual texture has, relative to other virtual texture producers. This allows to get the pages from this virtual texture to update faster than others in case of high contention.
---@field CustomPriority EVTProducerPriority
---@field bUseCustomPriority boolean
---Enable clear before rendering a page of the virtual texture. Disabling this can be an optimization if you know that the texture will always be fully covered by rendering.
---@field bClearTextures boolean
---Enable page table channel packing. This reduces page table memory and update cost but can reduce the ability to share physical memory with other virtual textures.
---@field bSinglePhysicalSpace boolean
---Enable private page table allocation. This can reduce total page table memory allocation but can also reduce the total number of virtual textures supported.
---@field bPrivateSpace boolean
---Enable sparse adaptive page tables. This supports larger tile counts but adds an indirection cost when sampling the virtual texture. It is recommended only when very large virtual resolutions are necessary.
---@field bAdaptive boolean
---Enable continuous update of the virtual texture pages. This round-robin updates already mapped pages and can help fix pages that are mapped before dependent textures are fully streamed in.
---@field bContinuousUpdate boolean
---Number of low mips to cut from the virtual texture. This can reduce peak virtual texture update cost but will also increase the probability of mip shimmering.
---@field RemoveLowMips integer
---A float4 custom value that can be read in the material that writes this virtual texture.
---@field CustomMaterialData Vector4f
---Texture group this texture belongs to
---@field LODGroup integer
---Deprecated size of virtual texture.
---@field Size integer
---Deprecated texture object containing streamed low mips.
---@field StreamingTexture RuntimeVirtualTextureStreamingProxy
local RuntimeVirtualTexture = {}

--- Methods
---Public getter for virtual texture tile size
---@return integer
function RuntimeVirtualTexture.GetTileSize() end

---Public getter for virtual texture tile count
---@return integer
function RuntimeVirtualTexture.GetTileCount() end

---Public getter for virtual texture tile border size
---@return integer
function RuntimeVirtualTexture.GetTileBorderSize() end

---Public getter for virtual texture size. This is derived from the TileCount and TileSize.
---@return integer
function RuntimeVirtualTexture.GetSize() end

---Public getter for virtual texture page table size. This is only different from GetTileCount() when using an adaptive page table.
---@return integer
function RuntimeVirtualTexture.GetPageTableSize() end

return RuntimeVirtualTexture
