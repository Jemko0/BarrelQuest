---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class Guid
---A globally unique identifier (mirrored from Guid.h)
---
--- Properties
---
---@field A integer
---@field B integer
---@field C integer
---@field D integer
local Guid = {}

--- Constructor
---@return Guid
---@param A integer
---@param B integer
---@param C integer
---@param D integer
function Guid.new(A, B, C, D)
    local self = {}
    self.A = A
    self.B = B
    self.C = C
    self.D = D
    return self
end

return Guid
