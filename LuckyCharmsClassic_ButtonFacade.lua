--[[
LuckyCharmsClassic v7.1.0
Last Changed By: neer
Last Changed: 11/29/2016 12:39:26 PM
]]

--LuckyCharms.Message(IsAddOnLoaded("Masque"))--DEBUG
if not IsAddOnLoaded("Masque") then return end
 
local LC2_Realm = GetRealmName(); --Get Realm for Profile.
local LC2_Char = UnitName("player"); --Get char name for profile.
local LC2Profile = LC2_Realm.." - "..LC2_Char;
local BFLC2 = CreateFrame("Frame")
local self = BFLC2
BFLC2:SetScript("OnEvent", function(this, event, ...)
	this[event](this, ...)
end)

local LBF = LibStub("Masque",true)
local db = {}

--Callback(Addon, Group, SkinID, Gloss, Backdrop, Colors, Disabled)
function BFLC2.SkinCallback(addon, group, skin, gloss, backdrop, colors, disabled)
		if not group then return end
				
		--LuckyCharms.Message("Masque Skin Callback!");--Debug
    --LuckyCharms.Message(addon);--Debug
    --LuckyCharms.Message(group);--Debug
    --LuckyCharms.Message(skin);--Debug
		
		self.db.groups[group].skin = skin;
		self.db.groups[group].gloss = gloss;
		self.db.groups[group].backdrop = backdrop;
		self.db.groups[group].colors = colors;
		
		if(group == "Charm Buttons") then 
			LuckyCharms.SetTexCoords()
		end
		
		if(group == "World Marker Buttons") then 
			LuckyCharms.Flares.SetTexCoords()
		end
end


BFLC2:RegisterEvent("PLAYER_ENTERING_WORLD")
function BFLC2:PLAYER_ENTERING_WORLD()

	self:UnregisterEvent("PLAYER_ENTERING_WORLD")

	LC2_Settings[LC2Profile].BtnFacade = LC2_Settings[LC2Profile].BtnFacade or {}
	db = LC2_Settings[LC2Profile].BtnFacade
	--db.dbinit = 0;--Quick Reset Debug

	if db.dbinit ~= 1 then
		local defaults = {
			groups = {
				["Charm Buttons"] = {
					skin = "Blizzard",
					gloss = false,
					backdrop = false,
					colors = {},
				},
				["Lock Button"] = {
					skin = "Blizzard",
					gloss = false,
					backdrop = false,
					colors = {},
				},
				["Crowd Control Buttons"] = {
					skin = "Blizzard",
					gloss = false,
					backdrop = false,
					colors = {},
				},
				["World Marker Buttons"] = {
					skin = "Blizzard",
					gloss = false,
					backdrop = false,
					colors = {},
				},
			},
			dbinit = 1,
		}
		db = defaults
		LC2_Settings[LC2Profile].BtnFacade = db
	end
	self.db = db

	
	local lbfgroup = LBF:Group(LC2NAME, "Charm Buttons")

	lbfgroup = LBF:Group(LC2NAME, "Lock Button")
	lbfgroup = LBF:Group(LC2NAME, "Crowd Control Buttons")
	lbfgroup = LBF:Group(LC2NAME, "World Marker Buttons")
 
	LBF:Group(LC2NAME, "Charm Buttons"):AddButton(_G["LuckyCharm1"]);
	LBF:Group(LC2NAME, "Charm Buttons"):AddButton(_G["LuckyCharm2"]);
	LBF:Group(LC2NAME, "Charm Buttons"):AddButton(_G["LuckyCharm3"]);
	LBF:Group(LC2NAME, "Charm Buttons"):AddButton(_G["LuckyCharm4"]);
	LBF:Group(LC2NAME, "Charm Buttons"):AddButton(_G["LuckyCharm5"]);
	LBF:Group(LC2NAME, "Charm Buttons"):AddButton(_G["LuckyCharm6"]);
	LBF:Group(LC2NAME, "Charm Buttons"):AddButton(_G["LuckyCharm7"]);
	LBF:Group(LC2NAME, "Charm Buttons"):AddButton(_G["LuckyCharm8"]);
	LBF:Group(LC2NAME, "Charm Buttons"):AddButton(_G["LuckyCharm0"]);
	
	LBF:Group(LC2NAME, "Lock Button"):AddButton(_G["LCBDragButton"]);

	LBF:Register(LC2NAME, BFLC2.SkinCallback, self);

	LuckyCharms.SetTexCoords();
	LuckyCharms.Flares.SetTexCoords();
end
