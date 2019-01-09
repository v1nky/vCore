local _, vCore = ...

function vCore:AltBuy()
    local L = vCore.L
    local select = select

    local NEW_ITEM_VENDOR_STACK_BUY = ITEM_VENDOR_STACK_BUY
    ITEM_VENDOR_STACK_BUY = "|cffa9ff00"..NEW_ITEM_VENDOR_STACK_BUY.."|r"

        -- Alt-click to buy a stack.
    hooksecurefunc("MerchantItemButton_OnModifiedClick", function(self, ...)
        if not vCoreDB.AltBuy then return end
        if IsAltKeyDown() then
            local maxStack = select(8, GetItemInfo(GetMerchantItemLink(self:GetID())))

            local numAvailable = select(5, GetMerchantItemInfo(self:GetID()))

            -- -1 means an item has unlimited supply.
            if numAvailable ~= -1 then
                BuyMerchantItem(self:GetID(), numAvailable)
            else
                BuyMerchantItem(self:GetID(), GetMerchantItemMaxStack(self:GetID()))
            end
        end
    end)

        -- Add a hint to the tooltip.
    local function IsMerchantButtonOver()
        return GetMouseFocus():GetName() and GetMouseFocus():GetName():find("MerchantItem%d")
    end

    GameTooltip:HookScript("OnTooltipSetItem", function(self)
        if not vCoreDB.AltBuy then return end
        if MerchantFrame:IsShown() and IsMerchantButtonOver() then
            for i = 2, GameTooltip:NumLines() do
                if _G["GameTooltipTextLeft"..i]:GetText():find("<[sS]hift") then
                    GameTooltip:AddLine("|cff00ffcc"..L.AltBuyVendorToolip.."|r")
                end
            end
        end
    end)
end

        -- auto repair
        local g = CreateFrame("Frame")
        g:RegisterEvent("MERCHANT_SHOW")
        g:SetScript("OnEvent", function()
            local bag, slot
            for bag = 0, 4 do
                    for slot = 0, GetContainerNumSlots(bag) do
                            local link = GetContainerItemLink(bag, slot)
                            if link and (select(3, GetItemInfo(link)) == 0) then
                                    UseContainerItem(bag, slot)
                            end
                    end
            end

            if(CanMerchantRepair()) then
                    local cost = GetRepairAllCost()
                    if cost > 0 then
                            local money = GetMoney()
                            if IsInGuild() then
                                    local guildMoney = GetGuildBankWithdrawMoney()
                                    if guildMoney > GetGuildBankMoney() then
                                            guildMoney = GetGuildBankMoney()
                                    end
                                    if guildMoney > cost and CanGuildBankRepair() then
                                            RepairAllItems(1)
                                            print(format("|cfff07100Repair cost covered by G-Bank: %.1fg|r", cost * 0.0001))
                                            return
                                    end
                            end
                            if money > cost then
                                    RepairAllItems()
                                    print(format("|cffead000Repair cost: %.1fg|r", cost * 0.0001))
                            else
                                    print("Not enough gold to cover the repair cost.")
                            end
                    end
            end
        end)
    end