---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class CurveBase
---Defines a curve of interpolated points to evaluate over a given range
---
--- Properties
---@field AssetImportData AssetImportData
---The filename imported to create this object. Relative to this object's package, BaseDir() or absolute
---@field ImportPath string
local CurveBase = {}

--- Methods
---Get the value range across all curves
---@return nil, number, number
function CurveBase.GetValueRange() end

---Get the time range across all curves
---@return nil, number, number
function CurveBase.GetTimeRange() end

return CurveBase
