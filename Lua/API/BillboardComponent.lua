---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class BillboardComponent : PrimitiveComponent
---A 2d texture that will be rendered always facing the camera.
---
--- Properties
---
---@field Sprite Texture2D
---@field bIsScreenSizeScaled boolean
---@field ScreenSize number
---@field U number
---@field UL number
---@field V number
---@field VL number
---The billboard is not rendered where texture opacity < OpacityMaskRefVal
---@field OpacityMaskRefVal number
---Sprite category that the component belongs to. Value serves as a key into the localization file.
---@field SpriteCategoryName string
---Sprite category information regarding the component
---@field SpriteInfo SpriteCategoryInfo
---Whether to use in-editor arrow scaling (i.e. to be affected by the global arrow scale)
---@field bUseInEditorScaling boolean
---@field bShowLockedLocation boolean
local BillboardComponent = {}

--- Methods
---Change the sprite's UVs
---@param NewU integer
---@param NewUL integer
---@param NewV integer
---@param NewVL integer
---@return nil
function BillboardComponent.SetUV(NewU, NewUL, NewV, NewVL) end

---Change the sprite texture and the UV's used by this component
---@param NewSprite Texture2D
---@param NewU integer
---@param NewUL integer
---@param NewV integer
---@param NewVL integer
---@return nil
function BillboardComponent.SetSpriteAndUV(NewSprite, NewU, NewUL, NewV, NewVL) end

---Change the sprite texture used by this component
---@param NewSprite Texture2D
---@return nil
function BillboardComponent.SetSprite(NewSprite) end

---Changed the opacity masked used by this component
---@param RefVal number
---@return nil
function BillboardComponent.SetOpacityMaskRefVal(RefVal) end

return BillboardComponent
