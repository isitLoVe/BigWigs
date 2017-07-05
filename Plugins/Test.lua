
------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.2"):new("BigWigsTest")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["test"] = true,
	["Test"] = true,
	["Test Bar"] = true,
	["Test Bar 2"] = true,
	["Test Bar 3"] = true,
	["Test Bar 4"] = true,
	["Testing"] = true,
	["OMG Bear!"] = true,
	["*RAWR*"] = true,
	["Victory!"] = true,
	["Options for testing."] = true,
	["local"] = true,
	["Local test"] = true,
	["Perform a local test of BigWigs."] = true,
	["sync"] = true,
	["Sync test"] = true,
	["Perform a sync test of BigWigs."] = true,
	["Testing Sync"] = true,
	["Test HP Bar 1"] = true,
	["Test HP Bar 2"] = true,
} end)


----------------------------------
--      Module Declaration      --
----------------------------------

BigWigsTest = BigWigs:NewModule(L["Test"])
BigWigsTest.revision = tonumber(string.sub("$Revision: 30000 $", 12, -3))

BigWigsTest.consoleCmd = L["test"]
BigWigsTest.consoleOptions = {
	type = "group",
	name = L["Test"],
	desc = L["Options for testing."],
	args   = {
		[L["local"]] = {
			type = "execute",
			name = L["Local test"],
			desc = L["Perform a local test of BigWigs."],
			func = function() BigWigsTest:TriggerEvent("BigWigs_Test") end,
		},
		[L["sync"]] = {
			type = "execute",
			name = L["Sync test"],
			desc = L["Perform a sync test of BigWigs."],
			func = function() BigWigsTest:TriggerEvent("BigWigs_SyncTest") end,
			disabled = function() return ( not IsRaidLeader() and not IsRaidOfficer() ) end,
		},
	}
}

function BigWigsTest:OnEnable()
	self:RegisterEvent("BigWigs_Test")
	self:RegisterEvent("BigWigs_RecvSync")
	self:TriggerEvent("BigWigs_ThrottleSync", "TestSync", 5)
	self:RegisterEvent("BigWigs_SyncTest")
end


function BigWigsTest:BigWigs_SyncTest()
	self:TriggerEvent("BigWigs_SendSync", "TestSync")
end


function BigWigsTest:BigWigs_RecvSync(sync, rest, nick)
	if sync == "TestSync" then
		self:Message(L["Testing Sync"], "Positive")
		self:Bar(L["Testing Sync"], 10, "Spell_Frost_FrostShock", true, "Green", "Blue", "Yellow", "Red")
    elseif sync == "TestNumber" and rest then
        --SendChat(rest)
        rest = tonumber(rest)
        if type(rest) == "number" then
            --SendChat(rest * 2) 
        end
	end
end


function BigWigsTest:BigWigs_Test()
    self:Message(L["Testing"], "Attention", true, "Long")
	self:Bar(L["Test Bar 4"], 3, "Spell_Nature_ResistNature", true, "black")
    self:Bar(L["Test Bar 3"], 5, "Spell_Nature_ResistNature", true, "red")
    self:Bar(L["Test Bar 2"], 16, "Inv_Hammer_Unique_Sulfuras")
	self:Bar(L["Test Bar"], 20, "Spell_Nature_ResistNature")
    self:WarningSign("Inv_Hammer_Unique_Sulfuras", 10)
    
	self:DelayedMessage(5, L["OMG Bear!"], "Important", true, "Alert")
	self:DelayedMessage(10, L["*RAWR*"], "Urgent", true, "Alarm")
	self:DelayedMessage(20, L["Victory!"], "Bosskill", true, "Victory")
    
    self:Sync("TestNumber 5")
    
    BigWigs:Proximity()
    
    local function deactivate()
        BigWigs:RemoveProximity()
    end
	
	--HPBar
	self:TriggerEvent("BigWigs_StartHPBar", self, L["Test HP Bar 1"], 100)
    --self:TriggerEvent("BigWigs_SetHPBar", self, L["Test HP Bar 1"], 0)
    self:TriggerEvent("BigWigs_StartHPBar", self, L["Test HP Bar 2"], 100)
   -- self:TriggerEvent("BigWigs_SetHPBar", self, L["Test HP Bar 2"], 0)
    health = 100
	self:ScheduleRepeatingEvent("bwtesthpbarrepeat", self.UpdateTestHPBars, 0.1, self)

    
    self:ScheduleEvent("BigWigsTestOver", deactivate, 20, self)
    
    --self:Sync("BossEngaged "..self:ToString())
    
	
    
    --self:TriggerEvent("BigWigs_StartCounterBar", self, "CounterBar Test", 10, "Spell_Shadow_Charm")
    --self:TriggerEvent("BigWigs_StartCounterBar", self, "CounterBar Test2", 30, "Spell_Shadow_Charm", true, "red")
end

--function BigWigsTest:TestCounter()
--    self:TriggerEvent("BigWigs_SetCounterBar", self, "CounterBar Test", 5, true)
--end

function BigWigsTest:UpdateTestHPBars()
	if health > 0 then
		health = health - 1
		self:TriggerEvent("BigWigs_SetHPBar", self, L["Test HP Bar 1"], 100-health)
		self:TriggerEvent("BigWigs_SetHPBar", self, L["Test HP Bar 2"], 100-health)
	end
end

