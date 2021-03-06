﻿local S, C, L, DB = unpack(select(2, ...))
if DB.Nuke == true then return end


local AceGUI = LibStub and LibStub("AceGUI-3.0", true)
if not AceGUI then return end

local oldRegisterAsWidget = AceGUI.RegisterAsWidget

AceGUI.RegisterAsWidget = function(self, widget)
	local TYPE = widget.type
	--print(TYPE)
	if TYPE == "CheckBox" then
		S.Kill(widget.checkbg)
		S.Kill(widget.highlight)

		if not widget.skinnedCheckBG then
			widget.skinnedCheckBG = CreateFrame('Frame', nil, widget.frame)
			widget.skinnedCheckBG:SetPoint('TOPLEFT', widget.checkbg, 'TOPLEFT', 4, -4)
			widget.skinnedCheckBG:SetPoint('BOTTOMRIGHT', widget.checkbg, 'BOTTOMRIGHT', -4, 4)
			widget.skinnedCheckBG:CreateBD()
		end

		if widget.skinnedCheckBG.oborder then
			widget.check:SetParent(widget.skinnedCheckBG.oborder)
		else
			widget.check:SetParent(widget.skinnedCheckBG)
		end
	elseif TYPE == "Dropdown" then
		local frame = widget.dropdown
		local button = widget.button
		local text = widget.text
		S.StripTextures(frame)
		local bg = CreateFrame("Frame", nil, frame)
		bg:SetPoint("TOPLEFT", 16, 0)
		bg:SetPoint("BOTTOMRIGHT", -20, 0)
		bg:SetFrameLevel(frame:GetFrameLevel()-1)
		bg:CreateBD(0)

		local tex = bg:CreateTexture(nil, "BACKGROUND")
		tex:SetPoint("TOPLEFT")
		tex:SetPoint("BOTTOMRIGHT")
		tex:SetTexture(DB.aurobackdrop)
		tex:SetGradientAlpha("VERTICAL", 0, 0, 0, .3, .35, .35, .35, .35)

		button:ClearAllPoints()
		button:SetPoint("RIGHT", frame, "RIGHT", -20, 0)
	
		button:SetDisabledTexture(DB.aurobackdrop)
		local dis = button:GetDisabledTexture()
		dis:SetVertexColor(0, 0, 0, .3)
		dis:SetDrawLayer("OVERLAY")

		local downtex = button:CreateTexture(nil, "ARTWORK")
		downtex:SetTexture("Interface\\AddOns\\s_Core\\media\\arrow-down-active")
		downtex:SetSize(8, 8)
		downtex:SetPoint("CENTER")
		downtex:SetVertexColor(1, 1, 1)
		
		button:SetParent(bg)
		text:SetParent(bg)
		button:HookScript('OnClick', function(this)
			local self = this.obj
			self.pullout.frame:CreateBD()
		end)
	elseif TYPE == "LSM30_Font" or TYPE == "LSM30_Sound" or TYPE == "LSM30_Border" or TYPE == "LSM30_Background" or TYPE == "LSM30_Statusbar" then
		local frame = widget.frame
		local button = frame.dropButton
		local text = frame.text
		S.StripTextures(frame)

		button:ClearAllPoints()
		button:SetPoint("RIGHT", frame, "RIGHT", -20, 0)
	
		button:SetDisabledTexture(DB.aurobackdrop)
		local dis = button:GetDisabledTexture()
		dis:SetVertexColor(0, 0, 0, .3)
		dis:SetDrawLayer("OVERLAY")

		local downtex = button:CreateTexture(nil, "ARTWORK")
		downtex:SetTexture("Interface\\AddOns\\s_Core\\media\\arrow-down-active")
		downtex:SetSize(8, 8)
		downtex:SetPoint("CENTER")
		downtex:SetVertexColor(1, 1, 1)
		frame.text:ClearAllPoints()
		frame.text:SetPoint('RIGHT', button, 'LEFT', -2, 0)

		button:ClearAllPoints()
		button:SetPoint("RIGHT", frame, "RIGHT", -10, -6)

		if not frame.backdrop then
			frame.backdrop = CreateFrame("Frame", nil, frame)
			frame.backdrop:SetPoint("TOPLEFT", -3, 3)
			frame.backdrop:SetPoint("BOTTOMRIGHT", 3, -3)
			local tex = frame.backdrop:CreateTexture(nil, "BACKGROUND")
			tex:SetPoint("TOPLEFT")
			tex:SetPoint("BOTTOMRIGHT")
			tex:SetTexture(DB.aurobackdrop)
			tex:SetGradientAlpha("VERTICAL", 0, 0, 0, .3, .35, .35, .35, .35)
			frame.backdrop:CreateBD()
			if frame:GetFrameLevel() - 1 >= 0 then
				frame.backdrop:SetFrameLevel(frame:GetFrameLevel() - 1)
			else
				frame.backdrop:SetFrameLevel(0)
			end
			if TYPE == "LSM30_Font" then
				frame.backdrop:SetPoint("TOPLEFT", 20, -17)
			elseif TYPE == "LSM30_Sound" then
				frame.backdrop:SetPoint("TOPLEFT", 20, -17)
				widget.soundbutton:SetParent(frame.backdrop)
				widget.soundbutton:ClearAllPoints()
				widget.soundbutton:SetPoint('LEFT', frame.backdrop, 'LEFT', 2, 0)
			elseif TYPE == "LSM30_Statusbar" then
				frame.backdrop:SetPoint("TOPLEFT", 20, -17)
				widget.bar:ClearAllPoints()
				widget.bar:SetPoint('TOPLEFT', frame.backdrop, 'TOPLEFT', 2, -2)
				widget.bar:SetPoint('BOTTOMRIGHT', frame.backdrop, 'BOTTOMRIGHT', -2, 2)
				widget.bar:SetParent(frame.backdrop)
			elseif TYPE == "LSM30_Border" or TYPE == "LSM30_Background" then
				frame.backdrop:SetPoint("TOPLEFT", 42, -16)
			end

			frame.backdrop:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 2, -2)
		end
		button:SetParent(frame.backdrop)
		text:SetParent(frame.backdrop)
		button:HookScript('OnClick', function(this, button)
			local self = this.obj
			if self.dropdown then
				self.dropdown:CreateBD()
			end
		end)		
	elseif TYPE == "EditBox" then
		local frame = widget.editbox
		local button = widget.button
		-- frame:S.StripTextures()
		S.Kill(_G[frame:GetName()..'Left'])
		S.Kill(_G[frame:GetName()..'Middle'])
		S.Kill(_G[frame:GetName()..'Right'])
		S.ReskinInput(frame)
		button:ClearAllPoints()
		button:SetPoint("RIGHT", frame, "RIGHT", -7, 0)
		button:SetParent(frame)
		S.Reskin(button)
	elseif TYPE == "Button" then
		local frame = widget.frame
		S.Reskin(frame)
	elseif TYPE == "Slider" then
		local frame = widget.slider
		local editbox = widget.editbox
		local lowtext = widget.lowtext
		local hightext = widget.hightext
		local HEIGHT = 12

		S.StripTextures(frame)
		frame:CreateBD(0)
		frame:SetHeight(HEIGHT)
		-- local slider = CreateFrame("Frame", nil, frame)
		-- slider:SetPoint("TOPLEFT", frame:GetThumbTexture())
		-- slider:SetPoint("BOTTOMRIGHT", frame:GetThumbTexture())
		local slider = frame:GetThumbTexture()
		slider:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
		slider:SetBlendMode("ADD")
		
		-- S.CreateBD(slider, 0)
		-- frame:SetThumbTexture(C["media"].blank)
		-- frame:GetThumbTexture():SetGradientAlpha("VERTICAL", 0, 0, 0, .3, .35, .35, .35, .35)
		-- frame:GetThumbTexture():SetSize(HEIGHT-2,HEIGHT-2)

		editbox:CreateBD(0)
		editbox.SetBackdropColor = dummy
		editbox.SetBackdropBorderColor = dummy
		editbox:SetHeight(15)
		editbox:SetPoint("TOP", frame, "BOTTOM", 0, -1)
		
		local tex = editbox:CreateTexture(nil, "BACKGROUND")
		tex:SetPoint("TOPLEFT")
		tex:SetPoint("BOTTOMRIGHT")
		tex:SetTexture(DB.aurobackdrop)
		tex:SetGradientAlpha("VERTICAL", 0, 0, 0, .3, .35, .35, .35, .35)

		lowtext:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 2, -2)
		hightext:SetPoint("TOPRIGHT", frame, "BOTTOMRIGHT", -2, -2)


	--[[elseif TYPE == "ColorPicker" then
		local frame = widget.frame
		local colorSwatch = widget.colorSwatch
	]]
	end
	return oldRegisterAsWidget(self, widget)
end

local oldRegisterAsContainer = AceGUI.RegisterAsContainer

AceGUI.RegisterAsContainer = function(self, widget)
	local TYPE = widget.type
	if TYPE == "ScrollFrame" then
		local frame = widget.scrollbar
		S.StripTextures(frame)
		S.ReskinScroll(frame)
	elseif TYPE == "InlineGroup" or TYPE == "TreeGroup" or TYPE == "TabGroup" or TYPE == "SimpleGroup" or TYPE == "Frame" or TYPE == "DropdownGroup" then
		local frame = widget.content:GetParent()
		frame:CreateBD(0)
		if TYPE == "Frame" then
			S.StripTextures(frame)
			for i=1, frame:GetNumChildren() do
				local child = select(i, frame:GetChildren())
				if child:GetObjectType() == "Button" and child:GetText() then
					S.Reskin(child)
				else
					S.StripTextures(child)
				end
			end
			--frame:CreateSD()
			--frame:CreateBD()
			S.SetBD(frame)
		end		
		
		if widget.treeframe then
			widget.treeframe:CreateBD(.0)
			frame:SetPoint("TOPLEFT", widget.treeframe, "TOPRIGHT", 1, 0)
		end

		if TYPE == "TabGroup" then
			local oldCreateTab = widget.CreateTab
			widget.CreateTab = function(self, id)
				local tab = oldCreateTab(self, id)
				S.StripTextures(tab)			
				return tab
			end
		end
	end
	return oldRegisterAsContainer(self, widget)
end