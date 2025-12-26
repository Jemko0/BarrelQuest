---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class InputComponent : ActorComponent
---Implement an Actor component for input bindings.
---An Input Component is a transient component that enables an Actor to bind various forms of input events to delegate functions.
---Input components are processed from a stack managed by the PlayerController and processed by the PlayerInput.
---Each binding can consume the input event preventing other components on the input stack from processing the input.
---@see https://docs.unrealengine.com/latest/INT/Gameplay/Input/index.html
---
--- Properties
---
local InputComponent = {}

--- Methods
---Returns true if the given key/button was down last frame and up this frame.
---@param Key Key
---@return boolean
function InputComponent.WasControllerKeyJustReleased(Key) end

---Returns true if the given key/button was up last frame and down this frame.
---@param Key Key
---@return boolean
function InputComponent.WasControllerKeyJustPressed(Key) end

---Returns true if the given key/button is pressed on the input of the controller (if present)
---@param Key Key
---@return boolean
function InputComponent.IsControllerKeyDown(Key) end

---Returns the location of a touch, and if it's held down
---@param FingerIndex integer
---@return nil, number, number, boolean
function InputComponent.GetTouchState(FingerIndex) end

---Returns the vector value for the given key/button.
---@param Key Key
---@return Vector
function InputComponent.GetControllerVectorKeyState(Key) end

---Retrieves how far the mouse moved this frame.
---@return nil, number, number
function InputComponent.GetControllerMouseDelta() end

---Returns how long the given key/button has been down.  Returns 0 if it's up or it just went down this frame.
---@param Key Key
---@return number
function InputComponent.GetControllerKeyTimeDown(Key) end

---Retrieves the X and Y displacement of the given analog stick.  For WhickStick, 0 = left, 1 = right.
---@param WhichStick integer
---@return nil, number, number
function InputComponent.GetControllerAnalogStickState(WhichStick) end

---Returns the analog value for the given key/button.  If analog isn't supported, returns 1 for down and 0 for up.
---@param Key Key
---@return number
function InputComponent.GetControllerAnalogKeyState(Key) end

return InputComponent
