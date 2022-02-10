--[[
LuckyCharmsClassic
Last Changed By: mattiam
Last Changed: 03/26/2020 03:07 PM

Changes: See changelog.txt
ReadMe: See readme.txt

###Known Bugs###
None
]]

--Locals
local LC2_Realm = GetRealmName(); --Get Realm for Profile.
local LC2_Char = UnitName("player"); --Get char name for profile.
local LC2Profile = LC2_Realm.." - "..LC2_Char;
local LBF = LibStub("Masque",true);

--Set Defaults
PrevSettVer = "";
charmArr = {}; --Charm Array
charmArr[1] = {};
charmArr[1][0] = RAID_TARGET_1;--Star
charmArr[1][1] = "{"..ICON_TAG_RAID_TARGET_STAR1.."}";
charmArr[2] = {};
charmArr[2][0] = RAID_TARGET_2;--Circle
charmArr[2][1] = "{"..ICON_TAG_RAID_TARGET_CIRCLE1.."}";
charmArr[3] = {};
charmArr[3][0] = RAID_TARGET_3;--Diamond
charmArr[3][1] = "{"..ICON_TAG_RAID_TARGET_DIAMOND1.."}";
charmArr[4] = {};
charmArr[4][0] = RAID_TARGET_4;--Triangle
charmArr[4][1] = "{"..ICON_TAG_RAID_TARGET_TRIANGLE1.."}";
charmArr[5] = {};
charmArr[5][0] = RAID_TARGET_5;--Moon
charmArr[5][1] = "{"..ICON_TAG_RAID_TARGET_MOON1.."}";
charmArr[6] = {};
charmArr[6][0] = RAID_TARGET_6;--Square
charmArr[6][1] = "{"..ICON_TAG_RAID_TARGET_SQUARE1.."}";
charmArr[7] = {};
charmArr[7][0] = ICON_TAG_RAID_TARGET_CROSS2;--Cross
charmArr[7][1] = "{"..ICON_TAG_RAID_TARGET_CROSS1.."}";
charmArr[8] = {};
charmArr[8][0] = RAID_TARGET_8;--Skull
charmArr[8][1] = "{"..ICON_TAG_RAID_TARGET_SKULL1.."}";

--Enchanced CC Members Array
CCMembers = {};
LuckyCharms = {};

--Additional Combat mechanisms
LuckyCharms.waiting = false;
LuckyCharms.waitEvents = {};

--Define Dynamic Images
local unlockImage = "Interface\\AddOns\\LuckyCharmsClassic\\images\\menuunlock";
local lockImage = "Interface\\AddOns\\LuckyCharmsClassic\\images\\menulock";

--Generic Function to Print Chat Message
function LuckyCharms.Message(text)
	DEFAULT_CHAT_FRAME:AddMessage("|cffffd200"..LC2NAME..":|r "..tostring(text));
end
--End Chat Function

function LuckyCharms.DragOnEnter(self)
	--LuckyCharms.Message(self);--Debug
	if(LC2_Settings[LC2Profile].tooltips == 1) then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
		GameTooltip:SetText("|cFFFFFFFF"..LC2NAME.."!|r", nil, nil, nil, nil, 0);
		GameTooltip:AddLine(LC2TT_LEFTCLICKHOLD);
		if (LuckyCharms.IsLocked() == 1) then
			GameTooltip:AddLine(LC2TT_LEFTSHIFTUNLOCK);
		else
			GameTooltip:AddLine(LC2TT_LEFTSHIFTLOCK);
		end
		GameTooltip:AddLine(LC2TT_RIGHTCLICK);
		GameTooltip:Show();
	end
end

function LuckyCharms.DragUp(_, button)
	if ( LuckyCharmAnchor.isMoving ) then
		LuckyCharmAnchor:StopMovingOrSizing();
		LuckyCharmAnchor.isMoving = false;
	end
end

function LuckyCharms.DragDown(_, button)
	if (LuckyCharms.IsLocked() == 0 and button == "LeftButton") then
		LuckyCharmAnchor:StartMoving();
		LuckyCharmAnchor.isMoving = true;
	end
end

function LuckyCharms.DragOnClick(_, button)
	--LuckyCharms.Message(tostring(button));--Debug
	if (button == 'LeftButton') then
		if (IsShiftKeyDown()) then
			LuckyCharms.ToggleLock();
		end
	end
	if (button == 'RightButton') then
		InterfaceOptionsFrame_OpenToCategory("LuckyCharmsClassic");
		InterfaceOptionsFrame_OpenToCategory("LuckyCharmsClassic");
	end
end

function LuckyCharms.OnCharmClick(mouseButton,self)
	local button = self:GetName();
	--LuckyCharms.Message(tostring(button)..mouseButton);
	local charmNum = 0;
	
	if(button == "LuckyCharm1") then
		charmNum = 1;
	elseif(button == "LuckyCharm2") then
		charmNum = 2;
	elseif(button == "LuckyCharm3") then
		charmNum = 3;
	elseif(button == "LuckyCharm4") then
		charmNum = 4;
	elseif(button == "LuckyCharm5") then
		charmNum = 5;
	elseif(button == "LuckyCharm6") then
		charmNum = 6;
	elseif(button == "LuckyCharm7") then
		charmNum = 7;
	elseif(button == "LuckyCharm8") then
		charmNum = 8;
	end	
	
	if (mouseButton == 'LeftButton') then
		local uct = UnitCreatureType("target");
		if(uct ~= nil and charmNum ~= 0) then
			--LuckyCharms.Message(uct.." "..charmNum.." "..LC2_Settings[LC2Profile].charmcc[charmNum]["name"]);--Debug
			--for k,v in pairs(LC2_Settings[LC2Profile].charmcc[charmNum]) do print(k,v) end --debug
			if(LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] ~= nil and LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] ~= "") then
				if(LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 1 or LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 3 or LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 4 or LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 15 or LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 16) then
					--Druid Cyclone, Hunter Freezing Trap, Hunter Wyvern Sting, Warlock Fear, Druid Entangling Roots
					SetRaidTarget("target", charmNum);
				elseif(LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 2) then --Druid Hibernate
					if(uct ~= LC2TXT_UTYPE[1] and uct ~= LC2TXT_UTYPE[2]) then --Beasts, Dragonkin
						LuckyCharms.Message("|cFFEE0000"..LC2_Settings[LC2Profile].charmcc[charmNum]["name"] .. " " .. SPELL_FAILED_BAD_TARGETS .. "|r");
						UIErrorsFrame:AddMessage(LC2_Settings[LC2Profile].charmcc[charmNum]["name"] .. " " .. SPELL_FAILED_BAD_TARGETS,1.0,0.0,0.0,53,5);
					else
						SetRaidTarget("target", charmNum);
					end
				elseif(LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 5) then --Mage Polymorph
					if(uct ~= LC2TXT_UTYPE[1] and uct ~= LC2TXT_UTYPE[7] and uct ~= LC2TXT_UTYPE[8]) then --Humanoid, Beast, Critter
						LuckyCharms.Message("|cFFEE0000"..LC2_Settings[LC2Profile].charmcc[charmNum]["name"] .. " " .. SPELL_FAILED_BAD_TARGETS .. "|r");
						UIErrorsFrame:AddMessage(LC2_Settings[LC2Profile].charmcc[charmNum]["name"] .. " " .. SPELL_FAILED_BAD_TARGETS,1.0,0.0,0.0,53,5);
					else
						SetRaidTarget("target", charmNum);
					end
				elseif(LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 6) then --Repentance (Talent), Paladin
					if(uct ~= LC2TXT_UTYPE[7] and uct ~= LC2TXT_UTYPE[6] and uct ~= LC2TXT_UTYPE[5] and uct ~= LC2TXT_UTYPE[3] and uct ~= LC2TXT_UTYPE[2]) then --Humanoid, Undead, Dragonkin, Giant, Demon
						LuckyCharms.Message("|cFFEE0000"..LC2_Settings[LC2Profile].charmcc[charmNum]["name"] .. " " .. SPELL_FAILED_BAD_TARGETS .. "|r");
						UIErrorsFrame:AddMessage(LC2_Settings[LC2Profile].charmcc[charmNum]["name"] .. " " .. SPELL_FAILED_BAD_TARGETS,1.0,0.0,0.0,53,5);
					else
						SetRaidTarget("target", charmNum);
					end
				elseif(LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 7) then --Shackle Undead, Priest
					if(uct ~= LC2TXT_UTYPE[6]) then --Undead
						LuckyCharms.Message("|cFFEE0000"..LC2_Settings[LC2Profile].charmcc[charmNum]["name"] .. " " .. SPELL_FAILED_BAD_TARGETS .. "|r");
						UIErrorsFrame:AddMessage(LC2_Settings[LC2Profile].charmcc[charmNum]["name"] .. " " .. SPELL_FAILED_BAD_TARGETS,1.0,0.0,0.0,53,5);
					else
						SetRaidTarget("target", charmNum);
					end
				elseif(LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 8) then --Mind Control, Priest
					if(uct ~= LC2TXT_UTYPE[7]) then --Humanoid
						LuckyCharms.Message("|cFFEE0000"..LC2_Settings[LC2Profile].charmcc[charmNum]["name"] .. " " .. SPELL_FAILED_BAD_TARGETS .. "|r");
						UIErrorsFrame:AddMessage(LC2_Settings[LC2Profile].charmcc[charmNum]["name"] .. " " .. SPELL_FAILED_BAD_TARGETS,1.0,0.0,0.0,53,5);
					else
						SetRaidTarget("target", charmNum);
					end
				elseif(LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 9) then --Sap, Rogue
					if(uct ~= LC2TXT_UTYPE[7] and uct ~= LC2TXT_UTYPE[1] and uct ~= LC2TXT_UTYPE[3] and uct ~= LC2TXT_UTYPE[2]) then --Humanoid, Beasts, Demons, Dragonkin
						LuckyCharms.Message("|cFFEE0000"..LC2_Settings[LC2Profile].charmcc[charmNum]["name"] .. " " .. SPELL_FAILED_BAD_TARGETS .. "|r");
						UIErrorsFrame:AddMessage(LC2_Settings[LC2Profile].charmcc[charmNum]["name"] .. " " .. SPELL_FAILED_BAD_TARGETS,1.0,0.0,0.0,53,5);
					else
						SetRaidTarget("target", charmNum);
					end
				elseif(LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 10) then --Hex, Shaman
					if(uct ~= LC2TXT_UTYPE[1] and uct ~= LC2TXT_UTYPE[7]) then --Humanoid, Beast
						LuckyCharms.Message("|cFFEE0000"..LC2_Settings[LC2Profile].charmcc[charmNum]["name"] .. " " .. SPELL_FAILED_BAD_TARGETS .. "|r");
						UIErrorsFrame:AddMessage(LC2_Settings[LC2Profile].charmcc[charmNum]["name"] .. " " .. SPELL_FAILED_BAD_TARGETS,1.0,0.0,0.0,53,5);
					else
						SetRaidTarget("target", charmNum);
					end
				elseif(LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 11) then --Shaman Bind Elemental
					if(uct ~= LC2TXT_UTYPE[4]) then --Elemental
						LuckyCharms.Message("|cFFEE0000"..LC2_Settings[LC2Profile].charmcc[charmNum]["name"] .. " " .. SPELL_FAILED_BAD_TARGETS .. "|r");
						UIErrorsFrame:AddMessage(LC2_Settings[LC2Profile].charmcc[charmNum]["name"] .. " " .. SPELL_FAILED_BAD_TARGETS,1.0,0.0,0.0,53,5);
					else
						SetRaidTarget("target", charmNum);
					end
				elseif(LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 12) then --Seduction, Warlock
					if(uct ~= LC2TXT_UTYPE[7]) then --Humanoid
						LuckyCharms.Message("|cFFEE0000"..LC2_Settings[LC2Profile].charmcc[charmNum]["name"] .. " " .. SPELL_FAILED_BAD_TARGETS .. "|r");
						UIErrorsFrame:AddMessage(LC2_Settings[LC2Profile].charmcc[charmNum]["name"] .. " " .. SPELL_FAILED_BAD_TARGETS,1.0,0.0,0.0,53,5);
					else
						SetRaidTarget("target", charmNum);
					end
				elseif(LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 13) then --Banish, Warlock
					if(uct ~= LC2TXT_UTYPE[3] and uct ~= LC2TXT_UTYPE[4]) then --Demon, Elemental
						LuckyCharms.Message("|cFFEE0000"..LC2_Settings[LC2Profile].charmcc[charmNum]["name"] .. " " .. SPELL_FAILED_BAD_TARGETS .. "|r");
						UIErrorsFrame:AddMessage(LC2_Settings[LC2Profile].charmcc[charmNum]["name"] .. " " .. SPELL_FAILED_BAD_TARGETS,1.0,0.0,0.0,53,5);
					else
						SetRaidTarget("target", charmNum);
					end
				elseif(LC2_Settings[LC2Profile].charmcc[charmNum]["ccid"] == 14) then --Enslave Demon
					if(uct ~= LC2TXT_UTYPE[3]) then --Demon
						LuckyCharms.Message("|cFFEE0000"..LC2_Settings[LC2Profile].charmcc[charmNum]["name"] .. " " .. SPELL_FAILED_BAD_TARGETS .. "|r");
						UIErrorsFrame:AddMessage(LC2_Settings[LC2Profile].charmcc[charmNum]["name"] .. " " .. SPELL_FAILED_BAD_TARGETS,1.0,0.0,0.0,53,5);
					else
						SetRaidTarget("target", charmNum);
					end
				end
			else
				SetRaidTarget("target", charmNum);
			end
		elseif(charmNum == 0) then
			SetRaidTarget("target", charmNum);
		else
			LuckyCharms.Message(ERR_GENERIC_NO_TARGET);
		end
	end
end

function LuckyCharms.CCDD_Init(self,level)
	--LuckyCharms.Message(self:GetName());
	--Creating test data structure
	local Test1_Data = {};
	local n = table.getn(LC2Txt_CCClass);
	for i=1, n do
		Test1_Data[LC2Txt_CCClass[i]] = {};
		local x = 0;
		local arr = nil;
		if(i == 1)then
			x = table.getn(LC2Txt_DruidCC);
			arr = LC2Txt_DruidCC;
		elseif(i == 2)then
			x = table.getn(LC2Txt_HunterCC);
			arr = LC2Txt_HunterCC;
		elseif(i == 3)then
			x = table.getn(LC2Txt_MageCC);
			arr = LC2Txt_MageCC;
		elseif(i == 4)then
			x = table.getn(LC2Txt_PaladinCC);
			arr = LC2Txt_PaladinCC;
		elseif(i == 5)then
			x = table.getn(LC2Txt_PriestCC);
			arr = LC2Txt_PriestCC;
		elseif(i == 6)then
			x = table.getn(LC2Txt_RogueCC);
			arr = LC2Txt_RogueCC;
		elseif(i == 7)then
			x = table.getn(LC2Txt_ShamanCC);
			arr = LC2Txt_ShamanCC;
		elseif(i == 8)then
			x = table.getn(LC2Txt_WarlockCC);
			arr = LC2Txt_WarlockCC;
		end
		
		
		local z=1;
		for k,v in pairs(arr) do
			--print(v[1],v[2]);
			local name, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange = GetSpellInfo(v[2]);
			Test1_Data[LC2Txt_CCClass[i]][z] = { ["name"] = name; ["icon"] = icon; ["ccid"] = v[1]; ["spellid"] = v[2] };
			z=z+1;
		end
	end

	level = level or 1;
  if (level == 1) then
     for key, subarray in pairs(Test1_Data) do
     	--LuckyCharms.Message(key);
     	local n = table.getn(CCMembers[key]);
     	--LuckyCharms.Message("DEBUG: Number Members: "..n);
     	if (n > 0) then
     			--LuckyCharms.Message("Person Found");
		       local info = UIDropDownMenu_CreateInfo();
		       --info.icon = "Interface\\Icons\\Ability_Druid_Maul";
		       info.hasArrow = true; -- creates submenu
		       info.notCheckable = true;
		       info.text = key;
		       info.value = {
		         ["Level1_Key"] = key;
		       };
		       UIDropDownMenu_AddButton(info, level);
     	end -- if n > 0
     end -- for key, subarray
  end -- if level 1
   
   if (level == 2) then
   	local Level1_Key = UIDROPDOWNMENU_MENU_VALUE["Level1_Key"];
   	local info = UIDropDownMenu_CreateInfo();
   	--LuckyCharms.Message(self:GetName());
   	--LuckyCharms.Message(Level1_Key);
   	for i, v in pairs(CCMembers) do
   		if(i == Level1_Key) then
   			local n = table.getn(CCMembers[i]);
   			for x=1,n do
   				--LuckyCharms.Message(tostring(v[x]));
   				--LuckyCharms.Message(table.getn(CCMembers[i][0]));
   				--info.icon = "Interface\\Icons\\Ability_Druid_Maul";
	      	info.hasArrow = true; -- creates submenu
	      	info.notCheckable = true;
	      	info.text = v[x];
	      	info.value = {
	        	["Level1_Key"] = Level1_Key;
	        	["Level2_Key"] = i;
	        	["Level2_Value"] = v[x];
	       	};
	       UIDropDownMenu_AddButton(info, level);
   			end --for i,n
   		end --if i == Level1_Key
   	end-- for i,v
   end -- if level 2

 
end

-- Hook the tooltips on UIDropDownMenu for CC Spell Display
hooksecurefunc("GameTooltip_AddNewbieTip", function(frame, normalText, r, g, b, newbieText, noNormalText)
    if (normalText == "LC2CCShowTooltip" and LC2_Settings[LC2Profile].tooltips == 1) then
        GameTooltip_SetDefaultAnchor(GameTooltip, frame)
        GameTooltip:ClearLines();
       
        GameTooltip:SetSpellByID(newbieText);
        GameTooltip:Show();
    end
end);



function LuckyCharms.ButtonTips(button)
	if(LC2_Settings[LC2Profile].tooltips == 1) then
		if(button == "LuckyCharm1")then
			GameTooltip:SetOwner(LuckyCharm1, "ANCHOR_RIGHT");
			GameTooltip:SetText(RAID_TARGET_1, nil, nil, nil, nil, 1);
			GameTooltip:AddLine(LC2TT_SETCC);
			GameTooltip:AddLine(LC2TT_CLEAR1CC);
		elseif(button == "LuckyCharm2")then
			GameTooltip:SetOwner(LuckyCharm2, "ANCHOR_RIGHT");
			GameTooltip:SetText(RAID_TARGET_2, nil, nil, nil, nil, 1);
			GameTooltip:AddLine(LC2TT_SETCC);
			GameTooltip:AddLine(LC2TT_CLEAR1CC);
		elseif(button == "LuckyCharm3")then
			GameTooltip:SetOwner(LuckyCharm3, "ANCHOR_RIGHT");
			GameTooltip:SetText(RAID_TARGET_3, nil, nil, nil, nil, 1);
			GameTooltip:AddLine(LC2TT_SETCC);
			GameTooltip:AddLine(LC2TT_CLEAR1CC);
		elseif(button == "LuckyCharm4")then
			GameTooltip:SetOwner(LuckyCharm4, "ANCHOR_RIGHT");
			GameTooltip:SetText(RAID_TARGET_4, nil, nil, nil, nil, 1);
			GameTooltip:AddLine(LC2TT_SETCC);
			GameTooltip:AddLine(LC2TT_CLEAR1CC);
		elseif(button == "LuckyCharm5")then
			GameTooltip:SetOwner(LuckyCharm5, "ANCHOR_RIGHT");
			GameTooltip:SetText(RAID_TARGET_5, nil, nil, nil, nil, 1);
			GameTooltip:AddLine(LC2TT_SETCC);
			GameTooltip:AddLine(LC2TT_CLEAR1CC);
		elseif(button == "LuckyCharm6")then
			GameTooltip:SetOwner(LuckyCharm6, "ANCHOR_RIGHT");
			GameTooltip:SetText(RAID_TARGET_6, nil, nil, nil, nil, 1);
			GameTooltip:AddLine(LC2TT_SETCC);
			GameTooltip:AddLine(LC2TT_CLEAR1CC);
		elseif(button == "LuckyCharm7")then
			GameTooltip:SetOwner(LuckyCharm7, "ANCHOR_RIGHT");
			GameTooltip:SetText(RAID_TARGET_7, nil, nil, nil, nil, 1);
			GameTooltip:AddLine(LC2TT_SETCC);
			GameTooltip:AddLine(LC2TT_CLEAR1CC);
		elseif(button == "LuckyCharm8")then
			GameTooltip:SetOwner(LuckyCharm8, "ANCHOR_RIGHT");
			GameTooltip:SetText(RAID_TARGET_8, nil, nil, nil, nil, 1);
			GameTooltip:AddLine(LC2TT_SETCC);
			GameTooltip:AddLine(LC2TT_CLEAR1CC);
		elseif(button == "LuckyCharm0")then
			GameTooltip:SetOwner(LuckyCharm0, "ANCHOR_RIGHT");
			GameTooltip:SetText(KEY_NUMLOCK_MAC, nil, nil, nil, nil, 1);
			GameTooltip:AddLine(LC2TT_CLEARCC);
		elseif(button == "LCRCButton")then
			GameTooltip:SetOwner(LCRCButton, "ANCHOR_RIGHT");
			GameTooltip:SetText(LC2TT_RC, nil, nil, nil, nil, 1);
		end
		GameTooltip:Show();
	end
end


function LuckyCharms.ToggleLock()
	if (LC2_Settings[LC2Profile].locked == 0 or LC2_Settings[LC2Profile].locked == nil) then
		LC2_Settings[LC2Profile].locked = 1;
		LCBDragButtonIcon:SetTexture(lockImage);
	else
		LC2_Settings[LC2Profile].locked = 0;
		LCBDragButtonIcon:SetTexture(unlockImage);
	end
end

function LuckyCharms.IsLocked()
	return LC2_Settings[LC2Profile].locked;
end

function LuckyCharms.RCAnchor(New_rcpos)
	LCReadyCheck:ClearAllPoints();
	if(New_rcpos == "left") then
		LCReadyCheck:SetPoint("LEFT","LuckyCharmAnchorBar","RIGHT",-2,0);
	elseif(New_rcpos == "right") then
		LCReadyCheck:SetPoint("RIGHT","LuckyCharmAnchorBar","LEFT",2,0);
	elseif(New_rcpos == "top") then
		LCReadyCheck:SetPoint("BOTTOMRIGHT","LuckyCharmAnchorBar","TOPRIGHT",0,-2);
	else
		LCReadyCheck:SetPoint("TOPLEFT","LuckyCharmAnchorBar","BOTTOMLEFT",0,2);
	end
	LC2_Settings[LC2Profile].rcpos = New_rcpos;
	LuckyCharms.Config.RCRadioPos(New_rcpos,1);
end
--End Anchor Creation

--Return Anchor Position
function LuckyCharms.RetBarPos(bpos)
	if(LC2_Settings[LC2Profile].ancpos == bpos) then
		return true;
	else
		return false;
	end
end
--End Return Anchor Position

function LuckyCharmsOnLoad(self)
	self:RegisterEvent('PLAYER_ENTERING_WORLD');
	self:RegisterEvent('ADDON_LOADED');
	self:RegisterEvent('GROUP_ROSTER_UPDATE');
	self:RegisterEvent('PLAYER_LOGIN');
	self:RegisterEvent('PLAYER_REGEN_ENABLED');
end

function LuckyCharms.DoUpdate()
	--LuckyCharms.Message("DEBUG: DoUpdate Called!");
	local hash = {};
	local result = {};
	--Remove duplicate wait events.
	for _,v in ipairs(LuckyCharms.waitEvents) do
   if (not hash[v]) then
       result[#result+1] = v -- you could print here instead of saving to result table if you wanted
       hash[v] = true
   end
	end
	--Process wait event list.
	for _,v in ipairs(result) do
		if (v == "frames") then
			LuckyCharms.UpdateFrames();
		elseif (v == "cc") then
			LuckyCharms.UpdateCCList();
		end
	end
	--Clear wait event list.
	hash = nil;
	result = nil;
	LuckyCharms.waitEvents = {};
end

function LuckyCharms.UpdateFrames()
	--LuckyCharms.Message("DEBUG: UpdateFrames Called!");
	--Charms Auto Show/Hide
	if (LC2_Settings[LC2Profile].barstatus=="auto") then
		--LuckyCharms_msg(GetNumGroupMembers());--Debug
		if(UnitInRaid("player"))then--In Raid
			if(UnitIsGroupAssistant("player") or UnitIsGroupLeader("player")) then
				if(not LuckyCharmBar:IsShown()) then
					LuckyCharmBar:Show();
				end
			else
				LuckyCharmBar:Hide();
			end
		elseif(GetNumGroupMembers() > 0) then --In Party
			if(not LuckyCharmBar:IsShown()) then
				LuckyCharmBar:Show();
			end
		else
			LuckyCharmBar:Hide();
		end
	end
	--Anchor Auto Show/Hide
	if (LC2_Settings[LC2Profile].ancstatus=="auto") then
		if(UnitInRaid("player"))then
			if(UnitIsGroupAssistant("player") or UnitIsGroupLeader("player")) then
				if(not LuckyCharmAnchorBar:IsShown()) then
					LuckyCharmAnchorBar:Show();
				end
			else
				LuckyCharmAnchorBar:Hide();
			end
		elseif(GetNumGroupMembers() > 0) then
			if(not LuckyCharmAnchorBar:IsShown()) then
				LuckyCharmAnchorBar:Show();
			end
		else
			LuckyCharmAnchorBar:Hide();
		end
	end
	--Ready Check Auto Show/Hide
	if (LC2_Settings[LC2Profile].rcstatus == "auto") then
		if(UnitInRaid("player"))then
			if(UnitIsGroupAssistant("player") or UnitIsGroupLeader("player")) then
				if(not LCReadyCheck:IsShown()) then
					LCReadyCheck:Show();
				end
			else
				LCReadyCheck:Hide();
			end
		elseif(GetNumGroupMembers() > 0) then
			if(UnitIsGroupLeader("player")) then
				if(not LCReadyCheck:IsShown()) then
					LCReadyCheck:Show();
				end
			else
				LCReadyCheck:Hide();
			end
		else
			LCReadyCheck:Hide();
		end
	end

end

function LuckyCharms.UpdateCCList()
	--LuckyCharms.Message("DEBUG: UpdateCCList Called!");
	--LuckyCharms_msg(GetNumGroupMembers());
	--Clear Enchanced CC Members Array
	CCMembers[LC2Txt_CCClass[1]] = {};
	CCMembers[LC2Txt_CCClass[2]] = {};
	CCMembers[LC2Txt_CCClass[3]] = {};
	CCMembers[LC2Txt_CCClass[4]] = {};
	CCMembers[LC2Txt_CCClass[5]] = {};
	CCMembers[LC2Txt_CCClass[6]] = {};
	CCMembers[LC2Txt_CCClass[7]] = {};
	CCMembers[LC2Txt_CCClass[8]] = {};
	--Check for Raid, otherwise check for party, otherwise nada.
	if(UnitInRaid("player"))then--In Raid
		if(GetNumGroupMembers() > 0) then
			for i=1,GetNumGroupMembers() do
				localizedClass, englishClass = UnitClass("raid"..i);
				name = UnitName("raid"..i);
				for x=1,table.getn(LC2Txt_CCClass) do
					if(englishClass == LC2Txt_CCClassEN[x])then
						table.insert(CCMembers[LC2Txt_CCClass[x]],name);
					end
				end--for x,table
			end--for i,GetNumRaidMembers
		end
	elseif(GetNumGroupMembers() > 0) then
		for i=0,GetNumGroupMembers() do
			if(i==0)then
				localizedClass, englishClass = UnitClass("player");
				name = UnitName("player");
			else
				localizedClass, englishClass = UnitClass("party"..i);
				name = UnitName("party"..i);
			end--if i==0
			for x=1,table.getn(LC2Txt_CCClass) do
				if(englishClass == LC2Txt_CCClassEN[x])then
					table.insert(CCMembers[LC2Txt_CCClass[x]],name);
				end
			end--for x,table
		end--for i,GetNumGroupMembers

	end
	--Testing
	--for y=1,table.getn(LC2Txt_CCClass) do
	--for x=1,table.getn(CCMembers[LC2Txt_CCClass[y]]) do
	--LuckyCharms.Message(LC2Txt_CCClass[y].." "..CCMembers[LC2Txt_CCClass[y]][x]);
	--end
	--end
end

function LuckyCharmsOnEvent(self,event,...)
	--LuckyCharms.Message(event.." Called!");--Debug
	if(event == "ADDON_LOADED") then
		local arg1 = ...;
		if(arg1 == LC2NAME) then
			--Initialize Enchanced CC Members Array
			CCMembers[LC2Txt_CCClass[1]] = {};
			CCMembers[LC2Txt_CCClass[2]] = {};
			CCMembers[LC2Txt_CCClass[3]] = {};
			CCMembers[LC2Txt_CCClass[4]] = {};
			CCMembers[LC2Txt_CCClass[5]] = {};
			CCMembers[LC2Txt_CCClass[6]] = {};
			CCMembers[LC2Txt_CCClass[7]] = {};
			CCMembers[LC2Txt_CCClass[8]] = {};
			
			--Check for settings array.  Used for Profiles.
			if( not LC2_Settings ) then
				LC2_Settings = {};
			end
			--Check for Profile Settings
			if( not LC2_Settings[LC2Profile]) then
				LC2_Settings[LC2Profile] = {};
			end
			--Check for Settings Verison.  Use for upgrades
			if(not LC2_Settings[LC2Profile].SettVer) then
				--LuckyCharms.Message("Setting Ver Not Found");--Debug
				PrevSettVer = "";
				LC2_Settings[LC2Profile].SettVer = LC2SettVer;
			else
				--LuckyCharms.Message("Setting Ver Found.");--Debug
				PrevSettVer = LC2_Settings[LC2Profile].SettVer;
			end
			--Check for Settings, otherwise set defaults.
			if(not LC2_Settings[LC2Profile].barstatus) then
				LC2_Settings[LC2Profile].barstatus="auto"; --Charmbar display status
			end
			if(not LC2_Settings[LC2Profile].barscale) then
				LC2_Settings[LC2Profile].barscale=1.0; --LC2 scale
			end
			if(not LC2_Settings[LC2Profile].tooltips) then
				LC2_Settings[LC2Profile].tooltips=1; --Show Tooltips
			end
			if(not LC2_Settings[LC2Profile].ancstatus) then
				LC2_Settings[LC2Profile].ancstatus="show"; --Anchor display status
			end
			if(not LC2_Settings[LC2Profile].ancpos) then
				LC2_Settings[LC2Profile].ancpos="left"; --Anchor Position, relative to charmbar
			end
			if(not LC2_Settings[LC2Profile].alpha) then
				LC2_Settings[LC2Profile].alpha=1; --LC2 Alpha
			end
			if(not LC2_Settings[LC2Profile].rcpos) then
				LC2_Settings[LC2Profile].rcpos="top"; --Ready Check Button Position, Relative to Anchor
			end
			if(not LC2_Settings[LC2Profile].rcstatus) then
				LC2_Settings[LC2Profile].rcstatus="auto"; --Ready Check Button Display Status
			end
			if(not LC2_Settings[LC2Profile].kopos) then
				LC2_Settings[LC2Profile].kopos="top"; --Kill Order Position, Relative to CharmBar
			end
			if(not LC2_Settings[LC2Profile].kostatus) then
				LC2_Settings[LC2Profile].kostatus="auto"; --Display Status of the Kill Order Bar
			end
			if(not LC2_Settings[LC2Profile].komode) then
				LC2_Settings[LC2Profile].komode="icons"; --Kill Order Print Mode: text,icons
			end
			if(not LC2_Settings[LC2Profile].korw) then
				LC2_Settings[LC2Profile].korw=1; --Enable Kill Order Print to Raid Warning.
			end
			if(not LC2_Settings[LC2Profile].kopr) then
				LC2_Settings[LC2Profile].kopr=1; --Enable Kill Order Print to Party/Raid.
			end
			if(not LC2_Settings[LC2Profile].koctp) then
				LC2_Settings[LC2Profile].koctp="top";
			end
			if(not LC2_Settings[LC2Profile].korder) then
				LC2_Settings[LC2Profile].korder={8,7,6,1,2,3,4,5}; --Kill Order Array
			end
			if(not LC2_Settings[LC2Profile].charmcc) then
				--Charm CC Assignment Array
				LC2_Settings[LC2Profile].charmcc={};
				for i=1, 8 do
						LC2_Settings[LC2Profile].charmcc[i] = { ["name"] = ""; ["icon"] = ""; };
				end
			end
			if(not LC2_Settings[LC2Profile].kocc) then
				LC2_Settings[LC2Profile].kocc=1; --Enable CC Print to selected frames.
			end
			if(not LC2_Settings[LC2Profile].koprint) then
				LC2_Settings[LC2Profile].koprint=1; --Enable CC Print to selected frames.
			end
			if(not LC2_Settings[LC2Profile].charmStatus) then
				LC2_Settings[LC2Profile].charmStatus={1,1,1,1,1,1,1,1}; --Charm Status Array 0-Disabled,1-Enabled
			end
			if(not LC2_Settings[LC2Profile].locked) then
				LC2_Settings[LC2Profile].locked=0; --Lock Anchor
			end
			
			LuckyCharms.Config.Upgrade();

			--Setup UI
			LuckyCharms.Config.ModScale(LC2_Settings[LC2Profile].barscale);
			LuckyCharms.Config.InitSlider(LuckyCharmConfig_Slider1);
			LuckyCharms.Config.InitAlphaSlider(LuckyCharmConfig_SliderAlpha);
			--Main Charm Bar
			if (LC2_Settings[LC2Profile].barstatus == "show") then
				LuckyCharmBar:Show();
			else
				LuckyCharmBar:Hide();
			end
			-- Anchor Bar
			if(LC2_Settings[LC2Profile].ancstatus == "show") then
				LuckyCharmAnchorBar:Show();
			else
				LuckyCharmAnchorBar:Hide();
			end
			--Ready Check Button
			if(LC2_Settings[LC2Profile].rcstatus == "show") then
				LCReadyCheck:Show();
			else
				LCReadyCheck:Hide();
			end
			
			LuckyCharms.Config.ModAlpha(LC2_Settings[LC2Profile].alpha);
			LuckyCharms.RCAnchor(LC2_Settings[LC2Profile].rcpos);
			LuckyCharms.Config.Radio(LC2_Settings[LC2Profile].barstatus,1);
			LuckyCharms.Config.AncRadio(LC2_Settings[LC2Profile].ancstatus,1);
			LuckyCharms.Config.AncRadioPos(LC2_Settings[LC2Profile].ancpos,1);
			LuckyCharms.Config.TTRadio(LC2_Settings[LC2Profile].tooltips,1);
			LuckyCharms.Config.RCRadio(LC2_Settings[LC2Profile].rcstatus,1);
			LuckyCharms.Config.RCRadioPos(LC2_Settings[LC2Profile].rcpos,1);
			
			if (LC2_Settings[LC2Profile].locked == 0) then
				LCBDragButtonIcon:SetTexture(unlockImage);
			else
				LCBDragButtonIcon:SetTexture(lockImage);
			end
			
			LCRCButton:SetText(READY_CHECKABBRV);
			LuckyCharms.Config.InitConfigDropDowns();
			LuckyCharms.DrawCharms();
			
			
			
			if(not LBF)then
				--LuckyCharms.Message("Setting BG, Border, TexCoords");--Debug
		  	--local f = _G["LuckyCharmBar"];
			
		  	--LuckyCharmBar:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		  	--	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile=true,tileSize=10,edgeSize=16,
		  	--	insets = {left=4, right=4, top=4, bottom=4}
		  	--});
		  	
		  	--LuckyCharmAnchorBar:SetBackdrop({
		  	--	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		  	--	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile=true,tileSize=10,edgeSize=16,
		  	--	insets = {left=4, right=4, top=4, bottom=4}
		  	--});
			end
			
			LuckyCharms.SetTexCoords();
			
			LuckyCharms.Message(LC2Version.." "..LC2TXT_LOADED);
		end
	end
	
	--Set Auto Features
	if(event == "PLAYER_ENTERING_WORLD" or event == "GROUP_ROSTER_UPDATE")then
		table.insert(LuckyCharms.waitEvents,"frames");
		
		if InCombatLockdown() then
			LuckyCharms.waiting = true;
			return;
		end
		
		LuckyCharms.DoUpdate();
	end

	--Get CC Chars List
	if(event == "GROUP_ROSTER_UPDATE")then
		table.insert(LuckyCharms.waitEvents,"cc");
		
		if InCombatLockdown() then
			LuckyCharms.waiting = true;
			return;
		end
		
		LuckyCharms.DoUpdate();
	end
	
	if(event == "PLAYER_REGEN_ENABLED")then
		--LuckyCharms.Message("DEBUG: Player Left Combat!");
		if LuckyCharms.waiting then
			LuckyCharms.waiting = false;
			LuckyCharms.DoUpdate();
		end
	end
end

function LuckyCharms.SetTexCoords()
	for i=0,8 do
		local f = _G["LuckyCharm"..i.."Icon"];
		if(f)then
			--LuckyCharms.Message(f:GetName().." Found");
			if(i == 1)then
				f:SetTexCoord(0,0.25,0,0.25);
			elseif(i == 2)then
				f:SetTexCoord(0.25,0.5,0,0.25);
			elseif(i == 3)then
				f:SetTexCoord(0.5,0.75,0,0.25);
			elseif(i == 4)then
				f:SetTexCoord(0.75,1,0,0.25);
			elseif(i == 5)then
				f:SetTexCoord(0,0.25,0.25,0.5);
			elseif(i == 6)then
				f:SetTexCoord(0.25,0.5,0.25,0.5);
			elseif(i == 7)then
				f:SetTexCoord(0.5,0.75,0.25,0.5);
			elseif(i == 8)then
				f:SetTexCoord(0.75,1,0.25,0.5);
			end
		end
	end
end

--Draw the charms and background frame
function LuckyCharms.DrawCharms()
	local bpos = LC2_Settings[LC2Profile].ancpos;
	local c = 0;
	local space = 0;

	--Clear Points
	LuckyCharmBar:ClearAllPoints();
	
	for i=0,8 do
		local f = _G["LuckyCharm"..i];
		if(f)then
			--LuckyCharms.Message(f:GetName().." Found");
			f:Hide();
			f:ClearAllPoints();
		end
	end
	
	--Draw Charms
	for i=1,8 do
		local charmNum = LC2_Settings[LC2Profile].korder[i];
		if(LC2_Settings[LC2Profile].charmStatus[charmNum] == 1) then
			local b = _G["LuckyCharm"..charmNum];
			if(not b) then
				b = CreateFrame("Button","LuckyCharm"..charmNum,LuckyCharmBar,"CharmBtnVirtual");
				--b:RegisterForClicks("AnyUp");
				b:SetScript("OnClick", function (self, button, down)
				 LuckyCharms.OnCharmClick(button,self);
				end);	
				local t = _G["LuckyCharm"..charmNum.."Icon"];
				t:SetTexture("Interface\\TARGETINGFRAME\\UI-RaidTargetingIcons");
			end
					
			if(c == 0)then
				space = 2;
			else
				space = c * 40 + 2;
			end
			
			if (bpos == "left" or bpos == "right") then
				if(bpos == "left") then
					b:SetPoint("LEFT",LuckyCharmBar,"LEFT",space,-1);
				else
					b:SetPoint("RIGHT",LuckyCharmBar,"RIGHT",-space,-1);
				end
			elseif (bpos == "top" or bpos == "bottom") then
				if (bpos == "top") then
					b:SetPoint("BOTTOM",LuckyCharmBar,"BOTTOM",0,space);
				else
					b:SetPoint("TOP",LuckyCharmBar,"TOP",0,-space);
				end
			end
			
			b:Show();
			c = c+1;
		end
	end
	
	--Draw Clear Button
	if(c == 0)then
		space = 2;
	else
		space = c * 40 + 2;
	end
	b = _G["LuckyCharm0"];
	if(not b) then
		b = CreateFrame("Button","LuckyCharm0",LuckyCharmBar,"CharmBtnVirtual");
		b:SetScript("OnClick", function (self, button, down)
				 LuckyCharms.OnCharmClick(button,self);
				end);	
	end
	t = _G["LuckyCharm0Icon"];
	t:SetTexture("Interface\\BUTTONS\\UI-GroupLoot-Pass-Up");
	--End Draw Clear Button		
	
	if (bpos == "left" or bpos == "right") then
		if(bpos == "left") then
			b:SetPoint("LEFT",LuckyCharmBar,"LEFT",space,-1);
		else
			b:SetPoint("RIGHT",LuckyCharmBar,"RIGHT",-space,-1);
		end
	elseif (bpos == "top" or bpos == "bottom") then
		if (bpos == "top") then
			b:SetPoint("BOTTOM",LuckyCharmBar,"BOTTOM",0,space);
		else
			b:SetPoint("TOP",LuckyCharmBar,"TOP",0,-space);
		end
	end
	b:Show();
	
	--Bar Positions
	if (bpos == "left" or bpos == "right") then
		LuckyCharmBar:SetWidth(space+40); 
		LuckyCharmBar:SetHeight(47);
		if(bpos == "left") then
			LuckyCharmBar:SetPoint("LEFT","LuckyCharmAnchorBar","RIGHT",-2,0);
		else
			LuckyCharmBar:SetPoint("RIGHT","LuckyCharmAnchorBar","LEFT",2,0);
		end
		
	elseif (bpos == "top" or bpos == "bottom") then
		LuckyCharmBar:SetWidth(47); 
		LuckyCharmBar:SetHeight(space+40);
		if (bpos == "top") then
			LuckyCharmBar:SetPoint("BOTTOM","LuckyCharmAnchorBar","TOP",0,0);
		else
			LuckyCharmBar:SetPoint("TOP","LuckyCharmAnchorBar","BOTTOM",0,2);
		end
		
	end
	--LuckyCharms.Config.AncRadioPos(bpos,1);
	
end

