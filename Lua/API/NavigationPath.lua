---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class NavigationPath
---UObject wrapper for FNavigationPath
---
--- Properties
---
---@field PathUpdatedNotifier function
---@field PathPoints Vector[]
---@field RecalculateOnInvalidation ENavigationOptionFlag
local NavigationPath = {}

--- Methods
---Is Valid
---@return boolean
function NavigationPath.IsValid() end

---Is String Pulled
---@return boolean
function NavigationPath.IsStringPulled() end

---Is Partial
---@return boolean
function NavigationPath.IsPartial() end

---Get Path Length
---@return number
function NavigationPath.GetPathLength() end

---Get Path Cost
---@return number
function NavigationPath.GetPathCost() end

---UObject end
---@return string
function NavigationPath.GetDebugString() end

---if enabled path will request recalculation if it gets invalidated due to a change to underlying navigation
---@param DoRecalculation ENavigationOptionFlag
---@return nil
function NavigationPath.EnableRecalculationOnInvalidation(DoRecalculation) end

---Enable Debug Drawing
---@param bShouldDrawDebugData boolean
---@param PathColor LinearColor
---@return nil
function NavigationPath.EnableDebugDrawing(bShouldDrawDebugData, PathColor) end

return NavigationPath
