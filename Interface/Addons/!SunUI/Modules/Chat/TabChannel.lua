﻿--按TAB切換頻道.如果是在密語頻道則循環前面密過的人名,SHIFT+TAB反序切换频道
function ChatEdit_CustomTabPressed(self)
	if  (self:GetAttribute("chatType") == "SAY")  then
		if (GetNumPartyMembers()>0) then
			self:SetAttribute("chatType", "PARTY");
			ChatEdit_UpdateHeader(self);
		elseif (GetNumRaidMembers()>0) then
			self:SetAttribute("chatType", "RAID");
			ChatEdit_UpdateHeader(self);
		elseif (GetNumBattlefieldScores()>0) then
			self:SetAttribute("chatType", "BATTLEGROUND");
			ChatEdit_UpdateHeader(self);
		elseif (IsInGuild()) then
			self:SetAttribute("chatType", "GUILD");
			ChatEdit_UpdateHeader(self);
		else
			return;
		end
	elseif (self:GetAttribute("chatType") == "PARTY") then
		if (GetNumRaidMembers()>0) then
			self:SetAttribute("chatType", "RAID");
			ChatEdit_UpdateHeader(self);
		elseif (GetNumBattlefieldScores()>0) then
			self:SetAttribute("chatType", "BATTLEGROUND");
			ChatEdit_UpdateHeader(self);
		elseif (IsInGuild()) then
			self:SetAttribute("chatType", "GUILD");
			ChatEdit_UpdateHeader(self);
		else
			self:SetAttribute("chatType", "SAY");
			ChatEdit_UpdateHeader(self);
		end			
	elseif (self:GetAttribute("chatType") == "RAID") then
		if (GetNumBattlefieldScores()>0) then
			self:SetAttribute("chatType", "BATTLEGROUND");
			ChatEdit_UpdateHeader(self);
		elseif (IsInGuild()) then
			self:SetAttribute("chatType", "GUILD");
			ChatEdit_UpdateHeader(self);
		else
			self:SetAttribute("chatType", "SAY");
			ChatEdit_UpdateHeader(self);
		end
	elseif (self:GetAttribute("chatType") == "BATTLEGROUND") then
		if (IsInGuild) then
			self:SetAttribute("chatType", "GUILD");
			ChatEdit_UpdateHeader(self);
		else
			self:SetAttribute("chatType", "SAY");
			ChatEdit_UpdateHeader(self);
		end
	elseif (self:GetAttribute("chatType") == "GUILD") then
		self:SetAttribute("chatType", "SAY");
		ChatEdit_UpdateHeader(self);
	elseif (self:GetAttribute("chatType") == "CHANNEL") then
		if (GetNumPartyMembers()>0) then
			self:SetAttribute("chatType", "PARTY");
			ChatEdit_UpdateHeader(self);
		elseif (GetNumRaidMembers()>0) then
			self:SetAttribute("chatType", "RAID");
			ChatEdit_UpdateHeader(self);
		elseif (GetNumBattlefieldScores()>0) then
			self:SetAttribute("chatType", "BATTLEGROUND");
			ChatEdit_UpdateHeader(self);
		elseif (IsInGuild()) then
			self:SetAttribute("chatType", "GUILD");
			ChatEdit_UpdateHeader(self);
		else
			self:SetAttribute("chatType", "SAY");
			ChatEdit_UpdateHeader(self);
		end
	end
end
