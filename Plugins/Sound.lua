
assert(BigWigs, "BigWigs not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigsSound")
--~~ local dewdrop = DewdropLib:GetInstance("1.0")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["Sounds"] = true,
	["sounds"] = true,
	["Options for sounds."] = true,

	["toggle"] = true,
	["Use sounds"] = true,
	["Toggle sounds on or off."] = true,
	["default"] = true,
	["Default only"] = true,
	["Use only the default sound."] = true,
	
	["victory"] = true,	
	["Victory Sound"] = true,	
	["Mortal Combat"] = true,	
	["Final Fantasy VII"] = true,	
	["Sound to play when a boss is killed."] = true,	
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

BigWigsSound = BigWigs:NewModule(L["Sounds"])
BigWigsSound.revision = tonumber(string.sub("$Revision: 30000 $", 12, -3))
BigWigsSound.defaults = {
	defaultonly = false,
	sound = true,
	victorysound = L["Mortal Combat"],
}
BigWigsSound.consoleCmd = L["sounds"]
BigWigsSound.consoleOptions = {
	type = "group",
	name = L["Sounds"],
	desc = L["Options for sounds."],
	args = {
		[L["toggle"]] = {
			type = "toggle",
			name = L["Sounds"],
			desc = L["Toggle sounds on or off."],
			get = function() return BigWigsSound.db.profile.sound end,
			set = function(v)
				BigWigsSound.db.profile.sound = v
				BigWigs:ToggleModuleActive(L["Sounds"], v)
			end,
		},
		[L["default"]] = {
			type = "toggle",
			name = L["Default only"],
			desc = L["Use only the default sound."],
			get = function() return BigWigsSound.db.profile.defaultonly end,
			set = function(v) BigWigsSound.db.profile.defaultonly = v end,
		},
		[L["victory"]] = {
			type = "text",
			name = L["Victory Sound"],
			desc = L["Sound to play when a boss is killed."],
			get = function() return BigWigsSound.db.profile.victorysound end,
			set = function(v) BigWigsSound.db.profile.victorysound = v end,
			validate = { L["Mortal Combat"], L["Final Fantasy VII"]  },
		}
	}
}

------------------------------
--      Initialization      --
------------------------------

function BigWigsSound:OnEnable()
	self:RegisterEvent("BigWigs_Message")
	self:RegisterEvent("BigWigs_Sound")
	if not self.db.profile.victorysound then self.db.profile.victorysound = L["Mortal Combat"] end
end

function BigWigsSound:OnDisable()
    BigWigs:DebugMessage("OnDisable")
end

function BigWigsSound:BigWigs_Message(text, color, noraidsay, sound, broadcastonly)
	if not text or sound == false or broadcastonly then return end
	
	if self.db.profile.victorysound and self.db.profile.victorysound == L["Final Fantasy VII"] then
		sounds = {
			Long = "Interface\\AddOns\\BigWigsVG\\Sounds\\Long.mp3",
			Info = "Interface\\AddOns\\BigWigsVG\\Sounds\\Info.ogg",
			Alert = "Interface\\AddOns\\BigWigsVG\\Sounds\\Alert.mp3",
			Alarm = "Interface\\AddOns\\BigWigsVG\\Sounds\\Alarm.mp3",
			Victory = "Interface\\AddOns\\BigWigsVG\\Sounds\\Victory_FF.mp3",
			Murloc = "Sound\\Creature\\Murloc\\mMurlocAggroOld.wav",
		}
	elseif self.db.profile.victorysound and self.db.profile.victorysound == L["Mortal Combat"] then
		sounds = {
			Long = "Interface\\AddOns\\BigWigsVG\\Sounds\\Long.mp3",
			Info = "Interface\\AddOns\\BigWigsVG\\Sounds\\Info.ogg",
			Alert = "Interface\\AddOns\\BigWigsVG\\Sounds\\Alert.mp3",
			Alarm = "Interface\\AddOns\\BigWigsVG\\Sounds\\Alarm.mp3",
			Victory = "Interface\\AddOns\\BigWigsVG\\Sounds\\Victory_MC.mp3",
			Murloc = "Sound\\Creature\\Murloc\\mMurlocAggroOld.wav",
		}
	else
		sounds = {
			Long = "Interface\\AddOns\\BigWigsVG\\Sounds\\Long.mp3",
			Info = "Interface\\AddOns\\BigWigsVG\\Sounds\\Info.ogg",
			Alert = "Interface\\AddOns\\BigWigsVG\\Sounds\\Alert.mp3",
			Alarm = "Interface\\AddOns\\BigWigsVG\\Sounds\\Alarm.mp3",
			Victory = "Interface\\AddOns\\BigWigsVG\\Sounds\\Victory_MC.mp3",
			Murloc = "Sound\\Creature\\Murloc\\mMurlocAggroOld.wav",
		}
	end

	if sounds[sound] and not self.db.profile.defaultonly then
		PlaySoundFile(sounds[sound])
	else
		PlaySound("RaidWarning")
	end
	
end

function BigWigsSound:BigWigs_Sound( sound )

	if self.db.profile.victorysound and self.db.profile.victorysound == L["Final Fantasy VII"] then
		sounds = {
			Long = "Interface\\AddOns\\BigWigsVG\\Sounds\\Long.mp3",
			Info = "Interface\\AddOns\\BigWigsVG\\Sounds\\Info.ogg",
			Alert = "Interface\\AddOns\\BigWigsVG\\Sounds\\Alert.mp3",
			Alarm = "Interface\\AddOns\\BigWigsVG\\Sounds\\Alarm.mp3",
			Victory = "Interface\\AddOns\\BigWigsVG\\Sounds\\Victory_FF.mp3",
			Murloc = "Sound\\Creature\\Murloc\\mMurlocAggroOld.wav",
		}
	elseif self.db.profile.victorysound and self.db.profile.victorysound == L["Mortal Combat"] then
		sounds = {
			Long = "Interface\\AddOns\\BigWigsVG\\Sounds\\Long.mp3",
			Info = "Interface\\AddOns\\BigWigsVG\\Sounds\\Info.ogg",
			Alert = "Interface\\AddOns\\BigWigsVG\\Sounds\\Alert.mp3",
			Alarm = "Interface\\AddOns\\BigWigsVG\\Sounds\\Alarm.mp3",
			Victory = "Interface\\AddOns\\BigWigsVG\\Sounds\\Victory_MC.mp3",
			Murloc = "Sound\\Creature\\Murloc\\mMurlocAggroOld.wav",
		}
	else
		sounds = {
			Long = "Interface\\AddOns\\BigWigsVG\\Sounds\\Long.mp3",
			Info = "Interface\\AddOns\\BigWigsVG\\Sounds\\Info.ogg",
			Alert = "Interface\\AddOns\\BigWigsVG\\Sounds\\Alert.mp3",
			Alarm = "Interface\\AddOns\\BigWigsVG\\Sounds\\Alarm.mp3",
			Victory = "Interface\\AddOns\\BigWigsVG\\Sounds\\Victory_MC.mp3",
			Murloc = "Sound\\Creature\\Murloc\\mMurlocAggroOld.wav",
		}
	end

	if sounds[sound] and not self.db.profile.defaultonly then 
		PlaySoundFile(sounds[sound])
	else 
		PlaySound("RaidWarning") 
	end
end
