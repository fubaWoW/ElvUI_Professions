-------------------------------------------------------------------------------
-- ElvUI Professions Datatext By Lockslap (US, Bleeding Hollow)
-------------------------------------------------------------------------------
local debug = false
--[===[@debug@
debug = true
--@end-debug@]===]
local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("ElvUI_Professions", "enUS", true, debug)
if not L then return end

L["No Profession"] = true
L["Open "] = true
L["Professions Datatext"] = true
L["Select which profession to display."] = true
L["Show Hint"] = true
L["Show the hint in the tooltip."] = true