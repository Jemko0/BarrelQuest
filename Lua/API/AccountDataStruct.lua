---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class AccountDataStruct
---Account Data Struct
---
--- Properties
---
---@field protected UserID_4_079911A24350B57A09D22D82C6A42864 string
---@field protected PrivateToken_5_BBAFEE57429DE32127D2D9AB77369DE5 string
local AccountDataStruct = {}

--- Constructor
---@return AccountDataStruct
---@param UserID_4_079911A24350B57A09D22D82C6A42864 string
---@param PrivateToken_5_BBAFEE57429DE32127D2D9AB77369DE5 string
function AccountDataStruct.new(UserID_4_079911A24350B57A09D22D82C6A42864, PrivateToken_5_BBAFEE57429DE32127D2D9AB77369DE5)
    local self = {}
    self.UserID_4_079911A24350B57A09D22D82C6A42864 = UserID_4_079911A24350B57A09D22D82C6A42864
    self.PrivateToken_5_BBAFEE57429DE32127D2D9AB77369DE5 = PrivateToken_5_BBAFEE57429DE32127D2D9AB77369DE5
    return self
end

return AccountDataStruct
