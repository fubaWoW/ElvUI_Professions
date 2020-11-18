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

-- Main Profession localisations
local sAlchemy = GetSpellInfo(2259)
local sBlacksmithing = GetSpellInfo(2018)
local sEnchanting = GetSpellInfo(7411)
local sEngineering = GetSpellInfo(4036)
local sHerbalism = GetSpellInfo(13614)
local sLeatherworking = GetSpellInfo(2108)
local sLockpicking = GetSpellInfo(1809)
local sMining = GetSpellInfo(2575)
local sSkinning = GetSpellInfo(8613)
local sSmelting = GetSpellInfo(2656)
local sTailoring = GetSpellInfo(3908)
local sJewelcrafting = GetSpellInfo(25229)

-- Second Profession localisations
local sCooking = GetSpellInfo(2550)
local sFirstAid = GetSpellInfo(3273)
local sFishing = GetSpellInfo(7620)
local sArchaeology = GetSpellInfo(78670)

-- Profession Tracking localisations
local sFindHerbs = GetSpellInfo(2383)
local sFindMinerals = GetSpellInfo(2580)

local mainprof1 = {sAlchemy, sBlacksmithing, sEnchanting, sEngineering, sJewelcrafting, sLeatherworking, sTailoring, sMining}
local mainprof2 = {sHerbalism, sSkinning}
local secprof = {sCooking, sFirstAid, sFishing, sArchaeology}

local function GetProfessionName(index)
  local name = GetProfessionInfo(index)
  return name
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

  local prof1, prof2, archy, fishing, cooking, firstAid = GetProfessions()
  local profname
	if (button == "LeftButton") or (button == "RightButton") then
		if (button == "LeftButton") then
			if IsAltKeyDown() and cooking ~= nil then
				profname = sCooking
			else
				if E.private.profdt.prof == "prof1" then
					profname = prof1 and GetProfessionInfo(prof1) or "";
				else
					profname = prof2 and GetProfessionInfo(prof2) or "";
				end
			end
		elseif (button == "RightButton") then
			if IsAltKeyDown() and fishing ~= nil then
				profname = sFishing
			else
				if E.private.profdt.prof == "prof1" then
					profname = prof2 and GetProfessionInfo(prof2) or "";
				else
					profname = prof1 and GetProfessionInfo(prof1) or "";
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
			profname1 = prof1 and GetProfessionInfo(prof1) or "";
			profname2 = prof2 and GetProfessionInfo(prof2) or "";
		else
			profname1 = prof2 and GetProfessionInfo(prof2) or "";
			profname2 = prof1 and GetProfessionInfo(prof1) or "";
		end
	
    DT.tooltip:AddLine(" ")
    DT.tooltip:AddDoubleLine(KEY_BUTTON1, profname1, 1, 1, 1, 1, 1, 0)
    DT.tooltip:AddDoubleLine(KEY_BUTTON2, profname2, 1, 1, 1, 1, 1, 0)
    DT.tooltip:AddDoubleLine(L["Alt + "]..KEY_BUTTON1, sCooking, 1, 1, 1, 1, 1, 0)
		DT.tooltip:AddDoubleLine(L["Alt + "]..KEY_BUTTON2, sArchaeology, 1, 1, 1, 1, 1, 0)
		DT.tooltip:AddDoubleLine(KEY_BUTTON3, _G["SPELLBOOK"], 1, 1, 1, 1, 1, 0)
  end

  DT.tooltip:Show()
end

local function ValueColorUpdate(hex, r, g, b)
  displayString = join("", "|cffffffff%s:|r ", hex, "%d|r/", hex, "%d|r")
  tooltipString = join("" , hex, "%d|r|cffffffff/|r", hex, "%d|r")
  if lastPanel ~= nil then OnEvent(lastPanel) end
end
E["valueColorUpdateFuncs"][ValueColorUpdate] = true

V["profdt"] = {
  ["prof"] = "prof1",
  ["hint"] = true,
}

local function InjectOptions()
  if not E.Options.args.fuba then
    E.Options.args.fuba = {
      type = "group",
      order = -2,
      name = L["Plugins by |cff0080fffuba|r"],
      args = {
        thanks = {
          type = "description",
          order = 1,
          name = L["ElvUI Plugins by |cff0080fffuba|r\n\n|cffff80ffIf you find any bugs, or have any suggestions for any of my AddOns, please open a ticket at that particular Page on GitHub."],
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
        name = L["Professions"],
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

EP:RegisterPlugin(..., InjectOptions)
DT:RegisterDatatext("Professions", nil, {"PLAYER_ENTERING_WORLD", "CHAT_MSG_SKILL", "TRADE_SKILL_LIST_UPDATE", "TRADE_SKILL_DATA_SOURCE_CHANGED"}, OnEvent, nil, Click, OnEnter)