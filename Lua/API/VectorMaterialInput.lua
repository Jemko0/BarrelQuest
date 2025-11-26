---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class VectorMaterialInput
---Vector Material Input
---
--- Properties
---@field UseConstant boolean
---@field Constant Vector3f
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
local VectorMaterialInput = {}

--- Constructor
---@return VectorMaterialInput
---@param UseConstant boolean
---@param Constant Vector3f
---@param Expression MaterialExpression
---@param OutputIndex integer
---@param InputName string
---@param Mask integer
---@param MaskR integer
---@param MaskG integer
---@param MaskB integer
---@param MaskA integer
function VectorMaterialInput.new(UseConstant, Constant, Expression, OutputIndex, InputName, Mask, MaskR, MaskG, MaskB, MaskA)
    local self = {}
    self.UseConstant = UseConstant
    self.Constant = Constant
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

return VectorMaterialInput
