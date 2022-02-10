--[[
	LuckyCharmsClassic
	Last Changed By: neer
	Last Changed: 2/16/2017 12:18:44 PM
]]
function Localize()
	local locale = GetLocale();
--[[
"frFR": French
"deDE": German
"enUS": American english (what should be "enGB" clients return "enUS", too)
"koKR": Korean
"zhCN": Chinese (simplified)
"zhTW": Chinese (traditional)
"ruRU": Russian (UI AddOn)
"esES": Spanish (Spain)
"esMX": Spanish (Mexico)
]]

	if ( locale == "deDE" ) then
		LC2LocalizeDE();
	else
		LC2LocalizeEN();
	end

	--Version
	LC2Version = "v1.0";
	LC2SettVer = "1.2";

	--Crowd Control Spells
	--Last CCID = 16
	LC2Txt_DruidCC = {--Spell IDs of CC spells for Druids
		{1,33786},--Cyclone, Druid, 1 Any [1]
		{2,2637},--Hibernate, Druid, 1 Beast,Dragonkin [2]
		{16,339},--Entangling Roots, Druid, Any [3]
	};

	LC2Txt_HunterCC = {--Spell IDs of CC spells for Hunters
		--{3,1499},--Freezing Trap, Hunter, 1 Any [1]
		{4,19386},--Wyvern Sting (Talent), Hunter, 1 Any [2]
	};

	LC2Txt_MageCC = {--Spell IDs of CC spells for Mage
		{5,118},--Polymorph, Mage, 1 Humanoid, Beast, Critter [1]
	};

	LC2Txt_PaladinCC = {--Spell IDs of CC spells for Paladin
		{6,20066},--Repentance (Talent), Paladin, 1 Humanoid, Undead, Dragonkin, Giant, Demon [1]
	};

	LC2Txt_PriestCC = {--Spell IDs of CC spells for Priest
		{7,9484},--Shackle Undead, Priest, 1 Undead [1]
		{8,605},--Mind Control, Priest, 1 Humanoid [2]
	};

	LC2Txt_RogueCC = {--Spell IDs of CC spells for Rogue
		{9,6770},--Sap, Rogue, 1 Humanoid, Beasts, Demons, Dragonkin [1]
	};

	LC2Txt_ShamanCC = {--Spell IDs of CC spells for Shaman
		{10,51514},--Hex, Shaman, 1 Humanoid, Beast [1]
		{11,76780},--Bind Elemental, Shaman 1 Elemental [2]
	};

	LC2Txt_WarlockCC = {--Spell IDs of CC spells for Warlocks
		{12,6358},--Seduction, Warlock, 1 Humanoid [1]
		{13,710},--Banish, Warlock, 1 Demon, Elemental [2]
		{14,1098},--Enslave Demon, Warlock, 1 demon [3]
		{15,5782},--Fear, Warlock, Any
	};
	--end Crowd Control Spells

	--ENGLISH Crowd Control Classes
	LC2Txt_CCClassEN = {
		"DRUID", --[1]
		"HUNTER", --[2]
		"MAGE", --[3]
		"PALADIN", --[4]
		"PRIEST", --[5]
		"ROGUE", --[6]
		"SHAMAN", --[7]
		"WARLOCK", --[8]
	};
	--[[
	DEATHKNIGHT="Death Knight",
    WARRIOR="Warrior",
    ROGUE="Rogue",
    MAGE="Mage",
    PRIEST="Priest",
    WARLOCK="Warlock",
    HUNTER="Hunter",
    SHAMAN="Shaman",
    DRUID="Druid",
    MONK="Monk",
    PALADIN="Paladin"
   ]]
	--end ENGLISH Crowd Control Classes
	--Crowd Control Classes
	LC2Txt_CCClass = {
		LOCALIZED_CLASS_NAMES_MALE[LC2Txt_CCClassEN[1]],
		LOCALIZED_CLASS_NAMES_MALE[LC2Txt_CCClassEN[2]],
		LOCALIZED_CLASS_NAMES_MALE[LC2Txt_CCClassEN[3]],
		LOCALIZED_CLASS_NAMES_MALE[LC2Txt_CCClassEN[4]],
		LOCALIZED_CLASS_NAMES_MALE[LC2Txt_CCClassEN[5]],
		LOCALIZED_CLASS_NAMES_MALE[LC2Txt_CCClassEN[6]],
		LOCALIZED_CLASS_NAMES_MALE[LC2Txt_CCClassEN[7]],
		LOCALIZED_CLASS_NAMES_MALE[LC2Txt_CCClassEN[8]]
	};
	--end Crowd Control Classes

	--Combos
	LC2TT_RC = LC2TT_RCPERFORM.." "..READY_CHECK;
	READY_CHECKB = READY_CHECK.." "..LC2TXT_BTN;
	LC2Txt_KORaidWarning = LC2TXT_SHOWIN.." "..CHAT_MSG_RAID_WARNING;
	LC2Txt_KOPR = LC2TXT_SHOWIN.." "..CHAT_MSG_PARTY.."/"..CHAT_MSG_RAID;
	LC2ERR_PartyLead = ERR_NOT_LEADER.." "..LC2ERR_PARTYLEADTXT;
end
