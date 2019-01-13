-- credit to Neal (NeavUI)
local _, vCore = ...

function vCore:AltBuy()
    local L = vCore.L
    local select = select

    local NEW_ITEM_VENDOR_STACK_BUY = ITEM_VENDOR_STACK_BUY
    ITEM_VENDOR_STACK_BUY = "|cffa9ff00"..NEW_ITEM_VENDOR_STACK_BUY.."|r"

    hooksecurefunc("MerchantItemButton_OnModifiedClick", function(self, ...)
        if not vCoreDB.AltBuy then return end
        if IsAltKeyDown() then
            local maxStack = select(8, GetItemInfo(GetMerchantItemLink(self:GetID())))

            local numAvailable = select(5, GetMerchantItemInfo(self:GetID()))

            if numAvailable ~= -1 then
                BuyMerchantItem(self:GetID(), numAvailable)
            else
                BuyMerchantItem(self:GetID(), GetMerchantItemMaxStack(self:GetID()))
            end
        end
    end)

    local function IsMerchantButtonOver()
        return GetMouseFocus():GetName() and GetMouseFocus():GetName():find("MerchantItem%d")
    end

    GameTooltip:HookScript("OnTooltipSetItem", function(self)
        if not vCoreDB.AltBuy then return end
        if MerchantFrame:IsShown() and IsMerchantButtonOver() then
            for i = 2, GameTooltip:NumLines() do
                local line = _G["GameTooltipTextLeft"..i]:GetText() or ""
                if line:find("<[sS]hift") then
                    GameTooltip:AddLine("|cff00ffcc"..L.AltBuyVendorToolip.."|r")
                end
            end
        end
    end)
end