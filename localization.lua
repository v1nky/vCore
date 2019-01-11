local _, vCore = ...

local L = {}
vCore.L = L

setmetatable(L, { __index = function(t, k)
    local v = tostring(k)
    t[k] = v
    return v
end })

------------------------------------------------------------------------
-- English
------------------------------------------------------------------------

L.OptionsLabel = "Options"
L.AltBuy = "Alt Buy"
L.AltBuyTooltip = "Hold the alt key to buy a stack of an item."
L.AltBuyVendorToolip = "<Alt-click, to buy an stack>"
L.CombatWarning = "vCore: This is not possible in combat!"
L.ArenaTweaks = "Arena Tweaks"
L.ArenaTweaksTooltip = "Adds arena numbers to enemy name plates and displays dampening status under team display"
L.ClassColourNames = "Class coloured names"
L.ClassColourNamesTooltip = "Makes the background behind player, target and focus frames name class coloured."
L.CleanActionBars = "Clean Action Bars"
L.CleanActionBarsTooltip = "Removes artwork and moves action bars 1 and 2 to the center"
L.DCP = "Doom_CooldownPulse"
L.DCPTooltip = "DCP flashes the icon of the ability in the middle of your screen whenever it becomes usable again."
L.Durability = DURABILITY
L.DurabilityTooltip = "Adds durability information to the character frame."
L.ElitePlayer = "Elite Player"
L.ElitePlayerTooltip = "Adds elite artwork around your character icon"
L.ExtraButtons = "Extra action bar buttons"
L.ExtraButtonsTooltip = "Moves RightActionBar2 Buttons 11 & 12"
L.HideBagGryphons = "Hide Bag Bar and Gryphons"
L.HideBagGryphonsTooltip = "Hides the Bag Bar and Gryphons from your UI"
L.HideBinds = "Hide Keybinds"
L.HideBindsTooltip = "Hides the keybinds and macronames from your actionbars"
L.HideNames = "Hide Names"
L.HideNamesTooltip = "Hides the names on your party & raid frames"
L.HideTrackingBar = "Hide Tracking Bar"
L.HideTrackingBarTooltip = "Hides the xp and artifact bar from your UI"
L.MapCoords = "Map Coords"
L.MapCoordsTooltip = "Adds player and cursor location to the world map."
L.ResizeCastBars = "Resize Castbars"
L.ResizeCastBarsTooltip = "makes your and your targets cast bar bigger"
L.ResizeFocus = "Resize Focus Frame"
L.ResizeFocusTooltip = "Makes the focus frame smaller and makes the focus cast bar larger"
L.SpellID = "Spell IDs"
L.SpellIDTooltip = "Add spell ids to the tooltip."
L.VignetteAlert = "Vignette Alerts"
L.VignetteAlertTooltip = "Alerts you when you detect a rare or chest."

local CURRENT_LOCALE = GetLocale()
if CURRENT_LOCALE == "enUS" then return end

------------------------------------------------------------------------
-- German
------------------------------------------------------------------------

if CURRENT_LOCALE == "deDE" then

return end

------------------------------------------------------------------------
-- Spanish
------------------------------------------------------------------------

if CURRENT_LOCALE == "esES" then

return end

------------------------------------------------------------------------
-- Latin American Spanish
------------------------------------------------------------------------

if CURRENT_LOCALE == "esMX" then

return end

------------------------------------------------------------------------
-- French
------------------------------------------------------------------------

if CURRENT_LOCALE == "frFR" then

return end

------------------------------------------------------------------------
-- Italian
------------------------------------------------------------------------

if CURRENT_LOCALE == "itIT" then

return end

------------------------------------------------------------------------
-- Brazilian Portuguese
------------------------------------------------------------------------

if CURRENT_LOCALE == "ptBR" then

return end

------------------------------------------------------------------------
-- Russian
------------------------------------------------------------------------

if CURRENT_LOCALE == "ruRU" then

return end

------------------------------------------------------------------------
-- Korean
------------------------------------------------------------------------

if CURRENT_LOCALE == "koKR" then

return end

------------------------------------------------------------------------
-- Simplified Chinese
------------------------------------------------------------------------

if CURRENT_LOCALE == "zhCN" then

return end

------------------------------------------------------------------------
-- Traditional Chinese
------------------------------------------------------------------------

if CURRENT_LOCALE == "zhTW" then

return end
