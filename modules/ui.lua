local _, vCore = ...

-- minimap improvements
MinimapZoomIn:Hide()
MinimapZoomOut:Hide()
Minimap:EnableMouseWheel(true)
Minimap:SetScript('OnMouseWheel', function(self, delta)
    if delta > 0 then
        Minimap_ZoomIn()
    else
        Minimap_ZoomOut()
    end
end)

-- Arena tweaks
function vCore:ArenaTweaks()
    if not vCoreDB.ArenaTweaks then return end
	-- dampening display in arena
	-- Credit to pas06
	local frame = CreateFrame("Frame", nil , UIParent)
	local _
	local FindAuraByName = AuraUtil.FindAuraByName
	local dampeningtext = GetSpellInfo(110310)


	frame:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
	frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	frame:SetPoint("TOP", UIWidgetTopCenterContainerFrame, "BOTTOM", 0, 0)
	frame:SetSize(200, 11.38) --11,38 is the height of the remaining time
	frame.text = frame:CreateFontString(nil, "BACKGROUND")
	frame.text:SetFontObject(GameFontNormalSmall)
	frame.text:SetAllPoints()


	function frame:UNIT_AURA(unit)
		--     1	  2		3		4			5			6			7			8				9				  10		11			12				13				14		15		   16
		local name, icon, count, debuffType, duration, expirationTime, source, isStealable, nameplateShowPersonal, spellID, canApplyAura, isBossDebuff, nameplateShowAll, noIdea, timeMod , percentage = FindAuraByName(dampeningtext, unit, "HARMFUL")

		if percentage then
			if not self:IsShown() then
				self:Show()
			end
			if self.dampening ~= percentage then
				self.dampening = percentage
				self.text:SetText(dampeningtext..": "..percentage.."%")
			end

		elseif self:IsShown() then
			self:Hide()
		end
	end

	function frame:PLAYER_ENTERING_WORLD()
		local _, instanceType = IsInInstance()
		if instanceType == "arena" then
			self:RegisterUnitEvent("UNIT_AURA", "player")
		else	
			self:UnregisterEvent("UNIT_AURA")
		end
	end

	--- Arena numbers on Nameplates (Credit to cdew/mes)
	local U=UnitIsUnit hooksecurefunc("CompactUnitFrame_UpdateName",

		function(F)

			if IsActiveBattlefieldArena()and F.unit:find( "nameplate")then 
		
				for i=1,5 do if U( F.unit ,"arena"..i)then F.name:SetText(i)F.name:SetTextColor(1 ,1,0)
				
				break 
				end 
		
			end 
		
		end 
		
	end)

end


-- hide binds and macro names
function vCore:HideBinds()
    if not vCoreDB.HideBinds then return end

	local nf = function() end
	for n,bar in ipairs({"Action", "MultiBarBottomLeft", "MultiBarBottomRight", "MultiBarRight", "MultiBarLeft"}) do
		for btnnum=1, 12 do
			local btn = bar.."Button"..btnnum
			if _G[btn] then
				_G[btn.."HotKey"]:Hide()
				_G[btn.."HotKey"].Show = nf
			end
		end
	end

	local nf = function() end
	for n,bar in ipairs({"Action", "MultiBarBottomLeft", "MultiBarBottomRight", "MultiBarRight", "MultiBarLeft"}) do
		for btnnum=1, 12 do
			local btn = bar.."Button"..btnnum
			if _G[btn] then
				_G[btn.."Name"]:Hide()
				_G[btn.."Name"].Show = nf
			end
		end
	end

end

-- hide bagbar and gryphons
function vCore:HideBagGryphons()
    if not vCoreDB.HideBagGryphons then return end

	MicroButtonAndBagsBar:Hide() 
	MainMenuBarArtFrame.LeftEndCap:Hide(); 
    MainMenuBarArtFrame.RightEndCap:Hide();
end

-- hide names on party / raid frames
function vCore:HideNames()
    if not vCoreDB.HideNames then return end

    DefaultCompactUnitFrameOptions.displayName = false
end

-- tracking bar
function vCore:HideTrackingBar()
    if not vCoreDB.HideTrackingBar then return end

    StatusTrackingBarManager:Hide()
end

-- resize castbars
function vCore:ResizeCastBars()
    if not vCoreDB.ResizeCastBars then return end

	TargetFrameSpellBar:SetScale(1.37)
    CastingBarFrame:SetScale(1.2)
end

-- elite player
function vCore:ElitePlayer()
    if not vCoreDB.ElitePlayer then return end

	PlayerFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Rare-Elite");
end

-- smaller focus frame and larger focus cat bar
function vCore:ResizeFocus()
    if not vCoreDB.ResizeFocus then return end

	FocusFrame:SetScale(0.9)
	FocusFrameSpellBar:SetScale(1.45)
end

-- extra buttons
function vCore:ExtraButtons()
    if not vCoreDB.ExtraButtons then return end

	MultiBarLeftButton12:ClearAllPoints()
	MultiBarLeftButton12:SetPoint("LEFT", MultiBarBottomLeftButton12, "RIGHT", 6, 0) MultiBarLeftButton12.SetPoint = function() end
	
	MultiBarLeftButton11:ClearAllPoints()
	MultiBarLeftButton11:SetPoint("LEFT", ActionButton12, "RIGHT", 6, 0) MultiBarLeftButton11.SetPoint = function() end
end

-- clean action bars
function vCore:CleanActionBars()
    if not vCoreDB.CleanActionBars then return end

	MultiBarBottomLeftButton1:ClearAllPoints()
	MultiBarBottomLeftButton1:SetPoint("CENTER",-232,0)
	MultiBarBottomLeftButton1.SetPoint = function() end
    
	MainMenuBarArtFrameBackground:Hide()
	ActionBarUpButton:Hide()
	ActionBarDownButton:Hide()
	MainMenuBarArtFrame.PageNumber:Hide()
end