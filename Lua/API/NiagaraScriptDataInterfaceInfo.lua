---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class NiagaraScriptDataInterfaceInfo
---Niagara Script Data Interface Info
---
--- Properties
---
---@field DataInterface NiagaraDataInterface
---@field Name string
---@field CompileName string
---Index of the user pointer for this data interface.
---@field UserPtrIdx integer
---@field Type NiagaraTypeDefinition
---@field RegisteredParameterMapRead string
---@field RegisteredParameterMapWrite string
---@field SourceEmitterName string
local NiagaraScriptDataInterfaceInfo = {}

--- Constructor
---@return NiagaraScriptDataInterfaceInfo
---@param DataInterface NiagaraDataInterface
---@param Name string
---@param CompileName string
---@param UserPtrIdx integer
---@param Type NiagaraTypeDefinition
---@param RegisteredParameterMapRead string
---@param RegisteredParameterMapWrite string
---@param SourceEmitterName string
function NiagaraScriptDataInterfaceInfo.new(DataInterface, Name, CompileName, UserPtrIdx, Type, RegisteredParameterMapRead, RegisteredParameterMapWrite, SourceEmitterName)
    local self = {}
    self.DataInterface = DataInterface
    self.Name = Name
    self.CompileName = CompileName
    self.UserPtrIdx = UserPtrIdx
    self.Type = Type
    self.RegisteredParameterMapRead = RegisteredParameterMapRead
    self.RegisteredParameterMapWrite = RegisteredParameterMapWrite
    self.SourceEmitterName = SourceEmitterName
    return self
end

return NiagaraScriptDataInterfaceInfo
