--[[
	Created by Patrick Ratzow (sleeppyy).

	Credits goes to Metamist for his previously closed source library Wyvern,
		CupCakeR for various improvements, the animated texture VGUI panel, and misc.
]]
 
local PANEL = {}

function PANEL:Init()
  self.VBar:SetWide(12)
  self.VBar:SetHideButtons(true)

  self.VBar.Paint = function(pnl, w, h)
    draw.RoundedBox(6, 0, 0, w, h, ColorAlpha(XeninUI.Theme.Navbar, 150))
  end
  self.VBar.btnGrip.Paint = function(pnl, w, h)
    draw.RoundedBox(6, 0, 0, w, h, XeninUI.Theme.Primary)
  end
end

vgui.Register("XeninUI.ScrollPanel", PANEL, "DScrollPanel")