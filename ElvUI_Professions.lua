-------------------------------------------------------------------------------
-- ElvUI Professions Datatext By Lockslap
-- Edited and Fixed by fuba to work with Legion and BfA
-------------------------------------------------------------------------------
if not ElvUI then return end
local E, _, V, P, G = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local DT = E:GetModule('DataTexts')
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_Professions", false)
local EP = LibStub("LibElvUIPlugin-1.0")

local format = string.format
local join = string.join

local lastPanel
local profValues = {}
local displayString = ""
local tooltipString = ""
local TradeSkillUIOpened = false

local STAT_CATEGORY_FUBA = "fuba"

-- Main Profession localisations
local sAlchemy 					= C_Spell and C_Spell.GetSpellName(2259) or GetSpellInfo(2259)
local sBlacksmithing 		= C_Spell and C_Spell.GetSpellName(2018) or GetSpellInfo(2018)
local sEnchanting 			= C_Spell and C_Spell.GetSpellName(7411) or GetSpellInfo(7411)
local sEngineering 			= C_Spell and C_Spell.GetSpellName(4036) or GetSpellInfo(4036)
local sHerbalism 				= C_Spell and C_Spell.GetSpellName(13614) or GetSpellInfo(13614)
local sLeatherworking 	= C_Spell and C_Spell.GetSpellName(2108) or GetSpellInfo(2108)
local sLockpicking 			= C_Spell and C_Spell.GetSpellName(1809) or GetSpellInfo(1809)
local sMining 					= C_Spell and C_Spell.GetSpellName(2575) or GetSpellInfo(2575)
local sSkinning 				= C_Spell and C_Spell.GetSpellName(8613) or GetSpellInfo(8613)
local sSmelting 				= C_Spell and C_Spell.GetSpellName(2656) or GetSpellInfo(2656)
local sTailoring 				= C_Spell and C_Spell.GetSpellName(3908) or GetSpellInfo(3908)
local sJewelcrafting 		= C_Spell and C_Spell.GetSpellName(25229) or GetSpellInfo(25229)

-- Second Profession localisations
local sCooking 					= C_Spell and C_Spell.GetSpellName(2550) or GetSpellInfo(2550)
local sFirstAid 				= C_Spell and C_Spell.GetSpellName(3273) or GetSpellInfo(3273)
local sFishing 					= C_Spell and C_Spell.GetSpellName(7620) or GetSpellInfo(7620)
local sArchaeology 			= C_Spell and C_Spell.GetSpellName(78670) or GetSpellInfo(78670)

-- Profession Tracking localisations
local sFindHerbs 				= C_Spell and C_Spell.GetSpellName(2383) or GetSpellInfo(2383)
local sFindMinerals 		= C_Spell and C_Spell.GetSpellName(2580) or GetSpellInfo(2580)

local mainprof1 = {sAlchemy, sBlacksmithing, sEnchanting, sEngineering, sJewelcrafting, sLeatherworking, sTailoring, sMining}
local mainprof2 = {sHerbalism, sSkinning}
local secprof = {sCooking, sFirstAid, sFishing, sArchaeology}

local function GetProfessionName(index)
  local name = GetProfessionInfo(index)
  return name or _G.UNKNOWN or ""
end

local function OnEvent(self, event, ...)
  local prof1, prof2, archy, fishing, cooking, firstAid = GetProfessions()

  if not E.private.profdt then return end
  if E.private.profdt.prof == "prof1" then

    if prof1 ~= nil then
      local name, _, rank, maxRank, _, _, _, _ = GetProfessionInfo(prof1)
      self.text:SetFormattedText(displayString, name, rank, maxRank)
    else
      self.text:SetText(L["No Profession"])
    end

  elseif E.private.profdt.prof == "prof2" then

    if prof2 ~= nil then
      local name, _, rank, maxRank, _, _, _, _ = GetProfessionInfo(prof2)
      self.text:SetFormattedText(displayString, name, rank, maxRank)
    else
      self.text:SetText(L["No Profession"])
    end

  elseif E.private.profdt.prof == "archy" then

    if archy ~= nil then
      local name, _, rank, maxRank, _, _, _, _ = GetProfessionInfo(archy)
      self.text:SetFormattedText(displayString, name, rank, maxRank)
    else
      self.text:SetText(L["No Profession"])
    end

  elseif E.private.profdt.prof == "fishing" then

    if fishing ~= nil then
      local name, _, rank, maxRank, _, _, _, _ = GetProfessionInfo(fishing)
      self.text:SetFormattedText(displayString, name, rank, maxRank)
    else
      self.text:SetText(L["No Profession"])
    end

  elseif E.private.profdt.prof == "cooking" then

    if cooking ~= nil then
      local name, _, rank, maxRank, _, _, _, _ = GetProfessionInfo(cooking)
      self.text:SetFormattedText(displayString, name, rank, maxRank)
    else
      self.text:SetText(L["No Profession"])
    end

  elseif E.private.profdt.prof == "firstaid" then

    if firstAid ~= nil then
      local name, _, rank, maxRank, _, _, _, _ = GetProfessionInfo(firstAid)
      self.text:SetFormattedText(displayString, name, rank, maxRank)
    else
      self.text:SetText(L["No Profession"])
    end

  end
end

local function Click(self, button)
	--SPELL_FAILED_NOT_KNOWN
	--ADVENTURE_TRACKING_OPEN_PROFESSION_ERROR_TEXT
  local prof1, prof2, archy, fishing, cooking, firstAid = GetProfessions()
  local profname
	if (button == "LeftButton") or (button == "RightButton") then
		if (button == "LeftButton") then
			if IsShiftKeyDown() and cooking ~= nil then
				profname = sCooking
			elseif IsControlKeyDown() then
				profname = sArchaeology
			else
				if E.private.profdt.prof == "prof1" then
					profname = prof1 and GetProfessionInfo(prof1) or ADVENTURE_TRACKING_OPEN_PROFESSION_ERROR_TEXT or "";
				else
					profname = prof2 and GetProfessionInfo(prof2) or ADVENTURE_TRACKING_OPEN_PROFESSION_ERROR_TEXT or "";
				end
			end
		elseif (button == "RightButton") then
			if IsShiftKeyDown() and fishing ~= nil then
				profname = sFishing
			else
				if E.private.profdt.prof == "prof1" then
					profname = prof2 and GetProfessionInfo(prof2) or ADVENTURE_TRACKING_OPEN_PROFESSION_ERROR_TEXT or "";
				else
					profname = prof1 and GetProfessionInfo(prof1) or ADVENTURE_TRACKING_OPEN_PROFESSION_ERROR_TEXT or "";
				end
			end
		end
		
		if (E.private.profdt.prof and profname) then
			for i = 1, select("#", GetProfessions()) do
				local profindex = select(i, GetProfessions())
				if profindex ~= nil then
					local name, icon, skillLevel, maxSkillLevel, numAbilities, spelloffset, skillLine, skillModifier, specializationIndex, specializationOffset = GetProfessionInfo(profindex)
					if name == profname then
						if (not TradeSkillUIOpened) then
							TradeSkillUIOpened = C_TradeSkillUI.OpenTradeSkill(skillLine)
						else
							C_TradeSkillUI.CloseTradeSkill()
							C_Garrison.CloseGarrisonTradeskillNPC()
							TradeSkillUIOpened = false
						end
					end
				end
			end
		end
	elseif (button == "MiddleButton") then
		if SpellBookFrame then
			ShowUIPanel(SpellBookFrame);
		end
	end
end

local function OnEnter(self)
  DT:SetupTooltip(self)

  local prof1, prof2, archy, fishing, cooking = GetProfessions()
  local professions = {}

  if prof1 ~= nil then
    local name, texture, rank, maxRank, _, _, _, _ = GetProfessionInfo(prof1)
    professions[#professions + 1] = {
      name  = name,
      texture = ("|T%s:12:12:1:0|t"):format(texture),
      rank  = rank,
      maxRank = maxRank
    }
  end

  if prof2 ~= nil then
    local name, texture, rank, maxRank, _, _, _, _ = GetProfessionInfo(prof2)
    professions[#professions + 1] = {
      name  = name,
      texture = ("|T%s:12:12:1:0|t"):format(texture),
      rank  = rank,
      maxRank = maxRank
    }
  end

  if archy ~= nil then
    local name, texture, rank, maxRank, _, _, _, _ = GetProfessionInfo(archy)
    professions[#professions + 1] = {
      name  = name,
      texture = ("|T%s:12:12:1:0|t"):format(texture),
      rank  = rank,
      maxRank = maxRank
			
    }
  end

  if fishing ~= nil then
    local name, texture, rank, maxRank, _, _, _, _ = GetProfessionInfo(fishing)
    professions[#professions + 1] = {
      name  = name,
      texture = ("|T%s:12:12:1:0|t"):format(texture),
      rank  = rank,
      maxRank = maxRank
    }
  end

  if cooking ~= nil then
    local name, texture, rank, maxRank, _, _, _, _ = GetProfessionInfo(cooking)
    professions[#professions + 1] = {
      name  = name,
      texture = ("|T%s:12:12:1:0|t"):format(texture),
      rank  = rank,
      maxRank = maxRank
    }
  end

  if #professions == 0 then return end
  --sort(professions, function(a, b) return a["name"] < b["name"] end)
  DT.tooltip:AddDoubleLine(TRADE_SKILLS, nil, 1, 1, 1, 1, 1, 1)
  for i = 1, #professions do
    DT.tooltip:AddDoubleLine(join("", professions[i].texture, "  ", professions[i].name), tooltipString:format(professions[i].rank, professions[i].maxRank), 1, 1, 1, 1, 1, 1)
  end
	
  if E.private.profdt.hint then
		local prof1, prof2, archy, fishing, cooking, firstAid = GetProfessions()
		if E.private.profdt.prof == "prof1" then			
			profname1 = prof1 and GetProfessionInfo(prof1) or ADVENTURE_TRACKING_OPEN_PROFESSION_ERROR_TEXT or "";
			profname2 = prof2 and GetProfessionInfo(prof2) or ADVENTURE_TRACKING_OPEN_PROFESSION_ERROR_TEXT or "";
		else
			profname1 = prof2 and GetProfessionInfo(prof2) or ADVENTURE_TRACKING_OPEN_PROFESSION_ERROR_TEXT or "";
			profname2 = prof1 and GetProfessionInfo(prof1) or ADVENTURE_TRACKING_OPEN_PROFESSION_ERROR_TEXT or "";
		end
		
		--SHIFT_KEY = "ALT key";
		--SHIFT_KEY_TEXT = "ALT";
		--ALT_KEY = "ALT key";
		--ALT_KEY_TEXT = "ALT";
		--CTRL_KEY = "CTRL key";
		--CTRL_KEY_TEXT = "CTRL";
		--LCTRL_KEY_TEXT = "Left CTRL";
		--RCTRL_KEY_TEXT = "Right CTRL";
		--LCMD_KEY_TEXT = "Left CMD";
		--RCMD_KEY_TEXT = "Right CMD";
		
    DT.tooltip:AddLine(" ")
    DT.tooltip:AddDoubleLine(KEY_BUTTON1, profname1, 1, 1, 1, 1, 1, 0)
    DT.tooltip:AddDoubleLine(KEY_BUTTON2, profname2, 1, 1, 1, 1, 1, 0)
    if cooking then DT.tooltip:AddDoubleLine(SHIFT_KEY.." + "..KEY_BUTTON1, sCooking, 1, 1, 1, 1, 1, 0) end
		if fishing then DT.tooltip:AddDoubleLine(SHIFT_KEY.." + "..KEY_BUTTON2, sFishing, 1, 1, 1, 1, 1, 0) end
		if archy then DT.tooltip:AddDoubleLine(CTRL_KEY.." + "..KEY_BUTTON1, sArchaeology, 1, 1, 1, 1, 1, 0) end
		DT.tooltip:AddDoubleLine(KEY_BUTTON3, _G["SPELLBOOK"], 1, 1, 1, 1, 1, 0)
  end

  DT.tooltip:Show()
end

local function ValueColorUpdate(self, hex, r, g, b)
  displayString = join("", "|cffffffff%s:|r ", hex, "%d|r/", hex, "%d|r")
  tooltipString = join("" , hex, "%d|r|cffffffff/|r", hex, "%d|r")
  if lastPanel ~= nil then OnEvent(lastPanel) end
	--OnEvent(self)
end
--E["valueColorUpdateFuncs"][ValueColorUpdate] = true

V["profdt"] = {
  ["prof"] = "prof1",
  ["hint"] = true,
}

local function InjectOptions()
  if not E.Options.args.fuba then
    E.Options.args.fuba = {
      type = "group",
      order = -2,
      name = "Plugins by |cff0080fffuba|r",
      args = {
        thanks = {
          type = "description",
          order = 1,
          name = "ElvUI Plugins by |cff0080fffuba|r\n\n|cffff80ffIf you find any bugs, or have any suggestions for any of my AddOns, please open a ticket at that particular Page on GitHub.",
        },
      },
    }
  end

  E.Options.args.fuba.args.profdt = {
    type = "group",
    name = L["Professions Datatext"],
    get = function(info) return E.private.profdt[info[#info]] end,
    set = function(info, value) E.private.profdt[info[#info]] = value; DT:LoadDataTexts() end,
    args = {
      prof = {
        type = "select",
        order = 1,
        name = TRADE_SKILLS,
        desc = L["Select which profession to display."],
        values = function()
          local prof1, prof2, archy, fishing, cooking, firstAid = GetProfessions()
          local profValues = {}
          if prof1 ~= nil then profValues['prof1'] = GetProfessionName(prof1) end
          if prof2 ~= nil then profValues['prof2'] = GetProfessionName(prof2) end
          if archy ~= nil then profValues['archy'] = GetProfessionName(archy) end
          if fishing ~= nil then profValues['fishing'] = GetProfessionName(fishing) end
          if cooking ~= nil then profValues['cooking'] = GetProfessionName(cooking) end
          if firstAid ~= nil then profValues['firstaid'] = GetProfessionName(firstAid) end
          sort(profValues)
          return profValues
        end,
      },
      hint = {
        type = "toggle",
        order = 2,
        name = L["Show Hint"],
        desc = L["Show the hint in the tooltip."],
      },
    },
  }
end

--[[
	DT:RegisterDatatext(name, category, events, eventFunc, updateFunc, clickFunc, onEnterFunc, onLeaveFunc, localizedName, objectEvent, colorUpdate)

	name - name of the datatext (required) [string]
	category - name of the category the datatext belongs to. [string]
	events - must be a table with string values of event names to register [string or table]
	eventFunc - function that gets fired when an event gets triggered [function]
	updateFunc - onUpdate script target function [function]
	click - function to fire when clicking the datatext [function]
	onEnterFunc - function to fire OnEnter [function]
	onLeaveFunc - function to fire OnLeave, if not provided one will be set for you that hides the tooltip. [function]
	localizedName - localized name of the datetext [string]
	objectEvent - register events on an object, using E.RegisterEventForObject instead of panel.RegisterEvent [function]
	colorUpdate - function that fires when called from the config when you change the dt options. [function]
]]

EP:RegisterPlugin(..., InjectOptions)
DT:RegisterDatatext("Professions", STAT_CATEGORY_FUBA, {"PLAYER_ENTERING_WORLD", "CHAT_MSG_SKILL", "TRADE_SKILL_LIST_UPDATE", "TRADE_SKILL_DATA_SOURCE_CHANGED"}, OnEvent, nil, Click, OnEnter, nil, nil, nil, ValueColorUpdate)