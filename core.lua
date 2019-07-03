local _, vCore = ...

function vCore_OnLoad(self)
    self:RegisterEvent("PLAYER_LOGIN")
    self:RegisterEvent("ADDON_LOADED")

    if AddonList then
        _G["ADDON_DEMAND_LOADED"] = "On Demand"
    end

end

function vCore_OnEvent(self, event, ...)
    if event == "PLAYER_LOGIN" then
		SetCVar("ScreenshotQuality", 10)
		SetCVar("floatingCombatTextCombatState", 1)
    elseif event == "ADDON_LOADED" then
        local name = ...
        if name == "vCore" then
            vCore:SetDefaultOptions()
			vCore:AltBuy()
			vCore:ArenaTweaks()
			vCore:CastBarIcon()
			vCore:ClassColourNames()
			vCore:CleanActionBars()
			vCore:ClearFont()
            vCore:DCP()
			vCore:Durability()
			vCore:ElitePlayer()
			vCore:ExtraButtons()
			vCore:HideBagBar()
			vCore:HideBinds()
			vCore:HideGryphons()
			vCore:HideMacroNames()
			vCore:HideNames()
			vCore:HideStanceBar()
            vCore:HideTrackingBar()
			vCore:MapCoords()
			vCore:ResizeBuffs()
			vCore:ResizeCastBars()
            vCore:ResizeFocus()
            vCore:SpellID()
            vCore:VignetteAlert()
        end
    end
end

-- Slash commands
SlashCmdList["RELOADUI"] = function()
    ReloadUI()
end
SLASH_RELOADUI1 = "/rl"

SlashCmdList["CLCE"] = function() CombatLogClearEntries() end
SLASH_CLCE1 = "/cl"

SlashCmdList["TICKET"] = function() ToggleHelpFrame() end
SLASH_TICKET1 = "/gm"

SlashCmdList["READYCHECK"] = function() DoReadyCheck() end
SLASH_READYCHECK1 = '/rc'

SlashCmdList["CHECKROLE"] = function() InitiateRolePoll() end
SLASH_CHECKROLE1 = '/cr'

-- SGRID
SLASH_SGRIDA1 = "/sgrid"

local frame
local w
local h

SlashCmdList["SGRIDA"] = function(msg, editbox)
	if frame then
		frame:Hide()
		frame = nil
	else
		if msg == '128' then
			w = 128
			h = 72
		elseif msg == '96' then
			w = 96
			h = 54
		elseif msg == '64' then
			w = 64
			h = 36
		elseif msg == '32' then
			w = 32
			h = 18
		else
			w = nil
			w = nil
		end
		if w == nil then
			print("Usage: '/sgrid <value>' Value options are 32/64/96/128")
		else
			local lines_w = GetScreenWidth() / w
			local lines_h = GetScreenHeight() / h
			frame = CreateFrame('Frame', nil, UIParent)
			frame:SetAllPoints(UIParent)
			for i = 0, w do
				local line_texture = frame:CreateTexture(nil, 'BACKGROUND')
				if i == w/2 then
					line_texture:SetColorTexture(1, 0, 0, 0.5)
				else
					line_texture:SetColorTexture(0, 0, 0, 0.1)
				end
				line_texture:SetPoint('TOPLEFT', frame, 'TOPLEFT', i * lines_w - 1, 0)
				line_texture:SetPoint('BOTTOMRIGHT', frame, 'BOTTOMLEFT', i * lines_w + 1, 0)
			end
			for i = 0, h do
				local line_texture = frame:CreateTexture(nil, 'BACKGROUND')
				if i == h/2 then
					line_texture:SetColorTexture(1, 0, 0, 0.5)
				else
					line_texture:SetColorTexture(0, 0, 0, 0.5)
				end
					line_texture:SetPoint('TOPLEFT', frame, 'TOPLEFT', 0, -i * lines_h + 1)
					line_texture:SetPoint('BOTTOMRIGHT', frame, 'TOPRIGHT', 0, -i * lines_h - 1)
			end
		end
	end
end


local function OnEvent(self, event)
	-- Auto Sell Grey Items
	totalPrice = 0	
	for myBags = 0,4 do
		for bagSlots = 1, GetContainerNumSlots(myBags) do
			CurrentItemLink = GetContainerItemLink(myBags, bagSlots)
			if CurrentItemLink then
				_, _, itemRarity, _, _, _, _, _, _, _, itemSellPrice = GetItemInfo(CurrentItemLink)
				_, itemCount = GetContainerItemInfo(myBags, bagSlots)
				if itemRarity == 0 and itemSellPrice ~= 0 then
					totalPrice = totalPrice + (itemSellPrice * itemCount)
					UseContainerItem(myBags, bagSlots)
					PickupMerchantItem()
				end
			end
		end
	end
	if totalPrice ~= 0 then
		DEFAULT_CHAT_FRAME:AddMessage("Items were sold for "..GetCoinTextureString(totalPrice), 255, 255, 255)
	end

	-- Auto Repair
	if (CanMerchantRepair()) then	
		repairAllCost, canRepair = GetRepairAllCost();
		if (canRepair and repairAllCost > 0) then
			guildRepairedItems = false
			if (IsInGuild() and CanGuildBankRepair()) then
				local amount = GetGuildBankWithdrawMoney()
				local guildBankMoney = GetGuildBankMoney()
				amount = amount == -1 and guildBankMoney or min(amount, guildBankMoney)

				if (amount >= repairAllCost) then
					RepairAllItems(true);
					guildRepairedItems = true
					DEFAULT_CHAT_FRAME:AddMessage("Equipment has been repaired by your Guild", 255, 255, 255)
				end
			end
			if (repairAllCost <= GetMoney() and not guildRepairedItems) then
				RepairAllItems(false);
				DEFAULT_CHAT_FRAME:AddMessage("Equipment has been repaired for "..GetCoinTextureString(repairAllCost), 255, 255, 255)
			end
		end
	end
end


local f = CreateFrame("Frame")
f:SetScript("OnEvent", OnEvent);
f:RegisterEvent("MERCHANT_SHOW");

-- shortcut for interface options idea credit kickR
SLASH_vCore1 = "/vc"
SlashCmdList.vCore = function(msg)
	InterfaceOptionsFrame_OpenToCategory("vCore")
	InterfaceOptionsFrame_OpenToCategory("vCore")
end

----------------------------------------------------------------------------------------
--	Skip cinematics/movies(CinematicSkip by Pigmonkey)
----------------------------------------------------------------------------------------
-- Cancel cinematics after they start
--local frame = CreateFrame("Frame")
--frame:RegisterEvent("CINEMATIC_START")
--frame:SetScript("OnEvent", function(_, event)
--	if event == "CINEMATIC_START" then
--		if not IsControlKeyDown() then
--			CinematicFrame_CancelCinematic()
--		end
--	end
--end)

-- Hook movies and stop them before they get called
--local PlayMovie_hook = MovieFrame_PlayMovie
--MovieFrame_PlayMovie = function(...)
--	if IsControlKeyDown() then
--		PlayMovie_hook(...)
--	else
--		GameMovieFinished()
--	end
--end