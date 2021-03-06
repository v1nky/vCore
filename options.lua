local addon, vCore = ...
local L = vCore.L

local pairs = pairs

local Options = CreateFrame("Frame", "vCoreOptions", InterfaceOptionsFramePanelContainer)
Options.controlTable = {}
Options.name = GetAddOnMetadata(addon, "Title")
Options.okay = function(self)
    for _, control in pairs(self.controls) do
        vCoreDB[control.var] = control:GetValue()
    end

    for _, control in pairs(self.controls) do
        if control.restart then
            ReloadUI()
        end
    end
end
Options.cancel = function(self)
    for _, control in pairs(self.controls) do
        if control.oldValue and control.oldValue ~= control:GetValue() then
            control:SetValue()
        end
    end
end
Options.default = function(self)
    for _, control in pairs(self.controls) do
        vCoreDB[control.var] = true
    end
    ReloadUI()
end
Options.refresh = function(self)
    for _, control in pairs(self.controls) do
        control:SetValue()
        control.oldValue = control:GetValue()
    end
end
InterfaceOptions_AddCategory(Options)

Options:Hide()
Options:SetScript("OnShow", function()
    local panelWidth = Options:GetWidth()/2

    local LeftSide = CreateFrame("Frame", "LeftSide", Options)
    LeftSide:SetHeight(Options:GetHeight())
    LeftSide:SetWidth(panelWidth)
    LeftSide:SetPoint("TOPLEFT", Options)

    local RightSide = CreateFrame("Frame", "RightSide", Options)
    RightSide:SetHeight(Options:GetHeight())
    RightSide:SetWidth(panelWidth)
    RightSide:SetPoint("TOPRIGHT", Options)

    local UIControls = {
        -- Left Side
        {
            type = "Label",
            name = "OptionsLabel",
            parent = Options,
            label = L.OptionsLabel,
            relativeTo = LeftSide,
            relativePoint = "TOPLEFT",
            offsetX = 16,
            offsetY = -16,
        },
        {
            type = "CheckBox",
            name = "AltBuy",
            parent = Options,
            label = L.AltBuy,
            tooltip = L.AltBuyTooltip,
            var = "AltBuy",
            needsRestart = true,
        },
        {
            type = "CheckBox",
            name = "ClearFont",
            parent = Options,
            label = L.ClearFont,
            tooltip = L.ClearFontTooltip,
            var = "ClearFont",
            needsRestart = true,
        },
        {
            type = "CheckBox",
            name = "DCP",
            parent = Options,
            label = L.DCP,
            tooltip = L.DCPTooltip,
            var = "DCP",
            needsRestart = true,
        },
        {
            type = "CheckBox",
            name = "Durability",
            parent = Options,
            label = L.Durability,
            tooltip = L.DurabilityTooltip,
            var = "Durability",
            needsRestart = true,
        },
        {
            type = "CheckBox",
            name = "MapCoords",
            parent = Options,
            label = L.MapCoords,
            tooltip = L.MapCoordsTooltip,
            var = "MapCoords",
        },
        {
            type = "CheckBox",
            name = "SpellID",
            parent = Options,
            label = L.SpellID,
            tooltip = L.SpellIDTooltip,
            var = "SpellID",
            needsRestart = true,
        },   
        {
            type = "CheckBox",
            name = "VignetteAlert",
            parent = Options,
            label = L.VignetteAlert,
            tooltip = L.VignetteAlertTooltip,
            var = "VignetteAlert",
        },
        -- Right Side
        {
            type = "Label",
            name = "OptionsLabel2",
            parent = Options,
            label = L.OptionsLabel2,
            relativeTo = RightSide,
            relativePoint = "TOPLEFT",
            offsetX = 16,
            offsetY = -16,
        },
        {
            type = "CheckBox",
            name = "ArenaTweaks",
            parent = Options,
            label = L.ArenaTweaks,
            tooltip = L.ArenaTweaksTooltip,
            var = "ArenaTweaks",
            needsRestart = true,
        },
        {
            type = "CheckBox",
            name = "ClassColourNames",
            parent = Options,
            label = L.ClassColourNames,
            tooltip = L.ClassColourNamesTooltip,
            var = "ClassColourNames",
            needsRestart = true,
        },
        {
            type = "CheckBox",
            name = "CleanActionBars",
            parent = Options,
            label = L.CleanActionBars,
            tooltip = L.CleanActionBarsTooltip,
            var = "CleanActionBars",
            needsRestart = true,
        },
        {
            type = "CheckBox",
            name = "ElitePlayer",
            parent = Options,
            label = L.ElitePlayer,
            tooltip = L.ElitePlayerTooltip,
            var = "ElitePlayer",
            needsRestart = true,
        },
        {
            type = "CheckBox",
            name = "ExtraButtons",
            parent = Options,
            label = L.ExtraButtons,
            tooltip = L.ExtraButtonsTooltip,
            var = "ExtraButtons",
            needsRestart = true,
        },
        {
            type = "CheckBox",
            name = "HideBagBar",
            parent = Options,
            label = L.HideBagBar,
            tooltip = L.HideBagBarTooltip,
            var = "HideBagBar",
            needsRestart = true,
        },
        {
            type = "CheckBox",
            name = "HideBinds",
            parent = Options,
            label = L.HideBinds,
            tooltip = L.HideBindsTooltip,
            var = "HideBinds",
			needsRestart = true,
        },
        {
            type = "CheckBox",
            name = "HideGryphons",
            parent = Options,
            label = L.HideGryphons,
            tooltip = L.HideGryphonsTooltip,
            var = "HideGryphons",
            needsRestart = true,
        },
        {
            type = "CheckBox",
            name = "HideMacroNames",
            parent = Options,
            label = L.HideMacroNames,
            tooltip = L.HideMacroNamesTooltip,
            var = "HideMacroNames",
			needsRestart = true,
        },
        {
            type = "CheckBox",
            name = "HideNames",
            parent = Options,
            label = L.HideNames,
            tooltip = L.HideNamesTooltip,
            var = "HideNames",
            needsRestart = true,
        },
        {
            type = "CheckBox",
            name = "HidePlayerName",
            parent = Options,
            label = L.HidePlayerName,
            tooltip = L.HidePlayerNameTooltip,
            var = "HidePlayerName",
            needsRestart = true,
        },
        {
            type = "CheckBox",
            name = "HideTrackingBar",
            parent = Options,
            label = L.HideTrackingBar,
            tooltip = L.HideTrackingBarTooltip,
            var = "HideTrackingBar",
            needsRestart = true,
        },
        {
            type = "CheckBox",
            name = "ResizeBuffs",
            parent = Options,
            label = L.ResizeBuffs,
            tooltip = L.ResizeBuffsTooltip,
            var = "ResizeBuffs",
            needsRestart = true,
        },
        {
            type = "CheckBox",
            name = "ResizeCastBars",
            parent = Options,
            label = L.ResizeCastBars,
            tooltip = L.ResizeCastBarsTooltip,
            var = "ResizeCastBars",
            needsRestart = true,
        },  
        {
            type = "CheckBox",
            name = "CastBarIcon",
            parent = Options,
            label = L.CastBarIcon,
            tooltip = L.CastBarIconTooltip,
            var = "CastBarIcon",
            needsRestart = true,
        },  
        {
            type = "CheckBox",
            name = "ResizeFocus",
            parent = Options,
            label = L.ResizeFocus,
            tooltip = L.ResizeFocusTooltip,
            var = "ResizeFocus",
            needsRestart = true,
        }, 
    }

    for i, control in pairs(UIControls) do
        if control.type == "Label" then
            vCore:CreateLabel(control)
        elseif control.type == "CheckBox" then
            vCore:CreateCheckBox(control)
        end
    end

    function Options:Refresh()
        for _, control in pairs(self.controls) do
            control:SetValue(control)
            control.oldValue = control:GetValue()
        end
    end

    Options:Refresh()
    Options:SetScript("OnShow", nil)
end)
