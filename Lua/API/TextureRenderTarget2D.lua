---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class TextureRenderTarget2D : TextureRenderTarget
---TextureRenderTarget2D
---2D render target texture resource. This can be used as a target
---for rendering as well as rendered as a regular 2D texture resource.
---
--- Properties
---
---The width of the texture.
---@field SizeX integer
---The height of the texture.
---@field SizeY integer
---the color the texture is cleared to
---@field ClearColor LinearColor
---The addressing mode to use for the X axis.
---@field AddressX integer
---The addressing mode to use for the Y axis.
---@field AddressY integer
---True to force linear gamma space for this render target
---@field bForceLinearGamma boolean
---Whether to support storing HDR values, which requires more memory.
---@field bHDR boolean
---Whether to support GPU sharing of the underlying native texture resource.
---@field bGPUSharedFlag boolean
---Format of the texture render target.
---Data written to the render target will be quantized to this format, which can limit the range and precision.
---The largest format (RTF_RGBA32f) uses 16x more memory and bandwidth than the smallest (RTF_R8) and can greatly affect performance.
---Use the smallest format that has enough precision and range for what you are doing.
---@field RenderTargetFormat integer
---Whether this render target can be used as an unordered access view
---@field bSupportsUAV boolean
---Whether to support Mip maps for this render target texture
---@field bAutoGenerateMips boolean
---Sampler filter type for AutoGenerateMips. Defaults to match texture filter.
---@field MipsSamplerFilter integer
---AutoGenerateMips sampler address mode for U channel. Defaults to clamp.
---@field MipsAddressU integer
---AutoGenerateMips sampler address mode for V channel. Defaults to clamp.
---@field MipsAddressV integer
---Normally the format is derived from RenderTargetFormat, this allows code to set the format explicitly.
---@field OverrideFormat integer
local TextureRenderTarget2D = {}

--- Methods
return TextureRenderTarget2D
