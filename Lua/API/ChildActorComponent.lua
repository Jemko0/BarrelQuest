---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class ChildActorComponent : SceneComponent
---A component that spawns an Actor when registered, and destroys it when unregistered.
---
--- Properties
local ChildActorComponent = {}

--- Methods
---Sets the class to use for the child actor.
---If called on a template component (owned by a CDO), the properties of any existing child actor template will be copied as best possible to the template.
---If called on a component instance in a world (and the class is changing), the created ChildActor will use the class defaults as template.
---@param InClass Class
---@return nil
function ChildActorComponent.SetChildActorClass(InClass) end

return ChildActorComponent
