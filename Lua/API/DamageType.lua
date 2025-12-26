---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class DamageType
---A DamageType is intended to define and describe a particular form of damage and to provide an avenue
---for customizing responses to damage from various sources.
---For example, a game could make a DamageType_Fire set it up to ignite the damaged actor.
---DamageTypes are never instanced and should be treated as immutable data holders with static code
---functionality.  They should never be stateful.
---
--- Properties
---
---True if this damagetype is caused by the world (falling off level, into lava, etc).
---@field bCausedByWorld boolean
---True to scale imparted momentum by the receiving pawn's mass for pawns using character movement
---@field bScaleMomentumByMass boolean
---When applying radial impulses, whether to treat as impulse or velocity change.
---@field bRadialDamageVelChange boolean
---The magnitude of impulse to apply to the Actors damaged by this type.
---@field DamageImpulse number
---How large the impulse should be applied to destructible meshes
---@field DestructibleImpulse number
---How much the damage spreads on a destructible mesh
---@field DestructibleDamageSpreadScale number
---Damage fall-off for radius damage (exponent).  Default 1.0=linear, 2.0=square of distance, etc.
---@field DamageFalloff number
local DamageType = {}

--- Methods
return DamageType
