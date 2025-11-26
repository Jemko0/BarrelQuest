---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@class BarrelGameInstance_C : GameInstance
---Barrel Game Instance
---
--- Properties
---
---@field UberGraphFrame PointerToUberGraphFrame
---@field TitleSong AudioComponent
---@field AccountData AccountDataStruct
---@field DebugVars DebugVariablesStruct
---@field UserSettings UserSettingsStruct
---@field ThumbnailPaths table<string, string>
---@field OnSettingsUpdated function
---@field OnSettingsApplied function
---@field OnUpdateDebugVar function
---@field ThumbnailsLoaded boolean
---@field LogTimestamp string
local BarrelGameInstance_C = {}

--- Methods
---Get Barrel Game Instance
---@return nil, BarrelGameInstance_C
function BarrelGameInstance_C.GetBarrelGameInstance() end

---Barrel Char Fallover
---@return nil
function BarrelGameInstance_C.barrel_char_fallover() end

---Set Log Timestamp
---@return nil
function BarrelGameInstance_C.SetLogTimestamp() end

---Barrel Dbg Hideplayer
---@param bNewHidden boolean
---@return nil
function BarrelGameInstance_C.barrel_dbg_hideplayer(bNewHidden) end

---Barrel Daymanager Set Timeaccel
---@param TimeAccel number
---@return nil
function BarrelGameInstance_C.barrel_daymanager_set_timeaccel(TimeAccel) end

---Barrel Dbg Viewcone
---@param NewParam boolean
---@return nil
function BarrelGameInstance_C.barrel_dbg_viewcone(NewParam) end

---Barrel Dbg Room
---@param NewParam boolean
---@return nil
function BarrelGameInstance_C.barrel_dbg_room(NewParam) end

---Barrel Dbg Temperature
---@param NewParam boolean
---@return nil
function BarrelGameInstance_C.barrel_dbg_temperature(NewParam) end

---View Cone Quality Setting to Pixels
---@param Option integer
---@return nil, integer
function BarrelGameInstance_C.ViewConeQualitySettingToPixels(Option) end

---Barrel Ui Create Menu Anchor RCM
---@return nil
function BarrelGameInstance_C.barrel_ui_createMenuAnchorRCM() end

---Barrel Char Damage Self
---@param BaseDamage number
---@return nil
function BarrelGameInstance_C.barrel_char_damageSelf(BaseDamage) end

---Set Settings
---@param UserSettings UserSettingsStruct
---@return nil
function BarrelGameInstance_C.SetSettings(UserSettings) end

---Get Settings
---@return nil, UserSettingsStruct
function BarrelGameInstance_C.GetSettings() end

---Save User Settings
---@return nil
function BarrelGameInstance_C.SaveUserSettings() end

---Barrel Daymanager Set Rainoffset
---@param RainOffset number
---@return nil
function BarrelGameInstance_C.barrel_daymanager_set_rainoffset(RainOffset) end

---Barrel Music Forceplay
---@param song integer
---@param intensity boolean
---@return nil
function BarrelGameInstance_C.barrel_music_forceplay(song, intensity) end

---Barrel Load Thumbs
---@return nil
function BarrelGameInstance_C.barrel_load_thumbs() end

---Get Thumbnail
---@return Texture2D
function BarrelGameInstance_C.get_thumbnail() end

---Add Thumbnail
---@param id string
---@param path string
---@return nil
function BarrelGameInstance_C.add_thumbnail(id, path) end

---Barrel Ui Dbg Anim
---@return nil
function BarrelGameInstance_C.barrel_ui_dbg_anim() end

---Barrel Dbg Draw Temperature
---@param DrawTemperatureDebug boolean
---@return nil
function BarrelGameInstance_C.barrel_dbg_draw_temperature(DrawTemperatureDebug) end

---Barrel Inv Setcompval
---@param Index integer
---@param component string
---@param NewValue string
---@return nil
function BarrelGameInstance_C.barrel_inv_setcompval(Index, component, NewValue) end

---Barrel Inv Getcomp
---@param Index integer
---@param component string
---@return nil
function BarrelGameInstance_C.barrel_inv_getcomp(Index, component) end

---Barrel Sv Spectate
---@return nil
function BarrelGameInstance_C.barrel_sv_spectate() end

---Barrel Sv Save
---@return nil
function BarrelGameInstance_C.barrel_sv_save() end

---Barrel Char Injureall
---@return nil
function BarrelGameInstance_C.barrel_char_injureall() end

---Get Account Data
---@return nil, AccountDataStruct
function BarrelGameInstance_C.GetAccountData() end

---Set Account Data
---@param AccountData AccountDataStruct
---@return nil, AccountDataStruct
function BarrelGameInstance_C.SetAccountData(AccountData) end

---Get Autolog Info
---@return nil, string, boolean
function BarrelGameInstance_C.GetAutologInfo() end

---Save Autolog Info
---@param private string
---@return nil
function BarrelGameInstance_C.SaveAutologInfo(private) end

---Barrel Char Set Bone Flag
---@param Bone string
---@param flag string
---@return nil
function BarrelGameInstance_C.barrel_char_set_bone_flag(Bone, flag) end

---Barrel Panel Create
---@param ClassName string
---@return nil
function BarrelGameInstance_C.barrel_panel_create(ClassName) end

---Barrel Char Suicide
---@param type string
---@return nil
function BarrelGameInstance_C.barrel_char_suicide(type) end

---Barrel Give Item
---@param ItemID string
---@param Amount integer
---@return nil
function BarrelGameInstance_C.barrel_give_item(ItemID, Amount) end

---Barrel Char Setstat
---@param stat string
---@param val number
---@return nil
function BarrelGameInstance_C.barrel_char_setstat(stat, val) end

---Barrel Char Performaction
---@param CallbackFunctionName string
---@param CallbackTime number
---@param InitActionFunctionName string
---@param CanMoveDuring boolean
---@param CanSprintDuring boolean
---@return nil
function BarrelGameInstance_C.barrel_char_performaction(CallbackFunctionName, CallbackTime, InitActionFunctionName, CanMoveDuring, CanSprintDuring) end

---Barrel Ui Calendar
---@return nil
function BarrelGameInstance_C.barrel_ui_calendar() end

---Barrel Set Time
---@param daytime number
---@return nil
function BarrelGameInstance_C.barrel_set_time(daytime) end

---Barrel Debug Ui
---@return nil
function BarrelGameInstance_C.barrel_debug_ui() end

---Barrel Dbg Ui Apitest
---@return nil
function BarrelGameInstance_C.barrel_dbg_ui_apitest() end

---Parse Test
---@param properties string
---@param key string
---@return nil, string
function BarrelGameInstance_C.parseTest(properties, key) end

---Barrel Net Sv Start
---@return nil
function BarrelGameInstance_C.barrel_net_sv_start() end

---Play Title
---@return nil
function BarrelGameInstance_C.PlayTitle() end

---Stop Title
---@return nil
function BarrelGameInstance_C.StopTitle() end

---Boot to Title
---@return nil
function BarrelGameInstance_C.BootToTitle() end

return BarrelGameInstance_C
