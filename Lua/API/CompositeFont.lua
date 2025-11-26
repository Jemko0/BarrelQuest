---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class CompositeFont
---Composite Font
---
--- Properties
---
---The default typeface that will be used when not overridden by a sub-typeface
---@field DefaultTypeface Typeface
---The fallback typeface that will be used as a last resort when no other typeface provides a match
---@field FallbackTypeface CompositeFallbackFont
---Sub-typefaces to use for a specific set of characters
---@field SubTypefaces CompositeSubFont[]
---If set to false, the ascent and descent override specified in a Font face will be ignored, and the value from the font source file will be used instead.
---@field bEnableAscentDescentOverride boolean
local CompositeFont = {}

--- Constructor
---@return CompositeFont
---@param DefaultTypeface Typeface
---@param FallbackTypeface CompositeFallbackFont
---@param SubTypefaces CompositeSubFont[]
---@param bEnableAscentDescentOverride boolean
function CompositeFont.new(DefaultTypeface, FallbackTypeface, SubTypefaces, bEnableAscentDescentOverride)
    local self = {}
    self.DefaultTypeface = DefaultTypeface
    self.FallbackTypeface = FallbackTypeface
    self.SubTypefaces = SubTypefaces
    self.bEnableAscentDescentOverride = bEnableAscentDescentOverride
    return self
end

return CompositeFont
