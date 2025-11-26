---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class WidgetAnimation : MovieSceneSequence
---Widget Animation
---
--- Properties
---
---Pointer to the movie scene that controls this animation.
---@field MovieScene MovieScene
---@field AnimationBindings WidgetAnimationBinding[]
local WidgetAnimation = {}

--- Methods
---Unbind from Animation Started
---@param Widget UserWidget
---@param Delegate function
---@return nil
function WidgetAnimation.UnbindFromAnimationStarted(Widget, Delegate) end

---Unbind from Animation Finished
---@param Widget UserWidget
---@param Delegate function
---@return nil
function WidgetAnimation.UnbindFromAnimationFinished(Widget, Delegate) end

---Unbind All from Animation Started
---@param Widget UserWidget
---@return nil
function WidgetAnimation.UnbindAllFromAnimationStarted(Widget) end

---Unbind All from Animation Finished
---@param Widget UserWidget
---@return nil
function WidgetAnimation.UnbindAllFromAnimationFinished(Widget) end

---Get the start time of this animation.
---\@see GetEndTime
---@return number
function WidgetAnimation.GetStartTime() end

---Get the end time of this animation.
---\@see GetStartTime
---@return number
function WidgetAnimation.GetEndTime() end

---These animation binding functions were added so that we could cleanly upgrade assets
---from before animation sharing, they don't actually modify the animation, they just pipe
---through to the UUserWidget.  If we didn't put the functions here, it would be much more
---difficult to upgrade users who were taking advantage of the Many-To-1, blueprint having
---many animations binding to the same delegate.
---@param Widget UserWidget
---@param Delegate function
---@return nil
function WidgetAnimation.BindToAnimationStarted(Widget, Delegate) end

---Bind to Animation Finished
---@param Widget UserWidget
---@param Delegate function
---@return nil
function WidgetAnimation.BindToAnimationFinished(Widget, Delegate) end

return WidgetAnimation
