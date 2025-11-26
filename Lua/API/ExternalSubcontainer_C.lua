---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class ExternalSubcontainer_C : Actor
---External Subcontainer
---
--- Properties
---
---@field UberGraphFrame PointerToUberGraphFrame
---@field Subcontainer ContainerComponentNew_C
---@field DefaultSceneRoot SceneComponent
---@field SubContainerID string
local ExternalSubcontainer_C = {}

--- Methods
---Get Container
---@return nil, ContainerComponentNew_C
function ExternalSubcontainer_C.GetContainer() end

---Get Item Data
---@return nil, boolean, ItemDataStruct
function ExternalSubcontainer_C.GetItemData() end

---Mark Slot Dirty
---@return nil
function ExternalSubcontainer_C.MarkSlotDirty() end

---Pick Up
---@param Source ContainerComponentNew_C
---@return nil
function ExternalSubcontainer_C.PickUp(Source) end

---SV Init From Params
---Original name: "SV Init from Params"
---@param MaxWeight number
---@param WeightReductionPercent number
---@return nil
function ExternalSubcontainer_C.SV_Init_from_Params(MaxWeight, WeightReductionPercent) end

return ExternalSubcontainer_C
