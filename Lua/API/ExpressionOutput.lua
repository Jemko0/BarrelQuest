---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class ExpressionOutput
---Struct that represents an expression's output.
---
--- Properties
---@field OutputName string
---@field Mask integer
---@field MaskR integer
---@field MaskG integer
---@field MaskB integer
---@field MaskA integer
local ExpressionOutput = {}

--- Constructor
---@return ExpressionOutput
---@param OutputName string
---@param Mask integer
---@param MaskR integer
---@param MaskG integer
---@param MaskB integer
---@param MaskA integer
function ExpressionOutput.new(OutputName, Mask, MaskR, MaskG, MaskB, MaskA)
    local self = {}
    self.OutputName = OutputName
    self.Mask = Mask
    self.MaskR = MaskR
    self.MaskG = MaskG
    self.MaskB = MaskB
    self.MaskA = MaskA
    return self
end

return ExpressionOutput
