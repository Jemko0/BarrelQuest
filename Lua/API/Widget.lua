---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class Widget : Visual
---This is the base class for all wrapped Slate controls that are exposed to UObjects.
---
--- Properties
---The parent slot of the UWidget.  Allows us to easily inline edit the layout controlling this widget.
---@field Slot PanelSlot
---A bindable delegate for bIsEnabled
---@field bIsEnabledDelegate function
---A bindable delegate for ToolTipText
---@field ToolTipTextDelegate function
---Tooltip text to show when the user hovers over the widget with the mouse
---@field ToolTipText string
---Tooltip widget to show when the user hovers over the widget with the mouse
---@field ToolTipWidget Widget
---A bindable delegate for ToolTipWidget
---@field ToolTipWidgetDelegate function
---A bindable delegate for Visibility
---@field VisibilityDelegate function
---The render transform of the widget allows for arbitrary 2D transforms to be applied to the widget.
---@field RenderTransform WidgetTransform
---The render transform pivot controls the location about which transforms are applied.
---This value is a normalized coordinate about which things like rotations will occur.
---@field RenderTransformPivot Vector2D
---Allows you to set a new flow direction
---@field FlowDirectionPreference EFlowDirectionPreference
---Allows controls to be exposed as variables in a blueprint.  Not all controls need to be exposed
---as variables, so this allows only the most useful ones to end up being exposed.
---@field bIsVariable boolean
---Flag if the Widget was created from a blueprint
---@field bCreatedByConstructionScript boolean
---Sets whether this widget can be modified interactively by the user
---@field bIsEnabled boolean
---@field bOverride_Cursor boolean
---Override all of the default accessibility behavior and text for this widget.
---@field bOverrideAccessibleDefaults boolean
---Whether or not children of this widget can appear as distinct accessible widgets.
---@field bCanChildrenBeAccessible boolean
---Whether or not the widget is accessible, and how to describe it. If set to custom, additional customization options will appear.
---@field AccessibleBehavior ESlateAccessibleBehavior
---How to describe this widget when it's being presented through a summary of a parent widget. If set to custom, additional customization options will appear.
---@field AccessibleSummaryBehavior ESlateAccessibleBehavior
---When AccessibleBehavior is set to Custom, this is the text that will be used to describe the widget.
---@field AccessibleText string
---An optional delegate that may be assigned in place of AccessibleText for creating a TAttribute
---@field AccessibleTextDelegate function
---When AccessibleSummaryBehavior is set to Custom, this is the text that will be used to describe the widget.
---@field AccessibleSummaryText string
---An optional delegate that may be assigned in place of AccessibleSummaryText for creating a TAttribute
---@field AccessibleSummaryTextDelegate function
---If true prevents the widget or its child's geometry or layout information from being cached.  If this widget
---changes every frame, but you want it to still be in an invalidation panel you should make it as volatile
---instead of invalidating it every frame, which would prevent the invalidation panel from actually
---ever caching anything.
---@field bIsVolatile boolean
---Stores the design time flag setting if the widget is hidden inside the designer
---@field bHiddenInDesigner boolean
---Stores the design time flag setting if the widget is expanded inside the designer
---@field bExpandedInDesigner boolean
---Stores the design time flag setting if the widget is locked inside the designer
---@field bLockedInDesigner boolean
---The cursor to show when the mouse is over the widget
---@field Cursor integer
---Controls how the clipping behavior of this widget.  Normally content that overflows the
---bounds of the widget continues rendering.  Enabling clipping prevents that overflowing content
---from being seen.
---NOTE: Elements in different clipping spaces can not be batched together, and so there is a
---performance cost to clipping.  Do not enable clipping unless a panel actually needs to prevent
---content from showing up outside its bounds.
---@field Clipping EWidgetClipping
---The visibility of the widget
---@field Visibility ESlateVisibility
---The opacity of the widget
---@field RenderOpacity number
---The navigation object for this widget is optionally created if the user has configured custom
---navigation rules for this widget in the widget designer.  Those rules determine how navigation transitions
---can occur between widgets.
---@field Navigation WidgetNavigation
---Native property bindings.
---@field NativeBindings PropertyBinding[]
local Widget = {}

--- Methods
---Sets the visibility of the widget.
---@param InVisibility ESlateVisibility
---@return nil
function Widget.SetVisibility(InVisibility) end

---Sets the focus to this widget for a specific user (if setting focus for the owning user, prefer SetFocus())
---@param PlayerController PlayerController
---@return nil
function Widget.SetUserFocus(PlayerController) end

---Sets the tooltip text for the widget.
---@return nil
function Widget.SetToolTipText() end

---Sets a custom widget as the tooltip of the widget.
---@param Widget Widget
---@return nil
function Widget.SetToolTip(Widget) end

---Set Render Translation
---@param Translation Vector2D
---@return nil
function Widget.SetRenderTranslation(Translation) end

---Set Render Transform Pivot
---@param Pivot Vector2D
---@return nil
function Widget.SetRenderTransformPivot(Pivot) end

---Set Render Transform Angle
---@param Angle number
---@return nil
function Widget.SetRenderTransformAngle(Angle) end

---Set Render Transform
---@param InTransform WidgetTransform
---@return nil
function Widget.SetRenderTransform(InTransform) end

---Set Render Shear
---@param Shear Vector2D
---@return nil
function Widget.SetRenderShear(Shear) end

---Set Render Scale
---@param Scale Vector2D
---@return nil
function Widget.SetRenderScale(Scale) end

---Sets the visibility of the widget.
---@param InOpacity number
---@return nil
function Widget.SetRenderOpacity(InOpacity) end

---Sets the widget navigation rules for a specific direction. This can only be called on widgets that are in a widget tree. This works only for Explicit Rule.
---@param Direction EUINavigation
---@param InWidget Widget
---@return nil
function Widget.SetNavigationRuleExplicit(Direction, InWidget) end

---Sets the widget navigation rules for a specific direction. This can only be called on widgets that are in a widget tree. This works only for CustomBoundary Rule.
---@param Direction EUINavigation
---@param InCustomDelegate function
---@return nil
function Widget.SetNavigationRuleCustomBoundary(Direction, InCustomDelegate) end

---Sets the widget navigation rules for a specific direction. This can only be called on widgets that are in a widget tree. This works only for Custom Rule.
---@param Direction EUINavigation
---@param InCustomDelegate function
---@return nil
function Widget.SetNavigationRuleCustom(Direction, InCustomDelegate) end

---Sets the widget navigation rules for a specific direction. This can only be called on widgets that are in a widget tree. This works only for non Explicit, non Custom and non CustomBoundary Rules.
---@param Direction EUINavigation
---@param Rule EUINavigationRule
---@return nil
function Widget.SetNavigationRuleBase(Direction, Rule) end

---Set Navigation Rule
---@param Direction EUINavigation
---@param Rule EUINavigationRule
---@param WidgetToFocus string
---@return nil
function Widget.SetNavigationRule(Direction, Rule, WidgetToFocus) end

---Sets the focus to this widget.
---@return nil
function Widget.SetKeyboardFocus() end

---Sets the current enabled status of the widget
---@param bInIsEnabled boolean
---@return nil
function Widget.SetIsEnabled(bInIsEnabled) end

---Sets the focus to this widget for the owning user
---@return nil
function Widget.SetFocus() end

---Sets the cursor to show over the widget.
---@param InCursor integer
---@return nil
function Widget.SetCursor(InCursor) end

---Sets the clipping state of this widget.
---@param InClipping EWidgetClipping
---@return nil
function Widget.SetClipping(InClipping) end

---Sets the widget navigation rules for all directions. This can only be called on widgets that are in a widget tree.
---@param Rule EUINavigationRule
---@param WidgetToFocus string
---@return nil
function Widget.SetAllNavigationRules(Rule, WidgetToFocus) end

---Resets the cursor to use on the widget, removing any customization for it.
---@return nil
function Widget.ResetCursor() end

---Removes the widget from its parent widget.  If this widget was added to the player's screen or the viewport
---it will also be removed from those containers.
---@return nil
function Widget.RemoveFromParent() end

---K2 Remove Field Value Changed Delegate
---@param FieldId FieldNotificationId
---@param Delegate function
---@return nil
function Widget.K2_RemoveFieldValueChangedDelegate(FieldId, Delegate) end

---K2 Broadcast Field Value Changed
---@param FieldId FieldNotificationId
---@return nil
function Widget.K2_BroadcastFieldValueChanged(FieldId) end

---K2 Add Field Value Changed Delegate
---@param FieldId FieldNotificationId
---@param Delegate function
---@return nil
function Widget.K2_AddFieldValueChangedDelegate(FieldId, Delegate) end

---Returns true if the widget is Visible, HitTestInvisible or SelfHitTestInvisible.
---@return boolean
function Widget.IsVisible() end

---Returns true if the widget is Visible, HitTestInvisible or SelfHitTestInvisible and the Render Opacity is greater than 0.
---@return boolean
function Widget.IsRendered() end

---@return boolean
function Widget.IsInViewport() end

---Returns true if the widget is currently being hovered by a pointer device
---@return boolean
function Widget.IsHovered() end

---Invalidates the widget from the view of a layout caching widget that may own this widget.
---will force the owning widget to redraw and cache children on the next paint pass.
---@return nil
function Widget.InvalidateLayoutAndVolatility() end

---Returns true if any descendant widget is focused by a specific user.
---@param PlayerController PlayerController
---@return boolean
function Widget.HasUserFocusedDescendants(PlayerController) end

---Returns true if this widget is focused by a specific user.
---@param PlayerController PlayerController
---@return boolean
function Widget.HasUserFocus(PlayerController) end

---Checks to see if this widget is the current mouse captor
---@param UserIndex integer
---@param PointerIndex integer
---@return boolean
function Widget.HasMouseCaptureByUser(UserIndex, PointerIndex) end

---Checks to see if this widget is the current mouse captor
---@return boolean
function Widget.HasMouseCapture() end

---Checks to see if this widget currently has the keyboard focus
---@return boolean
function Widget.HasKeyboardFocus() end

---Returns true if any descendant widget is focused by any user.
---@return boolean
function Widget.HasFocusedDescendants() end

---Returns true if this widget is focused by any user.
---@return boolean
function Widget.HasAnyUserFocus() end

---Gets the current visibility of the widget.
---@return ESlateVisibility
function Widget.GetVisibility() end

---Get Tick Space Geometry
---@return Geometry
function Widget.GetTickSpaceGeometry() end

---Get Render Transform Angle
---@return number
function Widget.GetRenderTransformAngle() end

---Gets the current visibility of the widget.
---@return number
function Widget.GetRenderOpacity() end

---Gets the parent widget
---@return PanelWidget
function Widget.GetParent() end

---Get Paint Space Geometry
---@return Geometry
function Widget.GetPaintSpaceGeometry() end

---Gets the player controller associated with this UI.
---@return PlayerController
function Widget.GetOwningPlayer() end

---Gets the local player associated with this UI.
---@return LocalPlayer
function Widget.GetOwningLocalPlayer() end

---Gets the current enabled status of the widget
---@return boolean
function Widget.GetIsEnabled() end

---Gets the game instance associated with this UI.
---@return GameInstance
function Widget.GetGameInstance() end

---Gets the widgets desired size.
---NOTE: The underlying Slate widget must exist and be valid, also at least one pre-pass must
---      have occurred before this value will be of any use.
---@return Vector2D
function Widget.GetDesiredSize() end

---Gets the clipping state of this widget.
---@return EWidgetClipping
function Widget.GetClipping() end

---Gets the last geometry used to Tick the widget.  This data may not exist yet if this call happens prior to
---the widget having been ticked/painted, or it may be out of date, or a frame behind.
---We recommend not to use this data unless there's no other way to solve your problem.  Normally in Slate we
---try and handle these issues by making a dependent widget part of the hierarchy, as to avoid frame behind
---or what are referred to as hysteresis problems, both caused by depending on geometry from the previous frame
---being used to advise how to layout a dependent object the current frame.
---@return Geometry
function Widget.GetCachedGeometry() end

---Gets the accessible text from the underlying Slate accessible widget
---accessibility is dsabled or the underlying accessible widget is invalid.
---@return string
function Widget.GetAccessibleText() end

---Gets the accessible summary text from the underlying Slate accessible widget.
---accessibility is dsabled or the underlying accessible widget is invalid.
---@return string
function Widget.GetAccessibleSummaryText() end

---Sets the forced volatility of the widget.
---@param bForce boolean
---@return nil
function Widget.ForceVolatile(bForce) end

---Forces a pre-pass.  A pre-pass caches the desired size of the widget hierarchy owned by this widget.
---One pre-pass already happens for every widget before Tick occurs.  You only need to perform another
---pre-pass if you are adding child widgets this frame and want them to immediately be visible this frame.
---@return nil
function Widget.ForceLayoutPrepass() end

return Widget
