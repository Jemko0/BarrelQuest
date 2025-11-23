---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class AudioParameter
---Audio Parameter
---
--- Properties
---Name of the parameter
---@field ParamName string
---Float value of parameter
---@field FloatParam number
---Boolean value of parameter
---@field BoolParam boolean
---Integer value of parameter. If set to 'Default Construct', value is number of array items to construct.
---@field IntParam integer
---Object value of parameter
---@field ObjectParam Object
---String value of parameter
---@field StringParam string
---Array Float value of parameter
---@field ArrayFloatParam number[]
---Boolean value of parameter
---@field ArrayBoolParam boolean[]
---Integer value of parameter
---@field ArrayIntParam integer[]
---Object value of parameter
---@field ArrayObjectParam Object[]
---String value of parameter
---@field ArrayStringParam string[]
---@field ParamType EAudioParameterType
---Optional TypeName used to describe what constructed type this parameter should be initializing.
---@field TypeName string
local AudioParameter = {}
return AudioParameter
