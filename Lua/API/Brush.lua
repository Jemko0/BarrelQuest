---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class Brush : Actor
---Brush
---
--- Properties
---
---Type of brush
---@field BrushType integer
---Information.
---@field BrushColor Color
---@field PolyFlags integer
---@field bColored boolean
---@field bSolidWhenSelected boolean
---If true, this brush class can be placed using the class browser like other simple class types
---@field bPlaceableFromClassBrowser boolean
---If true, this brush is a builder or otherwise does not need to be loaded into the game
---@field bNotForClientOrServer boolean
---@field Brush Model
---@field BrushBuilder BrushBuilder
---If true, display the brush with a shaded volume
---@field bDisplayShadedVolume boolean
---Value used to set the opacity for the shaded volume, between 0-1
---@field ShadedVolumeOpacityValue number
---Flag set when we are in a manipulation (scaling, translation, brush builder param change etc.)
---@field bInManipulation boolean
---Stores selection information from geometry mode.  This is the only information that we can't
---regenerate by looking at the source brushes following an undo operation.
---@field SavedSelections GeomSelection[]
local Brush = {}

--- Methods
return Brush
