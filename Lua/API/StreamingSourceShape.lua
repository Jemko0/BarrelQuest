---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class StreamingSourceShape
---Streaming Source Shape
---
--- Properties
---If True, streaming source shape radius is bound to loading range radius.
---@field bUseGridLoadingRange boolean
---Applies a scale to the grid's loading range (used if bUseGridLoadingRange is True).
---@field LoadingRangeScale number
---Custom streaming source shape radius (not used if bUseGridLoadingRange is True).
---@field Radius number
---Whether the source shape is a spherical sector instead of a regular sphere source.
---@field bIsSector boolean
---Shape's spherical sector angle in degree (not used if bIsSector is False).
---@field SectorAngle number
---Streaming source shape location (local to streaming source).
---@field Location Vector
---Streaming source shape rotation (local to streaming source).
---@field Rotation Rotator
local StreamingSourceShape = {}
return StreamingSourceShape
