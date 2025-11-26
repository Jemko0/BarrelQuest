---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class FontImportOptionsData
---Font import options
---
--- Properties
---
---Name of the typeface for the font to import
---@field FontName string
---Height of font (point size)
---@field Height number
---Whether the font should be antialiased or not.  Usually you should leave this enabled.
---@field bEnableAntialiasing boolean
---Whether the font should be generated in bold or not
---@field bEnableBold boolean
---Whether the font should be generated in italics or not
---@field bEnableItalic boolean
---Whether the font should be generated with an underline or not
---@field bEnableUnderline boolean
---if true then forces PF_G8 and only maintains Alpha value and discards color
---@field bAlphaOnly boolean
---Character set for this font
---@field CharacterSet integer
---Explicit list of characters to include in the font
---@field Chars string
---Range of Unicode character values to include in the font.  You can specify ranges using hyphens and/or commas (e.g. '400-900')
---@field UnicodeRange string
---Path on disk to a folder where files that contain a list of characters to include in the font
---@field CharsFilePath string
---File mask wildcard that specifies which files within the CharsFilePath to scan for characters in include in the font
---@field CharsFileWildcard string
---Skips generation of glyphs for any characters that are not considered 'printable'
---@field bCreatePrintableOnly boolean
---When specifying a range of characters and this is enabled, forces ASCII characters (0 thru 255) to be included as well
---@field bIncludeASCIIRange boolean
---Color of the foreground font pixels.  Usually you should leave this white and instead use the UI Styles editor to change the color of the font on the fly
---@field ForegroundColor LinearColor
---Enables a very simple, 1-pixel, black colored drop shadow for the generated font
---@field bEnableDropShadow boolean
---Horizontal size of each texture page for this font in pixels
---@field TexturePageWidth integer
---The maximum vertical size of a texture page for this font in pixels.  The actual height of a texture page may be less than this if the font can fit within a smaller sized texture page.
---@field TexturePageMaxHeight integer
---Horizontal padding between each font character on the texture page in pixels
---@field XPadding integer
---Vertical padding between each font character on the texture page in pixels
---@field YPadding integer
---How much to extend the top of the UV coordinate rectangle for each character in pixels
---@field ExtendBoxTop integer
---How much to extend the bottom of the UV coordinate rectangle for each character in pixels
---@field ExtendBoxBottom integer
---How much to extend the right of the UV coordinate rectangle for each character in pixels
---@field ExtendBoxRight integer
---How much to extend the left of the UV coordinate rectangle for each character in pixels
---@field ExtendBoxLeft integer
---Enables legacy font import mode.  This results in lower quality antialiasing and larger glyph bounds, but may be useful when debugging problems
---@field bEnableLegacyMode boolean
---The initial horizontal spacing adjustment between rendered characters.  This setting will be copied directly into the generated Font object's properties.
---@field Kerning integer
---If true then the alpha channel of the font textures will store a distance field instead of a color mask
---@field bUseDistanceFieldAlpha boolean
---Scale factor determines how big to scale the font bitmap during import when generating distance field values
---Note that higher values give better quality but importing will take much longer.
---@field DistanceFieldScaleFactor integer
---Shrinks or expands the scan radius used to determine the silhouette of the font edges.
---@field DistanceFieldScanRadiusScale number
local FontImportOptionsData = {}

--- Constructor
---@return FontImportOptionsData
---@param FontName string
---@param Height number
---@param bEnableAntialiasing boolean
---@param bEnableBold boolean
---@param bEnableItalic boolean
---@param bEnableUnderline boolean
---@param bAlphaOnly boolean
---@param CharacterSet integer
---@param Chars string
---@param UnicodeRange string
---@param CharsFilePath string
---@param CharsFileWildcard string
---@param bCreatePrintableOnly boolean
---@param bIncludeASCIIRange boolean
---@param ForegroundColor LinearColor
---@param bEnableDropShadow boolean
---@param TexturePageWidth integer
---@param TexturePageMaxHeight integer
---@param XPadding integer
---@param YPadding integer
---@param ExtendBoxTop integer
---@param ExtendBoxBottom integer
---@param ExtendBoxRight integer
---@param ExtendBoxLeft integer
---@param bEnableLegacyMode boolean
---@param Kerning integer
---@param bUseDistanceFieldAlpha boolean
---@param DistanceFieldScaleFactor integer
---@param DistanceFieldScanRadiusScale number
function FontImportOptionsData.new(FontName, Height, bEnableAntialiasing, bEnableBold, bEnableItalic, bEnableUnderline, bAlphaOnly, CharacterSet, Chars, UnicodeRange, CharsFilePath, CharsFileWildcard, bCreatePrintableOnly, bIncludeASCIIRange, ForegroundColor, bEnableDropShadow, TexturePageWidth, TexturePageMaxHeight, XPadding, YPadding, ExtendBoxTop, ExtendBoxBottom, ExtendBoxRight, ExtendBoxLeft, bEnableLegacyMode, Kerning, bUseDistanceFieldAlpha, DistanceFieldScaleFactor, DistanceFieldScanRadiusScale)
    local self = {}
    self.FontName = FontName
    self.Height = Height
    self.bEnableAntialiasing = bEnableAntialiasing
    self.bEnableBold = bEnableBold
    self.bEnableItalic = bEnableItalic
    self.bEnableUnderline = bEnableUnderline
    self.bAlphaOnly = bAlphaOnly
    self.CharacterSet = CharacterSet
    self.Chars = Chars
    self.UnicodeRange = UnicodeRange
    self.CharsFilePath = CharsFilePath
    self.CharsFileWildcard = CharsFileWildcard
    self.bCreatePrintableOnly = bCreatePrintableOnly
    self.bIncludeASCIIRange = bIncludeASCIIRange
    self.ForegroundColor = ForegroundColor
    self.bEnableDropShadow = bEnableDropShadow
    self.TexturePageWidth = TexturePageWidth
    self.TexturePageMaxHeight = TexturePageMaxHeight
    self.XPadding = XPadding
    self.YPadding = YPadding
    self.ExtendBoxTop = ExtendBoxTop
    self.ExtendBoxBottom = ExtendBoxBottom
    self.ExtendBoxRight = ExtendBoxRight
    self.ExtendBoxLeft = ExtendBoxLeft
    self.bEnableLegacyMode = bEnableLegacyMode
    self.Kerning = Kerning
    self.bUseDistanceFieldAlpha = bUseDistanceFieldAlpha
    self.DistanceFieldScaleFactor = DistanceFieldScaleFactor
    self.DistanceFieldScanRadiusScale = DistanceFieldScanRadiusScale
    return self
end

return FontImportOptionsData
