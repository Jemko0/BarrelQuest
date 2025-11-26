---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class WidgetComponent : MeshComponent
---The widget component provides a surface in the 3D environment on which to render widgets normally rendered to the screen.
---Widgets are first rendered to a render target, then that render target is displayed in the world.
---Material Properties set by this component on whatever material overrides the default.
---SlateUI [Texture]
---BackColor [Vector]
---TintColorAndOpacity [Vector]
---OpacityFromTexture [Scalar]
---
--- Properties
---
---The coordinate space in which to render the widget
---@field Space EWidgetSpace
---How this widget should deal with timing, pausing, etc.
---@field TimingPolicy EWidgetTimingPolicy
---The class of User Widget to create and display an instance of
---@field WidgetClass Class
---The size of the displayed quad.
---@field DrawSize IntPoint
---Should we wait to be told to redraw to actually draw?
---@field bManuallyRedraw boolean
---Has anyone requested we redraw?
---@field bRedrawRequested boolean
---The time in between draws, if 0 - we would redraw every frame.  If 1, we would redraw every second.
---This will work with bManuallyRedraw as well.  So you can say, manually redraw, but only redraw at this
---maximum rate.
---@field RedrawTime number
---The actual draw size, this changes based on DrawSize - or the desired size of the widget if
---bDrawAtDesiredSize is true.
---@field CurrentDrawSize IntPoint
---Use the invalidation system to update this widget.
---Only valid in World space. In Screen space, the widget is updated by the viewport owners.
---@field bUseInvalidationInWorldSpace boolean
---Causes the render target to automatically match the desired size.
---WARNING: If you change this every frame, it will be very expensive. If you need
---   that effect, you should keep the outer widget's sized locked and dynamically
---   scale or resize some inner widget.
---@field bDrawAtDesiredSize boolean
---The Alignment/Pivot point that the widget is placed at relative to the position.
---@field Pivot Vector2D
---Register with the viewport for hardware input from the true mouse and keyboard.  These widgets
---will more or less react like regular 2D widgets in the viewport, e.g. they can and will steal focus
---from the viewport.
---WARNING: If you are making a VR game, definitely do not change this to true.  This option should ONLY be used
---if you're making what would otherwise be a normal menu for a game, just in 3D.  If you also need the game to
---remain responsive and for the player to be able to interact with UI and move around the world (such as a keypad on a door),
---use the WidgetInteractionComponent instead.
---@field bReceiveHardwareInput boolean
---Is the virtual window created to host the widget focusable?
---@field bWindowFocusable boolean
---The visibility of the virtual window created to host the widget
---@field WindowVisibility EWindowVisibility
---Widget components that appear in the world will be gamma corrected by the 3D renderer.
---In some cases, widget components are blitted directly into the backbuffer, in which case gamma correction should be enabled.
---@field bApplyGammaCorrection boolean
---The owner player for a widget component, if this widget is drawn on the screen, this controls
---what player's screen it appears on for split screen, if not set, users player 0.
---@field OwnerPlayer LocalPlayer
---The background color of the component
---@field BackgroundColor LinearColor
---Tint color and opacity for this component
---@field TintColorAndOpacity LinearColor
---Sets the amount of opacity from the widget's UI texture to use when rendering the translucent or masked UI to the viewport (0.0-1.0)
---@field OpacityFromTexture number
---The blend mode for the widget.
---@field BlendMode EWidgetBlendMode
---Is the component visible from behind?
---@field bIsTwoSided boolean
---Should the component tick the widget when it's off screen?
---@field TickWhenOffscreen boolean
---The body setup of the displayed quad
---@field BodySetup BodySetup
---The material instance for translucent widget components
---@field TranslucentMaterial MaterialInterface
---The material instance for translucent, one-sided widget components
---@field TranslucentMaterial_OneSided MaterialInterface
---The material instance for opaque widget components
---@field OpaqueMaterial MaterialInterface
---The material instance for opaque, one-sided widget components
---@field OpaqueMaterial_OneSided MaterialInterface
---The material instance for masked widget components.
---@field MaskedMaterial MaterialInterface
---The material instance for masked, one-sided widget components.
---@field MaskedMaterial_OneSided MaterialInterface
---The target to which the user widget is rendered
---@field RenderTarget TextureRenderTarget2D
---The dynamic instance of the material that the render target is attached to
---@field MaterialInstance MaterialInstanceDynamic
---@field bAddedToScreen boolean
---Allows the widget component to be used at editor time.  For use in the VR-Editor.
---@field bEditTimeUsable boolean
---Layer Name the widget will live on
---@field SharedLayerName string
---ZOrder the layer will be created on, note this only matters on the first time a new layer is created, subsequent additions to the same layer will use the initially defined ZOrder
---@field LayerZOrder integer
---Controls the geometry of the widget component. See EWidgetGeometryMode.
---@field GeometryMode EWidgetGeometryMode
---Curvature of a cylindrical widget in degrees.
---@field CylinderArcAngle number
---@field TickMode ETickMode
local WidgetComponent = {}

--- Methods
---Sets the visibility of the virtual window created to host the widget focusable.
---@param InVisibility EWindowVisibility
---@return nil
function WidgetComponent.SetWindowVisibility(InVisibility) end

---\@see bWindowFocusable
---@param bInWindowFocusable boolean
---@return nil
function WidgetComponent.SetWindowFocusable(bInWindowFocusable) end

---Set Widget Space
---@param NewSpace EWidgetSpace
---@return nil
function WidgetComponent.SetWidgetSpace(NewSpace) end

---Sets the widget to use directly. This function will keep track of the widget till the next time it's called
---    with either a newer widget or a nullptr
---@param Widget UserWidget
---@return nil
function WidgetComponent.SetWidget(Widget) end

---Sets whether the widget is two-sided or not
---@param bWantTwoSided boolean
---@return nil
function WidgetComponent.SetTwoSided(bWantTwoSided) end

---Sets the tint color and opacity scale for this widget
---@param NewTintColorAndOpacity LinearColor
---@return nil
function WidgetComponent.SetTintColorAndOpacity(NewTintColorAndOpacity) end

---Sets whether the widget ticks when offscreen or not
---@param bWantTickWhenOffscreen boolean
---@return nil
function WidgetComponent.SetTickWhenOffscreen(bWantTickWhenOffscreen) end

---Sets the Tick mode of the Widget Component.
---@param InTickMode ETickMode
---@return nil
function WidgetComponent.SetTickMode(InTickMode) end

---Set Redraw Time
---@param InRedrawTime number
---@return nil
function WidgetComponent.SetRedrawTime(InRedrawTime) end

---Set Pivot
---@return nil
function WidgetComponent.SetPivot() end

---Sets the local player that owns this widget component.  Setting the owning player controls
---which player's viewport the widget appears on in a split screen scenario.  Additionally it
---forwards the owning player to the actual UserWidget that is spawned.
---@param LocalPlayer LocalPlayer
---@return nil
function WidgetComponent.SetOwnerPlayer(LocalPlayer) end

---\@see bManuallyRedraw
---@param bUseManualRedraw boolean
---@return nil
function WidgetComponent.SetManuallyRedraw(bUseManualRedraw) end

---Set Geometry Mode
---@param InGeometryMode EWidgetGeometryMode
---@return nil
function WidgetComponent.SetGeometryMode(InGeometryMode) end

---Sets the draw size of the quad in the world
---@param Size Vector2D
---@return nil
function WidgetComponent.SetDrawSize(Size) end

---Set Draw at Desired Size
---@param bInDrawAtDesiredSize boolean
---@return nil
function WidgetComponent.SetDrawAtDesiredSize(bInDrawAtDesiredSize) end

---Defines the curvature of the widget component when using EWidgetGeometryMode::Cylinder; ignored otherwise.
---@param InCylinderArcAngle number
---@return nil
function WidgetComponent.SetCylinderArcAngle(InCylinderArcAngle) end

---Sets the background color and opacityscale for this widget
---@param NewBackgroundColor LinearColor
---@return nil
function WidgetComponent.SetBackgroundColor(NewBackgroundColor) end

---Requests that the widget have it's render target updated, if TickMode is disabled, this will force a tick to happen to update the render target.
---@return nil
function WidgetComponent.RequestRenderUpdate() end

---Requests that the widget be redrawn.
---@return nil
function WidgetComponent.RequestRedraw() end

---Returns true if the the Slate window is visible and that the widget is also visible, false otherwise.
---@return boolean
function WidgetComponent.IsWidgetVisible() end

---Gets the visibility of the virtual window created to host the widget focusable.
---@return EWindowVisibility
function WidgetComponent.GetWindowVisiblility() end

---\@see bWindowFocusable
---@return boolean
function WidgetComponent.GetWindowFocusable() end

---Get Widget Space
---@return EWidgetSpace
function WidgetComponent.GetWidgetSpace() end

---Gets the widget that is used by this Widget Component. It will be null if a Slate Widget was set using SetSlateWidget function.
---@return UserWidget
function WidgetComponent.GetWidget() end

---Returns the user widget object displayed by this component
---@return UserWidget
function WidgetComponent.GetUserWidgetObject() end

---Gets whether the widget is two-sided or not
---@return boolean
function WidgetComponent.GetTwoSided() end

---Gets whether the widget ticks when offscreen or not
---@return boolean
function WidgetComponent.GetTickWhenOffscreen() end

---Returns the render target to which the user widget is rendered
---@return TextureRenderTarget2D
function WidgetComponent.GetRenderTarget() end

---Get Redraw Time
---@return number
function WidgetComponent.GetRedrawTime() end

---Returns the pivot point where the UI is rendered about the origin.
---@return Vector2D
function WidgetComponent.GetPivot() end

---Gets the local player that owns this widget component.
---@return LocalPlayer
function WidgetComponent.GetOwnerPlayer() end

---Returns the dynamic material instance used to render the user widget
---@return MaterialInstanceDynamic
function WidgetComponent.GetMaterialInstance() end

---\@see bManuallyRedraw
---@return boolean
function WidgetComponent.GetManuallyRedraw() end

---\@see EWidgetGeometryMode, \@see GetCylinderArcAngle()
---@return EWidgetGeometryMode
function WidgetComponent.GetGeometryMode() end

---Returns the "specified" draw size of the quad in the world
---@return Vector2D
function WidgetComponent.GetDrawSize() end

---Get Draw at Desired Size
---@return boolean
function WidgetComponent.GetDrawAtDesiredSize() end

---Defines the curvature of the widget component when using EWidgetGeometryMode::Cylinder; ignored otherwise.
---@return number
function WidgetComponent.GetCylinderArcAngle() end

---Returns the "actual" draw size of the quad in the world
---@return Vector2D
function WidgetComponent.GetCurrentDrawSize() end

return WidgetComponent
