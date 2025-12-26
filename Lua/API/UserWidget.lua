---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class UserWidget : Widget
---A widget that enables UI extensibility through WidgetBlueprint.
---
--- Properties
---
---The color and opacity of this widget.  Tints all child widgets.
---@field ColorAndOpacity LinearColor
---@field ColorAndOpacityDelegate any
---The foreground color of the widget, this is inherited by sub widgets.  Any color property
---that is marked as inherit will use this color.
---@field ForegroundColor SlateColor
---@field ForegroundColorDelegate any
---Called when the visibility has changed
---@field OnVisibilityChanged OnVisibilityChangedDelegate
---The padding area around the content.
---@field Padding Margin
---@field Priority integer
---Setting this flag to true, allows this widget to accept focus when clicked, or when navigated to.
---@field bIsFocusable boolean
---@field bStopAction boolean
---If true, this widget will automatically register its own input component upon construction.
---This will allow the use of binding input delegates in the event graph.
---This is set during the compilation of the widget blueprint.
---@field bAutomaticallyRegisterInputOnConstruction boolean
---Animation transitions to trigger on next tick
---@field QueuedWidgetAnimationTransitions QueuedWidgetAnimationTransition[]
---@field ActiveSequencePlayers UMGSequencePlayer[]
---Global tick manager for running widget animations
---@field AnimationTickManager UMGSequenceTickManager
---@field StoppedSequencePlayers UMGSequencePlayer[]
---The widget tree contained inside this user widget initialized by the blueprint
---@field WidgetTree WidgetTree
---Stores the design time desired size of the user widget
---@field DesignTimeSize Vector2D
---@field DesignSizeMode EDesignPreviewSizeMode
---The category this widget appears in the palette.
---@field PaletteCategory string
---A preview background that you can use when designing the UI to get a sense of scale on the screen.  Use
---a texture with a screenshot of your game in it, for example if you were designing a HUD.
---@field PreviewBackground Texture2D
---If a widget has an implemented tick blueprint function
---@field bHasScriptImplementedTick boolean
---If a widget has an implemented paint blueprint function
---@field bHasScriptImplementedPaint boolean
---@field InputComponent InputComponent
---@field AnimationCallbacks AnimationEventBinding[]
local UserWidget = {}

--- Methods
---StopListeningForAllInputActions will automatically Register an Input Component with the player input system.
---If you however, want to Pause and Resume, listening for a set of actions, the best way is to use
---UnregisterInputComponent to pause, and RegisterInputComponent to resume listening.
---@return nil
function UserWidget.UnregisterInputComponent() end

---Unbind an animation started delegate.
---@param Animation WidgetAnimation
---@param Delegate any
---@return nil
function UserWidget.UnbindFromAnimationStarted(Animation, Delegate) end

---Unbind an animation finished delegate.
---@param Animation WidgetAnimation
---@param Delegate any
---@return nil
function UserWidget.UnbindFromAnimationFinished(Animation, Delegate) end

---Unbind All from Animation Started
---@param Animation WidgetAnimation
---@return nil
function UserWidget.UnbindAllFromAnimationStarted(Animation) end

---Unbind All from Animation Finished
---@param Animation WidgetAnimation
---@return nil
function UserWidget.UnbindAllFromAnimationFinished(Animation) end

---Removes the binding for a particular action's callback.
---@param ActionName string
---@param EventType integer
---@return nil
function UserWidget.StopListeningForInputAction(ActionName, EventType) end

---Stops listening to all input actions, and unregisters the input component with the player controller.
---@return nil
function UserWidget.StopListeningForAllInputActions() end

---Cancels any pending Delays or timer callbacks for this widget, and stops all active animations on the widget.
---@return nil
function UserWidget.StopAnimationsAndLatentActions() end

---Stops an already running animation in this widget
---@param InAnimation WidgetAnimation
---@return nil
function UserWidget.StopAnimation(InAnimation) end

---Stop All actively running animations.
---@return nil
function UserWidget.StopAllAnimations() end

---Sets the widgets position in the viewport.
---Otherwise inverse DPI is applied to the position so that when the location is scaled
---by DPI, it ends up in the expected position.
---@param Position Vector2D
---@param bRemoveDPIScale boolean
---@return nil
function UserWidget.SetPositionInViewport(Position, bRemoveDPIScale) end

---Changes the playback rate of a playing animation
---@param InAnimation WidgetAnimation
---@param PlaybackSpeed number
---@return nil
function UserWidget.SetPlaybackSpeed(InAnimation, PlaybackSpeed) end

---Sets the padding for the user widget, putting a larger gap between the widget border and it's root widget.
---@param InPadding Margin
---@return nil
function UserWidget.SetPadding(InPadding) end

---Sets the local player associated with this UI via PlayerController reference.
---@param LocalPlayerController PlayerController
---@return nil
function UserWidget.SetOwningPlayer(LocalPlayerController) end

---Changes the number of loops to play given a playing animation
---@param InAnimation WidgetAnimation
---@param NumLoopsToPlay integer
---@return nil
function UserWidget.SetNumLoopsToPlay(InAnimation, NumLoopsToPlay) end

---Set Input Action Priority
---@param NewPriority integer
---@return nil
function UserWidget.SetInputActionPriority(NewPriority) end

---Set Input Action Blocking
---@param bShouldBlock boolean
---@return nil
function UserWidget.SetInputActionBlocking(bShouldBlock) end

---Sets the foreground color of the widget, this is inherited by sub widgets.  Any color property
---that is marked as inherit will use this color.
---@param InForegroundColor SlateColor
---@return nil
function UserWidget.SetForegroundColor(InForegroundColor) end

---Set Desired Size in Viewport
---@param Size Vector2D
---@return nil
function UserWidget.SetDesiredSizeInViewport(Size) end

---Sets the child Widget that should receive focus when this UserWidget gets focus.
---@param Widget Widget
---@return boolean
function UserWidget.SetDesiredFocusWidget(Widget) end

---Sets the tint of the widget, this affects all child widgets.
---@param InColorAndOpacity LinearColor
---@return nil
function UserWidget.SetColorAndOpacity(InColorAndOpacity) end

---Sets the current time of the animation in this widget. Does not change state.
---@param InAnimation WidgetAnimation
---@param InTime number
---@return nil
function UserWidget.SetAnimationCurrentTime(InAnimation, InTime) end

---Set Anchors in Viewport
---@param Anchors Anchors
---@return nil
function UserWidget.SetAnchorsInViewport(Anchors) end

---Set Alignment in Viewport
---@param Alignment Vector2D
---@return nil
function UserWidget.SetAlignmentInViewport(Alignment) end

---If an animation is playing, this function will reverse the playback.
---@param InAnimation WidgetAnimation
---@return nil
function UserWidget.ReverseAnimation(InAnimation) end

---Remove from Viewport
---@return nil
function UserWidget.RemoveFromViewport() end

---Remove all extensions of the requested type.
---@param InExtensionType Class
---@return nil
function UserWidget.RemoveExtensions(InExtensionType) end

---Remove the extension.
---@param InExtension UserWidgetExtension
---@return nil
function UserWidget.RemoveExtension(InExtension) end

---ListenForInputAction will automatically Register an Input Component with the player input system.
---If you however, want to Pause and Resume, listening for a set of actions, the best way is to use
---UnregisterInputComponent to pause, and RegisterInputComponent to resume listening.
---@return nil
function UserWidget.RegisterInputComponent() end

---Stops an already running animation in this widget
---@param InAnimation WidgetAnimation
---@return nil
function UserWidget.QueueStopAnimation(InAnimation) end

---Stop All actively running animations.
---@return nil
function UserWidget.QueueStopAllAnimations() end

---Plays an animation in this widget a specified number of times stopping at a specified time
---@param InAnimation WidgetAnimation
---@param StartAtTime number
---@param EndAtTime number
---@param NumLoopsToPlay integer
---@param PlayMode integer
---@param PlaybackSpeed number
---@param bRestoreState boolean
---@return nil
function UserWidget.QueuePlayAnimationTimeRange(InAnimation, StartAtTime, EndAtTime, NumLoopsToPlay, PlayMode, PlaybackSpeed, bRestoreState) end

---Plays an animation on this widget relative to it's current state in reverse.  You should use this version in situations where
---say a user can click a button and that causes a panel to slide out, and you want to reverse that same animation to begin sliding
---in the opposite direction.
---@param InAnimation WidgetAnimation
---@param PlaybackSpeed number
---@param bRestoreState boolean
---@return nil
function UserWidget.QueuePlayAnimationReverse(InAnimation, PlaybackSpeed, bRestoreState) end

---Plays an animation on this widget relative to it's current state forward.  You should use this version in situations where
---say a user can click a button and that causes a panel to slide out, and you want to reverse that same animation to begin sliding
---in the opposite direction.
---@param InAnimation WidgetAnimation
---@param PlaybackSpeed number
---@param bRestoreState boolean
---@return nil
function UserWidget.QueuePlayAnimationForward(InAnimation, PlaybackSpeed, bRestoreState) end

---Plays an animation in this widget a specified number of times
---@param InAnimation WidgetAnimation
---@param StartAtTime number
---@param NumLoopsToPlay integer
---@param PlayMode integer
---@param PlaybackSpeed number
---@param bRestoreState boolean
---@return nil
function UserWidget.QueuePlayAnimation(InAnimation, StartAtTime, NumLoopsToPlay, PlayMode, PlaybackSpeed, bRestoreState) end

---Pauses an already running animation in this widget
---@param InAnimation WidgetAnimation
---@return number
function UserWidget.QueuePauseAnimation(InAnimation) end

---Plays a sound through the UI
---@param SoundToPlay SoundBase
---@return nil
function UserWidget.PlaySound(SoundToPlay) end

---Plays an animation in this widget a specified number of times stopping at a specified time
---@param InAnimation WidgetAnimation
---@param StartAtTime number
---@param EndAtTime number
---@param NumLoopsToPlay integer
---@param PlayMode integer
---@param PlaybackSpeed number
---@param bRestoreState boolean
---@return WidgetAnimationHandle
function UserWidget.PlayAnimationTimeRange(InAnimation, StartAtTime, EndAtTime, NumLoopsToPlay, PlayMode, PlaybackSpeed, bRestoreState) end

---Plays an animation on this widget relative to it's current state in reverse.  You should use this version in situations where
---say a user can click a button and that causes a panel to slide out, and you want to reverse that same animation to begin sliding
---in the opposite direction.
---@param InAnimation WidgetAnimation
---@param PlaybackSpeed number
---@param bRestoreState boolean
---@return WidgetAnimationHandle
function UserWidget.PlayAnimationReverse(InAnimation, PlaybackSpeed, bRestoreState) end

---Plays an animation on this widget relative to it's current state forward.  You should use this version in situations where
---say a user can click a button and that causes a panel to slide out, and you want to reverse that same animation to begin sliding
---in the opposite direction.
---@param InAnimation WidgetAnimation
---@param PlaybackSpeed number
---@param bRestoreState boolean
---@return WidgetAnimationHandle
function UserWidget.PlayAnimationForward(InAnimation, PlaybackSpeed, bRestoreState) end

---Plays an animation in this widget a specified number of times
---@param InAnimation WidgetAnimation
---@param StartAtTime number
---@param NumLoopsToPlay integer
---@param PlayMode integer
---@param PlaybackSpeed number
---@param bRestoreState boolean
---@return WidgetAnimationHandle
function UserWidget.PlayAnimation(InAnimation, StartAtTime, NumLoopsToPlay, PlayMode, PlaybackSpeed, bRestoreState) end

---Pauses an already running animation in this widget
---@param InAnimation WidgetAnimation
---@return number
function UserWidget.PauseAnimation(InAnimation) end

---Listens for a particular Player Input Action by name.  This requires that those actions are being executed, and
---that we're not currently in UI-Only Input Mode.
---@param ActionName string
---@param EventType integer
---@param bConsume boolean
---@param Callback any
---@return nil
function UserWidget.ListenForInputAction(ActionName, EventType, bConsume, Callback) end

---Are we currently playing any animations?
---@return boolean
function UserWidget.IsPlayingAnimation() end

---Checks if the action has a registered callback with the input component.
---@param ActionName string
---@return boolean
function UserWidget.IsListeningForInputAction(ActionName) end

---@return boolean
function UserWidget.IsAnyAnimationPlaying() end

---returns true if the animation is currently playing forward, false otherwise.
---@param InAnimation WidgetAnimation
---@return boolean
function UserWidget.IsAnimationPlayingForward(InAnimation) end

---Gets whether an animation is currently playing on this widget.
---@param InAnimation WidgetAnimation
---@return boolean
function UserWidget.IsAnimationPlaying(InAnimation) end

---Gets the player pawn associated with this UI.
---@return Pawn
function UserWidget.GetOwningPlayerPawn() end

---Gets the player camera manager associated with this UI.
---@return PlayerCameraManager
function UserWidget.GetOwningPlayerCameraManager() end

---Get Is Visible
---@return boolean
function UserWidget.GetIsVisible() end

---Find the extensions of the requested type.
---@param ExtensionType Class
---@return UserWidgetExtension[]
function UserWidget.GetExtensions(ExtensionType) end

---Find the first extension of the requested type.
---@param ExtensionType Class
---@return UserWidgetExtension
function UserWidget.GetExtension(ExtensionType) end

---Gets the current time of the animation in this widget
---@param InAnimation WidgetAnimation
---@return number
function UserWidget.GetAnimationCurrentTime(InAnimation) end

---Get Anchors in Viewport
---@return Anchors
function UserWidget.GetAnchorsInViewport() end

---Get Alignment in Viewport
---@return Vector2D
function UserWidget.GetAlignmentInViewport() end

---Flushes all animations on all widgets to guarantee that any queued updates are processed before this call returns
---@return nil
function UserWidget.FlushAnimations() end

---Cancels any pending Delays or timer callbacks for this widget.
---@return nil
function UserWidget.CancelLatentActions() end

---Bind an animation started delegate.
---@param Animation WidgetAnimation
---@param Delegate any
---@return nil
function UserWidget.BindToAnimationStarted(Animation, Delegate) end

---Bind an animation finished delegate.
---@param Animation WidgetAnimation
---@param Delegate any
---@return nil
function UserWidget.BindToAnimationFinished(Animation, Delegate) end

---Allows binding to a specific animation's event.
---@param Animation WidgetAnimation
---@param Delegate any
---@param AnimationEvent EWidgetAnimationEvent
---@param UserTag string
---@return nil
function UserWidget.BindToAnimationEvent(Animation, Delegate, AnimationEvent, UserTag) end

---Adds it to the game's viewport and fills the entire screen, unless SetDesiredSizeInViewport is called
---to explicitly set the size.
---@param ZOrder integer
---@return nil
function UserWidget.AddToViewport(ZOrder) end

---Adds the widget to the game's viewport in a section dedicated to the player.  This is valuable in a split screen
---game where you need to only show a widget over a player's portion of the viewport.
---@param ZOrder integer
---@return boolean
function UserWidget.AddToPlayerScreen(ZOrder) end

---Add the extension of the requested type.
---@param InExtensionType Class
---@return UserWidgetExtension
function UserWidget.AddExtension(InExtensionType) end

return UserWidget
