---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class HealthComponent_C : ActorComponent
---Health Component
---
--- Properties
---@field UberGraphFrame PointerToUberGraphFrame
---@field Health number
---@field MaxHealth number
---@field Defense number
---@field HC_Death function -- Original name: "HC Death"
local HealthComponent_C = {}

--- Methods
---Setup
---@return nil
function HealthComponent_C.Setup() end

---Add Health
---@param amount number
---@return nil, number
function HealthComponent_C.AddHealth(amount) end

---On Any Damage
---@param DamagedActor Actor
---@param Damage number
---@param DamageType DamageType
---@param InstigatedBy Controller
---@param DamageCauser Actor
---@return nil
function HealthComponent_C.OnAnyDamage(DamagedActor, Damage, DamageType, InstigatedBy, DamageCauser) end

return HealthComponent_C
