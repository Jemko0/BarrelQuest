---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class HUD : Actor
---Base class of the heads-up display. This has a canvas and a debug canvas on which primitives can be drawn.
---It also contains a list of simple hit boxes that can be used for simple item click detection.
---A method of rendering debug text is also included.
---Provides some simple methods for rendering text, textures, rectangles and materials which can also be accessed from blueprints.
---@see UCanvas
---@see FHUDHitBox
---@see FDebugTextInfo
---
--- Properties
---
---PlayerController which owns this HUD.
---@field PlayerOwner PlayerController
---Tells whether the game was paused due to lost focus
---@field bLostFocusPaused boolean
---Whether or not the HUD should be drawn.
---@field bShowHUD boolean
---If true, current ViewTarget shows debug information using its DisplayDebug().
---@field bShowDebugInfo boolean
---Current target in our considered Targets list for 'showdebug'
---@field CurrentTargetIndex integer
---If true, show hitbox debugging info.
---@field bShowHitBoxDebugInfo boolean
---If true, render actor overlays.
---@field bShowOverlays boolean
---Put shadow on debug strings
---@field bEnableDebugTextShadow boolean
---Holds a list of Actors that need PostRender() calls.
---@field PostRenderedActors Actor[]
---Array of names specifying what debug info to display for viewtarget actor.
---@field DebugDisplay string[]
---Array of names specifying what subsets of debug info to display for viewtarget actor.
---@field ToggledDebugCategories string[]
---Canvas to Draw HUD on.  Only valid during PostRender() event.
---@field Canvas Canvas
---'Foreground' debug canvas, will draw in front of Slate UI.
---@field DebugCanvas Canvas
---List of debug strings attached to actors, sorted by actor first, then by order of addition
---@field DebugTextList DebugTextInfo[]
---Class filter for selecting 'ShowDebugTargetActor' when 'bShowDebugForReticleTarget' is true.
---@field ShowDebugTargetDesiredClass Class
---Show Debug Actor used if 'bShowDebugForReticleTarget' is true, only updated if trace from reticle hit a new Actor of class 'ShowDebugTargetDesiredClass'
---@field ShowDebugTargetActor Actor
local HUD = {}

--- Methods
---Transforms a 3D world-space vector into 2D screen coordinates
---@param Location Vector
---@param bClampToZeroPlane boolean
---@return Vector
function HUD.Project(Location, bClampToZeroPlane) end

---Returns the width and height of a string.
---@param Text string
---@param Font Font
---@param Scale number
---@return nil, number, number
function HUD.GetTextSize(Text, Font, Scale) end

---Returns the PlayerController for this HUD's player.
---@return PlayerController
function HUD.GetOwningPlayerController() end

---Returns the Pawn for this HUD's player.
---@return Pawn
function HUD.GetOwningPawn() end

---Returns the array of actors inside a selection rectangle, with a class filter.
---Sample usage:
---      TArray<AStaticMeshActor*> ActorsInSelectionRect;
---             Canvas->GetActorsInSelectionRectangle<AStaticMeshActor>(FirstPoint,SecondPoint,ActorsInSelectionRect);
---@param ClassFilter Class
---@param bIncludeNonCollidingComponents boolean
---@param bActorMustBeFullyEnclosed boolean
---@return nil, Actor[]
function HUD.GetActorsInSelectionRectangle(ClassFilter, bIncludeNonCollidingComponents, bActorMustBeFullyEnclosed) end

---Draws a textured quad on the HUD. Assumes 1:1 texel density.
---@param Texture Texture
---@param ScreenX number
---@param ScreenY number
---@param Scale number
---@param bScalePosition boolean
---@return nil
function HUD.DrawTextureSimple(Texture, ScreenX, ScreenY, Scale, bScalePosition) end

---Draws a textured quad on the HUD.
---@param Texture Texture
---@param ScreenX number
---@param ScreenY number
---@param ScreenW number
---@param ScreenH number
---@param TextureU number
---@param TextureV number
---@param TextureUWidth number
---@param TextureVHeight number
---@param TintColor LinearColor
---@param BlendMode integer
---@param Scale number
---@param bScalePosition boolean
---@param Rotation number
---@param RotPivot Vector2D
---@return nil
function HUD.DrawTexture(Texture, ScreenX, ScreenY, ScreenW, ScreenH, TextureU, TextureV, TextureUWidth, TextureVHeight, TintColor, BlendMode, Scale, bScalePosition, Rotation, RotPivot) end

---Draws a string on the HUD.
---@param Text string
---@param TextColor LinearColor
---@param ScreenX number
---@param ScreenY number
---@param Font Font
---@param Scale number
---@param bScalePosition boolean
---@return nil
function HUD.DrawText(Text, TextColor, ScreenX, ScreenY, Font, Scale, bScalePosition) end

---Draws a colored untextured quad on the HUD.
---@param RectColor LinearColor
---@param ScreenX number
---@param ScreenY number
---@param ScreenW number
---@param ScreenH number
---@return nil
function HUD.DrawRect(RectColor, ScreenX, ScreenY, ScreenW, ScreenH) end

---Draw Material Triangle
---@param Material MaterialInterface
---@param V0_Pos Vector2D
---@param V1_Pos Vector2D
---@param V2_Pos Vector2D
---@param V0_UV Vector2D
---@param V1_UV Vector2D
---@param V2_UV Vector2D
---@param V0_Color LinearColor
---@param V1_Color LinearColor
---@param V2_Color LinearColor
---@return nil
function HUD.DrawMaterialTriangle(Material, V0_Pos, V1_Pos, V2_Pos, V0_UV, V1_UV, V2_UV, V0_Color, V1_Color, V2_Color) end

---Draws a material-textured quad on the HUD.  Assumes UVs such that the entire material is shown.
---@param Material MaterialInterface
---@param ScreenX number
---@param ScreenY number
---@param ScreenW number
---@param ScreenH number
---@param Scale number
---@param bScalePosition boolean
---@return nil
function HUD.DrawMaterialSimple(Material, ScreenX, ScreenY, ScreenW, ScreenH, Scale, bScalePosition) end

---Draws a material-textured quad on the HUD.
---@param Material MaterialInterface
---@param ScreenX number
---@param ScreenY number
---@param ScreenW number
---@param ScreenH number
---@param MaterialU number
---@param MaterialV number
---@param MaterialUWidth number
---@param MaterialVHeight number
---@param Scale number
---@param bScalePosition boolean
---@param Rotation number
---@param RotPivot Vector2D
---@return nil
function HUD.DrawMaterial(Material, ScreenX, ScreenY, ScreenW, ScreenH, MaterialU, MaterialV, MaterialUWidth, MaterialVHeight, Scale, bScalePosition, Rotation, RotPivot) end

---Draws a 2D line on the HUD.
---@param StartScreenX number
---@param StartScreenY number
---@param EndScreenX number
---@param EndScreenY number
---@param LineColor LinearColor
---@param LineThickness number
---@return nil
function HUD.DrawLine(StartScreenX, StartScreenY, EndScreenX, EndScreenY, LineColor, LineThickness) end

---Transforms a 2D screen location into a 3D location and direction
---@param ScreenX number
---@param ScreenY number
---@return nil, Vector, Vector
function HUD.Deproject(ScreenX, ScreenY) end

---Add a hitbox to the hud
---@param Position Vector2D
---@param Size Vector2D
---@param InName string
---@param bConsumesInput boolean
---@param Priority integer
---@return nil
function HUD.AddHitBox(Position, Size, InName, bConsumesInput, Priority) end

return HUD
