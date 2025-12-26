---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class AIPerceptionStimuliSourceComponent : ActorComponent
---Gives owning actor a way to auto-register as perception system's sense stimuli source
---
--- Properties
---
---@field bAutoRegisterAsSource boolean
---@field RegisterAsSourceForSenses Class[]
local AIPerceptionStimuliSourceComponent = {}

--- Methods
---Unregisters owning actor from sources list of a specified sense class
---@param SenseClass Class
---@return nil
function AIPerceptionStimuliSourceComponent.UnregisterFromSense(SenseClass) end

---Unregister owning actor from being a source of sense stimuli
---@return nil
function AIPerceptionStimuliSourceComponent.UnregisterFromPerceptionSystem() end

---Registers owning actor as source of stimuli for senses specified in RegisterAsSourceForSenses.
---    Note that you don't have to do it if bAutoRegisterAsSource == true
---@return nil
function AIPerceptionStimuliSourceComponent.RegisterWithPerceptionSystem() end

---Registers owning actor as source for specified sense class
---@param SenseClass Class
---@return nil
function AIPerceptionStimuliSourceComponent.RegisterForSense(SenseClass) end

return AIPerceptionStimuliSourceComponent
