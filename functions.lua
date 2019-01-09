local _, vCore = ...

function vCore:RegisterDefaultSetting(key, value)
    if vCoreDB == nil then
        vCoreDB = {}
    end
    if vCoreDB[key] == nil then
        vCoreDB[key] = value
    end
end

function vCore:SetDefaultOptions()
    vCore:RegisterDefaultSetting("AltBuy", true)
    vCore:RegisterDefaultSetting("ArenaTweaks", true)
    vCore:RegisterDefaultSetting("AutoRepair", true)
    vCore:RegisterDefaultSetting("CleanActionBars", false)
    vCore:RegisterDefaultSetting("DCP", true)
    vCore:RegisterDefaultSetting("Durability", true)
    vCore:RegisterDefaultSetting("ExtraButtons", false)
    vCore:RegisterDefaultSetting("HideBagBar", true)
    vCore:RegisterDefaultSetting("HideBinds", false)
    vCore:RegisterDefaultSetting("HideGryphons", false)
    vCore:RegisterDefaultSetting("HideNames", true)
    vCore:RegisterDefaultSetting("HideTrackingBar", false)
    vCore:RegisterDefaultSetting("MapCoords", false)
    vCore:RegisterDefaultSetting("ResizeCastBars", true)
    vCore:RegisterDefaultSetting("ResizeFocus", true)
    vCore:RegisterDefaultSetting("SpellID", true)
    vCore:RegisterDefaultSetting("VignetteAlert", true)
end

function vCore:LockInCombat(frame)
    frame:SetScript("OnUpdate", function(self)
        if not InCombatLockdown() then
            self:Enable()
        else
            self:Disable()
        end
    end)
end

function vCore:RegisterControl(control, parentFrame)
    if ( ( not parentFrame ) or ( not control ) ) then
        return;
    end

    parentFrame.controls = parentFrame.controls or {};

    tinsert(parentFrame.controls, control);
end

local prevControl

function vCore:CreateLabel(cfg)
    --[[
        {
            type = "Label",
            name = "LabelName",
            parent = Options,
            label = L.LabelText,
            fontObject = "GameFontNormalLarge",
            relativeTo = LeftSide,
            relativePoint = "TOPLEFT",
            offsetX = 16,
            offsetY = -16,
        },
    --]]
    cfg.initialPoint = cfg.initialPoint or "TOPLEFT"
    cfg.relativePoint = cfg.relativePoint or "BOTTOMLEFT"
    cfg.offsetX = cfg.offsetX or 0
    cfg.offsetY = cfg.offsetY or -16
    cfg.relativeTo = cfg.relativeTo or prevControl
    cfg.fontObject = cfg.fontObject or "GameFontNormalLarge"

    local label = cfg.parent:CreateFontString(cfg.name, "ARTWORK", cfg.fontObject)
    label:SetPoint(cfg.initialPoint, cfg.relativeTo, cfg.relativePoint, cfg.offsetX, cfg.offsetY)
    label:SetText(cfg.label)

    prevControl = label
    return label
end

function vCore:CreateCheckBox(cfg)
    --[[
        {
            type = "CheckBox",
            name = "Test",
            parent = parent,
            label = L.TestLabel,
            tooltip = L.TestTooltip,
            isCvar = nil or True,
            var = "TestVar",
            needsRestart = nil or True,
            disableInCombat = nil or True,
            func = function(self)
                -- Do stuff here.
            end,
            initialPoint = "TOPLEFT",
            relativeTo = frame,
            relativePoint, "BOTTOMLEFT",
            offsetX = 0,
            offsetY = -6,
        },
    --]]
    cfg.initialPoint = cfg.initialPoint or "TOPLEFT"
    cfg.relativePoint = cfg.relativePoint or "BOTTOMLEFT"
    cfg.offsetX = cfg.offsetX or 0
    cfg.offsetY = cfg.offsetY or -6
    cfg.relativeTo = cfg.relativeTo or prevControl

    local checkBox = CreateFrame("CheckButton", cfg.name, cfg.parent, "InterfaceOptionsCheckButtonTemplate")
    checkBox:SetPoint(cfg.initialPoint, cfg.relativeTo, cfg.relativePoint, cfg.offsetX, cfg.offsetY)
    checkBox.Text:SetText(cfg.label)
    checkBox.GetValue = function(self) return checkBox:GetChecked() end
    checkBox.SetValue = function(self) checkBox:SetChecked(vCoreDB[cfg.var]) end
    checkBox.var = cfg.var
    checkBox.isCvar = cfg.isCvar

    if cfg.needsRestart then
        checkBox.restart = false
    end

    if cfg.tooltip then
        if cfg.needsRestart then
            cfg.tooltip = cfg.tooltip.." "..RED_FONT_COLOR:WrapTextInColorCode(REQUIRES_RELOAD)
        end
        checkBox.tooltipText = cfg.tooltip
    end

    if cfg.disableInCombat then
        vCore:LockInCombat(checkBox)
    end

    checkBox:SetScript("OnClick", function(self)
        local checked = self:GetChecked()
        PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
        checkBox.value = checked
        if cfg.needsRestart then
            checkBox.restart = not checkBox.restart
        end
        if cfg.func then
            cfg.func(self)
        end
    end)

    vCore:RegisterControl(checkBox, cfg.parent)
    prevControl = checkBox
    return checkBox
end
