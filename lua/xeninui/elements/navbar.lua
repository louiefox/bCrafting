--[[
	Created by Patrick Ratzow (sleeppyy).

	Credits goes to Metamist for his previously closed source library Wyvern,
		CupCakeR for various improvements, the animated texture VGUI panel, and misc.
]]
 
XeninUI:CreateFont("XeninUI.Navbar.Button", 25)

local function navbarEase(t, b, c, d)
	t = t / d
	local ts = t * t
	local tc = ts * t

	return b + c * (6 * tc * ts + -15 * ts * ts + 10 * tc)
end

local PANEL = {}

function PANEL:Init()
	self.buttons = {}
	self.panels = {}
	self.buttonsNum = {}

	self.active = 0

	self.line = self:Add("DPanel")
	self.line:SetMouseInputEnabled(false)
	self.line:SetTall(2)
	self.line.Paint = function(pnl, w, h)
		surface.SetDrawColor(XeninUI.Theme.Accent)
		surface.DrawRect(0, 0, w, h)
	end
end

function PANEL:AddTab(name, panel, tbl)
	-- This was added after a ton of add-ons has been made using this, so the method for achieveing the line animation is gonna be a bit hacky..
	self.buttonsNum[#self.buttonsNum + 1] = name
	
	self.buttons[name] = vgui.Create("DButton", self)
	if (!tbl or (tbl and !tbl.dontDock)) then
		self.buttons[name]:Dock(LEFT)
	end
	self.buttons[name]:SetText(name)
	self.buttons[name]:SetFont("XeninUI.Navbar.Button")
	self.buttons[name].textColor = Color(120, 120, 120)
	self.buttons[name].Paint = function(pnl, w, h)
		pnl:SetTextColor(pnl.textColor)
	end
	self.buttons[name].DoClick = function(pnl)
		self:SetActive(name)
	end
	self.buttons[name].OnCursorEntered = function(pnl)
		pnl:LerpColor("textColor", XeninUI.Theme.Accent)
	end
	self.buttons[name].OnCursorExited = function(pnl)
		if (self.active == name) then return end
		
		pnl:LerpColor("textColor", Color(120, 120, 120))
	end

	surface.SetFont("XeninUI.Navbar.Button")
	local tw, th = surface.GetTextSize(name)
	self.buttons[name]:SetWide(math.max(80, tw + 60))

	if (!panel) then panel = "Panel" end

	self.panels[name] = vgui.Create(panel, self.body)
	self.panels[name]:Dock(FILL)
	self.panels[name]:SetVisible(false)
end

function PANEL:FindIndex(name)
	for i, v in pairs(self.buttonsNum) do
		if (v != name) then continue end

		return i
	end
end

function PANEL:SetActive(name)
	if (self.active == name) then return end

	local instant = !IsValid(self.buttons[self.active])
	if (self.buttons[self.active]) then
		self.buttons[self.active]:LerpColor("textColor", Color(120, 120, 120))
	end

	if (self.panels[self.active]) then
		local pnl = self.panels[self.active]
		pnl.DrawAlpha = pnl.DrawAlpha or 0
		pnl.PaintOver = function(pnl, w, h)
			draw.RoundedBoxEx(6, 0, 0, w, h, ColorAlpha(XeninUI.Theme.Background, pnl.DrawAlpha), false, false, true, true)
		end
		pnl:Lerp("DrawAlpha", 255,  0.15, function()
			pnl.PaintOver = nil
			pnl:SetVisible(false)
		end)
	
		if (self.panels[name].OnSwitchedFrom) then
			self.panels[name]:OnSwitchedFrom()
		end
	end

	self.active = name
	
	if (self.buttons[name]) then
		if (instant) then
			self.buttons[name].textColor = XeninUI.Theme.Accent
			local id = self:FindIndex(name)
			local x = 0
			for i, v in ipairs(self.buttonsNum) do
				if (i >= id) then break end

				x = x + self.buttons[v]:GetWide()
			end

			self.line:SetPos(x, 56 - self.line:GetTall())
			self.line:SetWide(self.buttons[name]:GetWide())
		else
			self.buttons[name]:LerpColor("textColor", XeninUI.Theme.Accent)
			local id = self:FindIndex(name)
			local x = 0
			for i, v in ipairs(self.buttonsNum) do
				if (i >= id) then break end

				x = x + self.buttons[v]:GetWide()
			end

			self.line:LerpMoveX(x, 0.3, nil, navbarEase)
			self.line:LerpWidth(self.buttons[name]:GetWide(), 0.3, nil, navbarEase)
		end
	end

	if (self.panels[name]) then
		if (instant) then
			local pnl = self.panels[name]
			pnl:SetVisible(true)
		else
			timer.Simple(0.15, function()
				if (!IsValid(self)) then return end

				local pnl = self.panels[name]
				pnl.DrawAlpha = pnl.DrawAlpha or 255
				pnl:SetVisible(true)
				pnl.PaintOver = function(pnl, w, h)
					draw.RoundedBoxEx(6, 0, 0, w, h, ColorAlpha(XeninUI.Theme.Background, pnl.DrawAlpha), false, false, true, true)
				end
				pnl:Lerp("DrawAlpha", 0,  0.15, function()
					pnl.PaintOver = nil
				end)
			end)
		end

		if (self.panels[name].OnSwitchedTo) then
			self.panels[name]:OnSwitchedTo(name)
		end
	end

	self:SwitchedTab(name)
end

function PANEL:SwitchedTab(name)
	-- Override
end

function PANEL:GetActive()
	return self.panels[self.active]
end

function PANEL:SetBody(pnl)
	self.body = pnl:Add("Panel")
	self.body:Dock(FILL)
	self.body.Offset = 0
	self.body.PerformLayout = function(pnl, w, h)
		local num = 0
		for i, v in pairs(self.panels) do
			local x  = num * w - (pnl.Offset * w)

			v:SetSize(w, h)
			v:SetPos(x, 0)
		end
	end
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(XeninUI.Theme.Navbar)
	surface.DrawRect(0, 0, w, h)
end

vgui.Register("XeninUI.Navbar", PANEL)
