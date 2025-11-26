---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class AnimationDebugUI_C : UserWidget
---Animation Debug UI
---
--- Properties
---
---@field UberGraphFrame PointerToUberGraphFrame
---@field VerticalBox_0 VerticalBox
---@field TextBlock_0 TextBlock
---@field pre Button
---@field nex Button
---@field AvailableAnims AnimSequence[]
---@field animIndex integer
---@field char BarrelCharacter_C
local AnimationDebugUI_C = {}

--- Methods
---Get Text 0
---@return string
function AnimationDebugUI_C.GetText_0() end

---Next Anim
---@return nil
function AnimationDebugUI_C.NextAnim() end

---Prev Anim
---@return nil
function AnimationDebugUI_C.PrevAnim() end

return AnimationDebugUI_C
