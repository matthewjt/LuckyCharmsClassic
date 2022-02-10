--[[
LuckyCharmsClassic r41
Last Changed By: neer
Last Changed: 2012-10-01T18:23:27Z
]]

--Locals
local LC2_Realm = GetRealmName(); --Get Realm for Profile.
local LC2_Char = UnitName("player"); --Get char name for profile.
local LC2Profile = LC2_Realm.." - "..LC2_Char;

LuckyCharms.Config = {};

function LuckyCharms.Config.AncRadio(status,startup)
	if(status == "show") then
		LuckyCharmConfig_AncRadioShow:SetChecked(1);
		LuckyCharmConfig_AncRadioHide:SetChecked(nil);
		LuckyCharmConfig_AncRadioAuto:SetChecked(nil);
	elseif(status == "hide") then
		LuckyCharmConfig_AncRadioShow:SetChecked(nil);
		LuckyCharmConfig_AncRadioHide:SetChecked(1);
		LuckyCharmConfig_AncRadioAuto:SetChecked(nil);
	else
		LuckyCharmConfig_AncRadioShow:SetChecked(nil);
		LuckyCharmConfig_AncRadioHide:SetChecked(nil);
		LuckyCharmConfig_AncRadioAuto:SetChecked(1);
	end
	if(startup == 0) then
		if(status == "show") then
			LuckyCharmAnchorBar:Show();
		elseif(status == "auto") then
			if(UnitIsGroupAssistant("player") or UnitIsGroupLeader("player")) then
				if(LuckyCharmAnchorBar:IsShown()~=1) then
					LuckyCharmAnchorBar:Show();
				end
			else
				if(LuckyCharmAnchorBar:IsShown()==1) then
					LuckyCharmAnchorBar:Hide();
				end
			end
		else
			LuckyCharmAnchorBar:Hide();
		end
		LC2_Settings[LC2Profile].ancstatus = status;
	end
end

function LuckyCharms.Config.AncRadioPos(value,startup)
	if (value == "left") then
		LuckyCharmConfig_AncRadioLeft:SetChecked(1);
		LuckyCharmConfig_AncRadioRight:SetChecked(nil);
		LuckyCharmConfig_AncRadioTop:SetChecked(nil);
		LuckyCharmConfig_AncRadioBottom:SetChecked(nil);
	elseif (value=="right") then
		LuckyCharmConfig_AncRadioLeft:SetChecked(nil);
		LuckyCharmConfig_AncRadioRight:SetChecked(1);
		LuckyCharmConfig_AncRadioTop:SetChecked(nil);
		LuckyCharmConfig_AncRadioBottom:SetChecked(nil);
	elseif (value=="top") then
		LuckyCharmConfig_AncRadioLeft:SetChecked(nil);
		LuckyCharmConfig_AncRadioRight:SetChecked(nil);
		LuckyCharmConfig_AncRadioTop:SetChecked(1);
		LuckyCharmConfig_AncRadioBottom:SetChecked(nil);
	else
		LuckyCharmConfig_AncRadioLeft:SetChecked(nil);
		LuckyCharmConfig_AncRadioRight:SetChecked(nil);
		LuckyCharmConfig_AncRadioTop:SetChecked(nil);
		LuckyCharmConfig_AncRadioBottom:SetChecked(1);
	end
	if(startup == 0) then
		LC2_Settings[LC2Profile].ancpos = value;
	end
	LuckyCharms.DrawCharms();
	
end

--Ready Check Options
function LuckyCharms.Config.RCRadio(status,startup)
	if(status == "show") then
		LuckyCharmConfigRC_RCRadioShow:SetChecked(1);
		LuckyCharmConfigRC_RCRadioHide:SetChecked(nil);
		LuckyCharmConfigRC_RCRadioAuto:SetChecked(nil);
	elseif(status == "hide") then
		LuckyCharmConfigRC_RCRadioShow:SetChecked(nil);
		LuckyCharmConfigRC_RCRadioHide:SetChecked(1);
		LuckyCharmConfigRC_RCRadioAuto:SetChecked(nil);
	else
		LuckyCharmConfigRC_RCRadioShow:SetChecked(nil);
		LuckyCharmConfigRC_RCRadioHide:SetChecked(nil);
		LuckyCharmConfigRC_RCRadioAuto:SetChecked(1);
	end
	if(startup == 0)then
		if(status == "show") then
			LCReadyCheck:Show();
		elseif(status == "auto") then
			if(UnitIsGroupAssistant("player") or UnitIsGroupLeader("player")) then
				if(LCReadyCheck:IsShown()~=1) then
					LCReadyCheck:Show();
				end
			else
				if(LCReadyCheck:IsShown()==1) then
					LCReadyCheck:Hide();
				end
			end
		else
			LCReadyCheck:Hide();
		end
		LC2_Settings[LC2Profile].rcstatus = status;
	end
end

function LuckyCharms.Config.RCRadioPos(value,startup)
	if (value == "left") then
		LuckyCharmConfigRC_RCRadioLeft:SetChecked(1);
		LuckyCharmConfigRC_RCRadioRight:SetChecked(nil);
		LuckyCharmConfigRC_RCRadioTop:SetChecked(nil);
		LuckyCharmConfigRC_RCRadioBottom:SetChecked(nil);
	elseif (value=="right") then
		LuckyCharmConfigRC_RCRadioLeft:SetChecked(nil);
		LuckyCharmConfigRC_RCRadioRight:SetChecked(1);
		LuckyCharmConfigRC_RCRadioTop:SetChecked(nil);
		LuckyCharmConfigRC_RCRadioBottom:SetChecked(nil);
	elseif (value=="top") then
		LuckyCharmConfigRC_RCRadioLeft:SetChecked(nil);
		LuckyCharmConfigRC_RCRadioRight:SetChecked(nil);
		LuckyCharmConfigRC_RCRadioTop:SetChecked(1);
		LuckyCharmConfigRC_RCRadioBottom:SetChecked(nil);
	else
		LuckyCharmConfigRC_RCRadioLeft:SetChecked(nil);
		LuckyCharmConfigRC_RCRadioRight:SetChecked(nil);
		LuckyCharmConfigRC_RCRadioTop:SetChecked(nil);
		LuckyCharmConfigRC_RCRadioBottom:SetChecked(1);
	end
	if(startup == 0)then
		LuckyCharms.RCAnchor(value);
		LC2_Settings[LC2Profile].rcpos = value;
	end
end
--end Ready Check Options

function LuckyCharms.Config.TTRadio(tips,startup)
	if(tips == 1) then
		LuckyCharmConfig_RadioTTEnable:SetChecked(1);
		LuckyCharmConfig_RadioTTDisable:SetChecked(nil);
	elseif(tips == 0) then
		LuckyCharmConfig_RadioTTEnable:SetChecked(nil);
		LuckyCharmConfig_RadioTTDisable:SetChecked(1);
	end
	if(startup == 0) then
		LC2_Settings[LC2Profile].tooltips = tips;
	end
end
--End Configuration Window

--Ready Check Configuration
function LuckyCharms.Config.RCOnLoad(panel)
		panel.name = READY_CHECK.." "..LC2TXT_CONF;
		panel.parent = "LuckyCharmsClassic"; 
		panel.default = function(self)
			LuckyCharms.Config.ResetRC();
		end  
		InterfaceOptions_AddCategory(panel); 
		
		LuckyCharmConfigRCTitle:SetText(LC2NAME.." "..LC2Version);
		LuckyCharmConfigRCSubTitle:SetText("|cFFFFFFFF"..READY_CHECK.." "..LC2TXT_CONF.."|r");
		--Ready Check button
		LuckyCharmConfigRCDisplay:SetText(READY_CHECKB.." "..DISPLAY..":");
		LuckyCharmConfigRCDisplayDefault:SetText(CHAT_DEFAULT..": |cFF4DBD33"..LC2TXT_AUTO.."|r");
		LuckyCharmConfigRCDisplayPos:SetText(READY_CHECKB.." "..LC2TXT_POSITION..":");
		LuckyCharmConfigRCDisplayPosDefault:SetText(CHAT_DEFAULT..": |cFF4DBD33"..LC2TXT_TOP.."|r");
		LuckyCharmConfigRC_RCRadioShowText:SetText("|cFFFFFFFF"..LC2TXT_SHOWN.."|r");
		LuckyCharmConfigRC_RCRadioHideText:SetText("|cFFFFFFFF"..LC2TXT_HIDDEN.."|r");
		LuckyCharmConfigRC_RCRadioAutoText:SetText("|cFFFFFFFF"..LC2TXT_AUTO.."|r");
		LuckyCharmConfigRC_RCRadioLeftText:SetText("|cFFFFFFFF"..LC2TXT_LEFT.."|r");
		LuckyCharmConfigRC_RCRadioRightText:SetText("|cFFFFFFFF"..LC2TXT_RIGHT.."|r");
		LuckyCharmConfigRC_RCRadioTopText:SetText("|cFFFFFFFF"..LC2TXT_TOP.."|r");
		LuckyCharmConfigRC_RCRadioBottomText:SetText("|cFFFFFFFF"..LC2TXT_BOTTOM.."|r");
end
--end Radio Check Configuration

function LuckyCharms.Config.InitSlider(slider)
	slider:SetValue(LC2_Settings[LC2Profile].barscale);
end

function LuckyCharms.Config.InitAlphaSlider(slider)
	slider:SetValue(LC2_Settings[LC2Profile].alpha);
end

function LuckyCharms.Config.SliderChange(slider)
	local sl = _G[slider];
	local newVal = string.format("%.1f",sl:GetValue());
	_G[slider .. "Text"]:SetText(newVal);
	LuckyCharms.Config.ModScale(newVal);
end

function LuckyCharms.Config.SliderAlphaChange(slider)
	local sl = _G[slider];
	local newVal = string.format("%.1f",sl:GetValue());
	_G[slider .. "Text"]:SetText(newVal);
	LuckyCharms.Config.ModAlpha(newVal);
end

function LuckyCharms.Config.Radio(status,startup)
	if(status == "show") then
		LuckyCharmConfig_RadioShow:SetChecked(1);
		LuckyCharmConfig_RadioHide:SetChecked(nil);
		LuckyCharmConfig_RadioAuto:SetChecked(nil);
	elseif(status == "hide") then
		LuckyCharmConfig_RadioShow:SetChecked(nil);
		LuckyCharmConfig_RadioHide:SetChecked(1);
		LuckyCharmConfig_RadioAuto:SetChecked(nil);
	else
		LuckyCharmConfig_RadioShow:SetChecked(nil);
		LuckyCharmConfig_RadioHide:SetChecked(nil);
		LuckyCharmConfig_RadioAuto:SetChecked(1);
	end
	if(startup == 0) then
		if(status == "show") then
			LuckyCharmBar:Show();
		elseif(status == "auto") then
			if(UnitIsGroupAssistant("player") or UnitIsGroupLeader("player")) then
				if(LuckyCharmBar:IsShown()~=1) then
					LuckyCharmBar:Show();
				end
			else
				if(LuckyCharmBar:IsShown()==1) then
					LuckyCharmBar:Hide();
				end
			end
		else
			LuckyCharmBar:Hide();
		end
		LC2_Settings[LC2Profile].barstatus = status;
	end
end

--Start of Configuration Window
function LuckyCharms.Config.OnLoad(panel)
	panel.name = "LuckyCharmsClassic"; 
	panel.default = function(self)
		LuckyCharms.Config.ResetMain();
	end
	InterfaceOptions_AddCategory(panel); 

	LuckyCharmConfigTitle:SetText(LC2NAME.." "..LC2Version);
	LuckyCharmConfigSubTitle:SetText("|cFFFFFFFF"..LC2TXT_GENERAL.." "..LC2TXT_CONF.."|r");
	LuckyCharmConfigScale:SetText(LC2TXT_CBAR.." "..LC2TXT_SCALE..":\n"..CHAT_DEFAULT..": |cFF4DBD331.0|r");
	LuckyCharmConfigAlpha:SetText(LC2TXT_CBAR.." "..OPACITY..":\n"..CHAT_DEFAULT..": |cFF4DBD331.0|r");
	LuckyCharmConfigDisplay:SetText(LC2TXT_CBAR.." "..DISPLAY..":\n"..CHAT_DEFAULT..": |cFF4DBD33"..LC2TXT_AUTO.."|r");
	LuckyCharmConfigToolTips:SetText(LC2TXT_CBAR.." "..LC2TXT_TOOLTIPS..":\n"..CHAT_DEFAULT..": |cFF4DBD33"..LC2TXT_ENABLED.."|r");
	
	LuckyCharmConfig_RadioShowText:SetText("|cFFFFFFFF"..LC2TXT_SHOWN.."|r");
	LuckyCharmConfig_RadioHideText:SetText("|cFFFFFFFF"..LC2TXT_HIDDEN.."|r");
	LuckyCharmConfig_RadioAutoText:SetText("|cFFFFFFFF"..LC2TXT_AUTO.."|r");
	--Tooltips
	LuckyCharmConfig_RadioTTEnableText:SetText("|cFFFFFFFF"..LC2TXT_ENABLED.."|r");
	LuckyCharmConfig_RadioTTDisableText:SetText("|cFFFFFFFF"..ADDON_DISABLED.."|r");
	--Anchor Bar
	LuckyCharmConfigAncDisplay:SetText(LC2TXT_ANCHOR.." "..DISPLAY..":\n"..CHAT_DEFAULT..": |cFF4DBD33"..LC2TXT_SHOWN.."|r");
	--LuckyCharmConfigAncDisplayDefault:SetText(CHAT_DEFAULT..": "..LC2TXT_SHOWN);
	LuckyCharmConfig_AncRadioShowText:SetText("|cFFFFFFFF"..LC2TXT_SHOWN.."|r");
	LuckyCharmConfig_AncRadioHideText:SetText("|cFFFFFFFF"..LC2TXT_HIDDEN.."|r");
	LuckyCharmConfig_AncRadioAutoText:SetText("|cFFFFFFFF"..LC2TXT_AUTO.."|r");
	LuckyCharmConfigDisplayPos:SetText(LC2TXT_CBAR.." "..LC2TXT_POSITION..":\n"..CHAT_DEFAULT..": |cFF4DBD33"..LC2TXT_LEFT.."|r");
	--LuckyCharmConfigDisplayPosDefault:SetText(CHAT_DEFAULT..": "..LC2TXT_LEFT.."|r");
	LuckyCharmConfig_AncRadioLeftText:SetText("|cFFFFFFFF"..LC2TXT_LEFT.."|r");
	LuckyCharmConfig_AncRadioRightText:SetText("|cFFFFFFFF"..LC2TXT_RIGHT.."|r");
	LuckyCharmConfig_AncRadioTopText:SetText("|cFFFFFFFF"..LC2TXT_TOP.."|r");
	LuckyCharmConfig_AncRadioBottomText:SetText("|cFFFFFFFF"..LC2TXT_BOTTOM.."|r");
	LuckyCharmConfigProfile:SetText(LC2TXT_PROFILE..":");
end

--Initialize Profile Drop Down Menu
function LuckyCharms.Config.ConfProfileDD_Init(self)
	local info = UIDropDownMenu_CreateInfo();
	for key, subarray in pairs(LC2_Settings) do
    info.text = key;
    info.value = key;
    info.checked = nil;
    info.owner = self:GetParent();
		info.icon = nil;
    info.func = function() LuckyCharms.Config.ConfProfileDD_OnClick(self,key) end;
    UIDropDownMenu_AddButton(info, 1);
	end -- for key, subarray
end
--Profile Drop Down On Click.  Copy to current character.
function LuckyCharms.Config.ConfProfileDD_OnClick(self,arg1)
	LuckyCharms.Config.deepCopy(LC2_Settings[arg1],LC2_Settings[LC2Profile]);
	LuckyCharms.Config.Reload(arg1);
end
--Copy tables, taken from Gatherer Addon
function LuckyCharms.Config.deepCopy( source, dest )
	for k, v in pairs(source) do
		if ( type(v) == "table" ) then
			if not ( type(dest[k]) == "table" ) then
				dest[k] = {}
			end
			LuckyCharms.Config.deepCopy(v, dest[k])
		else
			dest[k] = v
		end
	end
end

--Used for loading exsisting profiles
function LuckyCharms.Config.Reload(profile)
	--Setup UI
	LuckyCharms.Config.ModScale(LC2_Settings[LC2Profile].barscale);
	LuckyCharms.Config.InitSlider(LuckyCharmConfig_Slider1);
	LuckyCharms.Config.InitAlphaSlider(LuckyCharmConfig_SliderAlpha);
	if (LC2_Settings[LC2Profile].barstatus == "show") then
		LuckyCharmBar:Show();
	else
				LuckyCharmBar:Hide();
			end
			if(LC2_Settings[LC2Profile].ancstatus == "show") then
				LuckyCharmAnchorBar:Show();
			else
				LuckyCharmAnchorBar:Hide();
			end
			if(LC2_Settings[LC2Profile].rcstatus == "show") then
				LCReadyCheck:Show();
			else
				LCReadyCheck:Hide();
			end

			LuckyCharms.Config.ModAlpha(LC2_Settings[LC2Profile].alpha);
			--LuckyCharms.BarAnchor(LC2_Settings[LC2Profile].ancpos);
			LuckyCharms.RCAnchor(LC2_Settings[LC2Profile].rcpos);
			LuckyCharms.Config.Radio(LC2_Settings[LC2Profile].barstatus,1);
			LuckyCharms.Config.AncRadio(LC2_Settings[LC2Profile].ancstatus,1);
			LuckyCharms.Config.AncRadioPos(LC2_Settings[LC2Profile].ancpos,1);
			LuckyCharms.Config.TTRadio(LC2_Settings[LC2Profile].tooltips,1);
			LuckyCharms.Config.RCRadio(LC2_Settings[LC2Profile].rcstatus,1);
			LuckyCharms.Config.RCRadioPos(LC2_Settings[LC2Profile].rcpos,1);
			LuckyCharms.Flares.Config.WMRadio(LC2_Settings[LC2Profile].wmbarstatus,1);

			
			if (LC2_Settings[LC2Profile].locked == 0) then
				LCBDragButtonIcon:SetTexture(unlockImage);
			else
				LCBDragButtonIcon:SetTexture(lockImage);
			end
			
			LuckyCharms.DrawCharms();
			
			LCRCButton:SetText(READY_CHECKABBRV);
			LuckyCharms.Config.InitConfigDropDowns();
			LuckyCharms.UpdateCCAssignments();
			LuckyCharms.InitCCButtons();
			LuckyCharms.Message(LC2TXT_PROFILECOPIED..": "..profile);
end

function LuckyCharms.Config.InitConfigDropDowns()
	ConfProfileDD = CreateFrame("Frame", "ConfProfileDD", LuckyCharmConfig, "UIDropDownMenuTemplate"); 
	ConfProfileDD:SetPoint("LEFT","LuckyCharmConfigProfile","RIGHT",-15,-4);
	UIDropDownMenu_SetWidth(ConfProfileDD, 200);
	UIDropDownMenu_Initialize(ConfProfileDD, LuckyCharms.Config.ConfProfileDD_Init);
	UIDropDownMenu_SetSelectedValue(ConfProfileDD, LC2Profile);
end

function LuckyCharms.Config.Upgrade()
		--[[
		LuckyCharms.Message("Enter Upgrade");--Debug
		LuckyCharms.Message("Prev"..PrevSettVer);--Debug
		LuckyCharms.Message("Curr"..LC2SettVer);--Debug
		]]
	if(PrevSettVer ~= LC2SettVer)then
		LuckyCharms.Message(LC2TXT_UPGRADESETTINGS..": "..LC2SettVer);
		--Upgrade Settings
		LC2_Settings[LC2Profile].SettVer = LC2SettVer;
		PrevSettVer = LC2SettVer;
		--Upgrade charmcc
		LC2_Settings[LC2Profile].charmcc={};
		for i=1, 8 do
				LC2_Settings[LC2Profile].charmcc[i] = { ["name"] = ""; ["icon"] = ""; };
		end
		--Upgrade ButtonFacade Settings
		LC2_Settings[LC2Profile].BtnFacade = {};
		LC2_Settings[LC2Profile].BtnFacade.dbinit = 0;
	end
end

function LuckyCharms.Config.ResetMain()
	LuckyCharmAnchor:ClearAllPoints();
	LuckyCharmAnchor:SetPoint("TOPLEFT",100,-100);
	LuckyCharms.Config.Radio("auto",0);
	LuckyCharms.Flares.Config.WMRadio("auto",0);
	LuckyCharms.Config.TTRadio(1,0);
	LuckyCharms.Config.AncRadio("show",0);
	LuckyCharms.Config.AncRadioPos("left",0);
	LuckyCharms.Config.ModScale(1.0);
	LuckyCharms.Config.ModAlpha(1.0);
	LuckyCharms.Config.ResetRC();
	LC2_Settings[LC2Profile].locked = 0;
	LCBDragButtonIcon:SetTexture(unlockImage);
	LuckyCharms.DrawCharms();
	LuckyCharms.Message(LC2M_DEFAULTS);
end

function LuckyCharms.Config.ResetRC()
	LuckyCharms.Config.RCRadioPos("top",0);
	LuckyCharms.Config.RCRadio("auto",0);
end

function LuckyCharms.Config.ModAlpha(value)
	LC2_Settings[LC2Profile].alpha = value;
	LuckyCharmAnchor:SetAlpha(value);
	LuckyCharmConfig_SliderAlpha:SetValue(value);
end

function LuckyCharms.Config.ModScale(value)
	LC2_Settings[LC2Profile].barscale = value;
	LuckyCharmAnchor:SetScale(value);
	_G["LuckyCharmConfig_Slider1"]:SetValue(value);
end
