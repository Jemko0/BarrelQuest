---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class ArrowComponent : PrimitiveComponent
---A simple arrow rendered using lines. Useful for indicating which way an object is facing.
---
--- Properties
---Color to draw arrow
---@field ArrowColor Color
---Relative size to scale drawn arrow by
---@field ArrowSize number
---Total length of drawn arrow including head
---@field ArrowLength number
---The size on screen to limit this arrow to (in screen space)
---@field ScreenSize number
---Set to limit the screen size of this arrow
---@field bIsScreenSizeScaled boolean
---If true, don't show the arrow when EngineShowFlags.BillboardSprites is disabled.
---@field bTreatAsASprite boolean
---Sprite category that the arrow component belongs to, if being treated as a sprite. Value serves as a key into the localization file.
---@field SpriteCategoryName string
---Sprite category information regarding the arrow component, if being treated as a sprite.
---@field SpriteInfo SpriteCategoryInfo
---If true, this arrow component is attached to a light actor
---@field bLightAttachment boolean
---Whether to use in-editor arrow scaling (i.e. to be affected by the global arrow scale)
---@field bUseInEditorScaling boolean
local ArrowComponent = {}

--- Methods
---Set Use in Editor Scaling
---@param bNewValue boolean
---@return nil
function ArrowComponent.SetUseInEditorScaling(bNewValue) end

---Set Treat as ASprite
---@param bNewValue boolean
---@return nil
function ArrowComponent.SetTreatAsASprite(bNewValue) end

---Set Screen Size
---@param NewScreenSize number
---@return nil
function ArrowComponent.SetScreenSize(NewScreenSize) end

---Set Is Screen Size Scaled
---@param bNewValue boolean
---@return nil
function ArrowComponent.SetIsScreenSizeScaled(bNewValue) end

---Set Arrow Size
---@param NewSize number
---@return nil
function ArrowComponent.SetArrowSize(NewSize) end

---Set Arrow Length
---@param NewLength number
---@return nil
function ArrowComponent.SetArrowLength(NewLength) end

---Set Arrow FColor
---@param NewColor Color
---@return nil
function ArrowComponent.SetArrowFColor(NewColor) end

---Updates the arrow's colour, and tells it to refresh
---@param NewColor LinearColor
---@return nil
function ArrowComponent.SetArrowColor(NewColor) end

return ArrowComponent
