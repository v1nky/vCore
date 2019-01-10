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
        -- set cvars each time player logs in
        SetCVar("ScreenshotQuality", 10)
    elseif event == "ADDON_LOADED" then
        local name = ...
        if name == "vCore" then
            vCore:SetDefaultOptions()
			vCore:AltBuy()
			vCore:ArenaTweaks()
            vCore:CleanActionBars()
            vCore:DCP()
			vCore:Durability()
			vCore:ElitePlayer()
            vCore:ExtraButtons()
			vCore:HideBinds()
			vCore:HideBagGryphons()
            vCore:HideNames()
            vCore:HideTrackingBar()
			vCore:MapCoords()
			vCore:ResizeCastBars()
            vCore:ResizeFocus()
            vCore:SpellID()
            vCore:VignetteAlert()
        end
    end
end

SlashCmdList["RELOADUI"] = function()
    ReloadUI()
end
SLASH_RELOADUI1 = "/rl"

-- Slah Command for activation - Usage : /sgrid <value>
SLASH_SGRIDA1 = "/sgrid"

-- local variables for frame and line points
local frame
local w
local h

SlashCmdList["SGRIDA"] = function(msg, editbox)
	-- hiding grid if already enabled
	if frame then
		frame:Hide()
		frame = nil
	else
	-- cases for grid size
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
		-- grid size reset
			w = nil
			w = nil
		end
		-- check for corrrect grid case, if incorrect print usage and end
		if w == nil then
			print("Usage: '/sgrid <value>' Value options are 32/64/96/128")
		else
		-- determin grid line points
			local lines_w = GetScreenWidth() / w
			local lines_h = GetScreenHeight() / h
		-- create frame
			frame = CreateFrame('Frame', nil, UIParent)
			frame:SetAllPoints(UIParent)
		-- build horizontal lines
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
		-- build vertical lines
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

-- auto repair
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
		-- If merchant can repair and there is something to repair
		if (canRepair and repairAllCost > 0) then
			-- Use Guild Bank
			guildRepairedItems = false
			if (IsInGuild() and CanGuildBankRepair()) then
				-- Checks if guild has enough money
				local amount = GetGuildBankWithdrawMoney()
				local guildBankMoney = GetGuildBankMoney()
				amount = amount == -1 and guildBankMoney or min(amount, guildBankMoney)

				if (amount >= repairAllCost) then
					RepairAllItems(true);
					guildRepairedItems = true
					DEFAULT_CHAT_FRAME:AddMessage("Equipment has been repaired by your Guild", 255, 255, 255)
				end
			end
			
			-- Use own funds
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