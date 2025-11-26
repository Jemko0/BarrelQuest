---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class PanelWidget : Widget
---The base class for all UMG panel widgets.  Panel widgets layout a collection of child widgets.
---
--- Properties
---The slots in the widget holding the child widgets of this panel.
---@field Slots PanelSlot[]
local PanelWidget = {}

--- Methods
---Removes a child by it's index.
---@param Index integer
---@return boolean
function PanelWidget.RemoveChildAt(Index) end

---Removes a specific widget from the container.
---@param Content Widget
---@return boolean
function PanelWidget.RemoveChild(Content) end

---Returns true if panel contains this widget
---@param Content Widget
---@return boolean
function PanelWidget.HasChild(Content) end

---Returns true if there are any child widgets in the panel
---@return boolean
function PanelWidget.HasAnyChildren() end

---Gets number of child widgets in the container.
---@return integer
function PanelWidget.GetChildrenCount() end

---Gets the index of a specific child widget
---@param Content Widget
---@return integer
function PanelWidget.GetChildIndex(Content) end

---Gets the widget at an index.
---@param Index integer
---@return Widget
function PanelWidget.GetChildAt(Index) end

---Gets all widgets in the container
---@return Widget[]
function PanelWidget.GetAllChildren() end

---Remove all child widgets from the panel widget.
---@return nil
function PanelWidget.ClearChildren() end

---Adds a new child widget to the container.  Returns the base slot type,
---requires casting to turn it into the type specific to the container.
---@param Content Widget
---@return PanelSlot
function PanelWidget.AddChild(Content) end

return PanelWidget
