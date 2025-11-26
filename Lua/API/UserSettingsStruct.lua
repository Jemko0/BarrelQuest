---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class UserSettingsStruct
---User Settings Struct
---
--- Properties
---@field EffectsQuality_2_52ADE12B4D0BBDE38ADE12A659B2E654 integer
---@field FoliageQuality_4_492BD3E54BDCB10A13F838AC07733FD8 integer
---@field Volume_15_276EE4AF4B7D45D6DDB9538968F6A8EA UserSettingsVolumeStruct
---@field ViewCone_18_74649BE74815277F8D1175A233970A27 UserSettingsViewConeStruct
---@field LogVerbosityLevel_21_17B4DC834C071F4BFC621C81195FC04E integer
local UserSettingsStruct = {}

--- Constructor
---@return UserSettingsStruct
---@param EffectsQuality_2_52ADE12B4D0BBDE38ADE12A659B2E654 integer
---@param FoliageQuality_4_492BD3E54BDCB10A13F838AC07733FD8 integer
---@param Volume_15_276EE4AF4B7D45D6DDB9538968F6A8EA UserSettingsVolumeStruct
---@param ViewCone_18_74649BE74815277F8D1175A233970A27 UserSettingsViewConeStruct
---@param LogVerbosityLevel_21_17B4DC834C071F4BFC621C81195FC04E integer
function UserSettingsStruct.new(EffectsQuality_2_52ADE12B4D0BBDE38ADE12A659B2E654, FoliageQuality_4_492BD3E54BDCB10A13F838AC07733FD8, Volume_15_276EE4AF4B7D45D6DDB9538968F6A8EA, ViewCone_18_74649BE74815277F8D1175A233970A27, LogVerbosityLevel_21_17B4DC834C071F4BFC621C81195FC04E)
    local self = {}
    self.EffectsQuality_2_52ADE12B4D0BBDE38ADE12A659B2E654 = EffectsQuality_2_52ADE12B4D0BBDE38ADE12A659B2E654
    self.FoliageQuality_4_492BD3E54BDCB10A13F838AC07733FD8 = FoliageQuality_4_492BD3E54BDCB10A13F838AC07733FD8
    self.Volume_15_276EE4AF4B7D45D6DDB9538968F6A8EA = Volume_15_276EE4AF4B7D45D6DDB9538968F6A8EA
    self.ViewCone_18_74649BE74815277F8D1175A233970A27 = ViewCone_18_74649BE74815277F8D1175A233970A27
    self.LogVerbosityLevel_21_17B4DC834C071F4BFC621C81195FC04E = LogVerbosityLevel_21_17B4DC834C071F4BFC621C81195FC04E
    return self
end

return UserSettingsStruct
