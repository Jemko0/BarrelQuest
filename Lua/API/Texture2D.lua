---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class Texture2D : Texture
---Texture 2D
---
--- Properties
---
---keep track of first mip level used for ResourceMem creation
---@field FirstResourceMemMip integer
---Whether the texture has been painted in the editor.
---@field bHasBeenPaintedInEditor boolean
---The addressing mode to use for the X axis.
---@field AddressX integer
---The addressing mode to use for the Y axis.
---@field AddressY integer
---If we ever show the CPU accessible image in the editor we'll need a transient texture with
---those bits in it. If we don't have a CPU copy, then this is null. Use the GetCPUCopyTexture to
---access as it's created on demand.
---@field CPUCopyTexture Texture2D
local Texture2D = {}

--- Methods
---Gets the Y size of the texture, in pixels
---@return integer
function Texture2D.Blueprint_GetSizeY() end

---Gets the X size of the texture, in pixels
---@return integer
function Texture2D.Blueprint_GetSizeX() end

---Blueprint Get CPUCopy
---@return SharedImageConstRefBlueprint
function Texture2D.Blueprint_GetCPUCopy() end

return Texture2D
