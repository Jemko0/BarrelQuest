---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class RawCurveTracks
---Raw Curve data for serialization
---
--- Properties
---@field FloatCurves FloatCurve[]
---@note : Currently VectorCurves are not evaluated or used for anything else but transient data for modifying bone track
---                     Note that it doesn't have UPROPERTY tag yet. In the future, we'd like this to be serialized, but not for now
---@field VectorCurves VectorCurve[]
---@note : TransformCurves are used to edit additive animation in editor.
---@field TransformCurves TransformCurve[]
local RawCurveTracks = {}
return RawCurveTracks
