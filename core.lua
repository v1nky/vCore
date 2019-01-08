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
            vCore:ArenaNumbers()
            vCore:ArenaDampening()
            vCore:CleanActionBars()
            vCore:DCP()
            vCore:Durability()
            vCore:ExtraButtons()
            vCore:HideBagBar()
            vCore:HideBinds()
            vCore:HideNames()
            vCore:MapCoords()
            vCore:ResizePlayerCastBar()
            vCore:ResizeTargetCastBar()
            vCore:ResizeFocusCastBar()
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