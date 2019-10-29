--[[
	Created by Patrick Ratzow (sleeppyy).

	Credits goes to Metamist for his previously closed source library Wyvern,
		CupCakeR for various improvements, the animated texture VGUI panel, and misc.
]]

XeninUI:CreateFont("XeninUI.TextEntry", 18)

local PANEL = {}

AccessorFunc(PANEL, "m_backgroundColor", "BackgroundColor")
AccessorFunc(PANEL, "m_rounded", "Rounded")
AccessorFunc(PANEL, "m_placeholder", "Placeholder")
AccessorFunc(PANEL, "m_textColor", "TextColor")
AccessorFunc(PANEL, "m_placeholderColor", "PlaceholderColor")
AccessorFunc(PANEL, "m_iconColor", "IconColor")

function PANEL:Init()
	self:SetBackgroundColor(XeninUI.Theme.Navbar)
	self:SetRounded(6)
	self:SetPlaceholder("")
	self:SetTextColor(Color(205, 205, 205))
	self:SetPlaceholderColor(Color(120, 120, 120))
	self:SetIconColor(self:GetTextColor())

	self.textentry = vgui.Create("DTextEntry", self)
	self.textentry:Dock(FILL)
	self.textentry:DockMargin(8, 8, 8, 8)
	self.textentry:SetFont("XeninUI.TextEntry")
	self.textentry:SetDrawLanguageID(false)
	self.textentry.Paint = function(pnl, w, h)
		local col = self:GetTextColor()
		
		pnl:DrawTextEntryText(col, col, col)

		if ((pnl:GetText() == "" or #pnl:GetText() == 0)and !pnl:HasFocus()) then
			draw.SimpleText(self:GetPlaceholder() or "", pnl:GetFont(), 0, pnl:IsMultiline() and 8 or h / 2, self:GetPlaceholderColor(), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
	end
end

function PANEL:SetFont(str)
	self.textentry:SetFont(str)
end

function PANEL:GetText()
	return self.textentry:GetText()
end

function PANEL:SetText(str)
	self.textentry:SetText(str)
end

function PANEL:SetMultiLine(state)
	self:SetMultiline(state)
	self.textentry:SetMultiline(state)
end

function PANEL:SetIcon(icon)
	if (!IsValid(self.icon)) then
		self.icon = vgui.Create("DButton", self)
		self.icon:SetText("")
		self.icon:Dock(RIGHT)
		self.icon:DockMargin(-5, 10, 10, 10)
		self.icon.Paint = function(pnl, w, h)
			surface.SetDrawColor(self:GetIconColor())
			surface.SetMaterial(pnl.mat)
			surface.DrawTexturedRect(0, 0, w, h)
		end
		self.icon.DoClick = function(pnl)
			self.textentry:RequestFocus()
		end
	end

	self.icon.mat = icon
end

function PANEL:PerformLayout(w, h)
	if (IsValid(self.icon)) then
		self.icon:SetWide(self.icon:GetTall())
	end
end

function PANEL:OnMousePressed()
	self.textentry:RequestFocus()
end

function PANEL:Paint(w, h)
	draw.RoundedBox(self:GetRounded(), 0, 0, w, h, self:GetBackgroundColor())
end

vgui.Register("XeninUI.TextEntry", PANEL)