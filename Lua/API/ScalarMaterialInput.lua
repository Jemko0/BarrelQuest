---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class ScalarMaterialInput
---Scalar Material Input
---
--- Properties
---@field UseConstant boolean
---@field Constant number
---Material expression that this input is connected to, or NULL if not connected.
---@field Expression MaterialExpression
---Index into Expression's outputs array that this input is connected to.
---@field OutputIndex integer
---Optional name of the input.
---Note that this is the only member which is not derived from the output currently connected.
---@field InputName string
---@field Mask integer
---@field MaskR integer
---@field MaskG integer
---@field MaskB integer
---@field MaskA integer
local ScalarMaterialInput = {}
return ScalarMaterialInput
