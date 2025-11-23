---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@class ItemSubcontainerCarrierBase_C : Item_C
---Item Subcontainer Carrier Base
---
--- Properties
---@field UberGraphFrame PointerToUberGraphFrame
---@field ExternalSubcontainer ExternalSubcontainer_C
---@field HasExternal boolean
---@field ExternalSubcontainerID string
---@field MaxWeight number
---@field WeightReductionPercent number
---@field ExternalSubcontainerClass Class
local ItemSubcontainerCarrierBase_C = {}

--- Methods
---Actor Get Subcontainer
---@return nil, ExternalSubcontainer_C
function ItemSubcontainerCarrierBase_C.ActorGetSubcontainer() end

---Generate Subcontainer ID
---@return nil, string
function ItemSubcontainerCarrierBase_C.GenerateSubcontainerID() end

---Get Container
---@return nil, ContainerComponentNew_C
function ItemSubcontainerCarrierBase_C.GetContainer() end

return ItemSubcontainerCarrierBase_C
