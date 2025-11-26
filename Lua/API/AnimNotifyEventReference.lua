---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class AnimNotifyEventReference
---Anim Notify Event Reference
---
--- Properties
---
---If set, the Notify has been mirrored.  The mirrored name can be found in MirrorTable->AnimNotifyToMirrorAnimNotifyMap
---@field MirrorTable MirrorDataTable
---@field NotifySource Object
local AnimNotifyEventReference = {}

--- Constructor
---@return AnimNotifyEventReference
---@param MirrorTable MirrorDataTable
---@param NotifySource Object
function AnimNotifyEventReference.new(MirrorTable, NotifySource)
    local self = {}
    self.MirrorTable = MirrorTable
    self.NotifySource = NotifySource
    return self
end

return AnimNotifyEventReference
