---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class Vector2MaterialInput
---Vector 2Material Input
---
--- Properties
---@field UseConstant boolean
---@field ConstantX number
---@field ConstantY number
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
local Vector2MaterialInput = {}

--- Constructor
---@return Vector2MaterialInput
---@param UseConstant boolean
---@param ConstantX number
---@param ConstantY number
---@param Expression MaterialExpression
---@param OutputIndex integer
---@param InputName string
---@param Mask integer
---@param MaskR integer
---@param MaskG integer
---@param MaskB integer
---@param MaskA integer
function Vector2MaterialInput.new(UseConstant, ConstantX, ConstantY, Expression, OutputIndex, InputName, Mask, MaskR, MaskG, MaskB, MaskA)
    local self = {}
    self.UseConstant = UseConstant
    self.ConstantX = ConstantX
    self.ConstantY = ConstantY
    self.Expression = Expression
    self.OutputIndex = OutputIndex
    self.InputName = InputName
    self.Mask = Mask
    self.MaskR = MaskR
    self.MaskG = MaskG
    self.MaskB = MaskB
    self.MaskA = MaskA
    return self
end

return Vector2MaterialInput
