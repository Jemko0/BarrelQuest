---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class EdGraphPinType
---Struct used to define the type of information carried on this pin
---
--- Properties
---Category of pin type
---@field PinCategory string
---Sub-category of pin type
---@field PinSubCategory string
---Sub-category object
---@field PinSubCategoryObject any
---Sub-category member reference
---@field PinSubCategoryMemberReference SimpleMemberReference
---Data used to determine value types when bIsMap is true
---@field PinValueType EdGraphTerminalType
---@field ContainerType EPinContainerType
---UE_DEPRECATED(4.17) Whether or not this pin represents an array of values
---@field bIsArray boolean
---Whether or not this pin is a value passed by reference or not
---@field bIsReference boolean
---Whether or not this pin is a immutable const value
---@field bIsConst boolean
---Whether or not this is a weak reference
---@field bIsWeakPointer boolean
---Whether or not this is a "wrapped" Unreal object ptr type (e.g. TSubclassOf<T> instead of UClass*)
---@field bIsUObjectWrapper boolean
---Set to true if the type was serialized prior to BlueprintPinsUseRealNumbers
---@field bSerializeAsSinglePrecisionFloat boolean
local EdGraphPinType = {}
return EdGraphPinType
