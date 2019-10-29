--[[
	Created by Patrick Ratzow (sleeppyy).

	Credits goes to Metamist for his previously closed source library Wyvern,
		CupCakeR for various improvements, the animated texture VGUI panel, and misc.
]]
 
local PANEL = {}

function PANEL:Init()
  self.notifications = {}
end

function PANEL:Notification(title, backgroundCol, textCol)
  local pnl = self:Add("DPanel")
  pnl:AlphaTo(255, 0.1)
  pnl:SetZPos(2)
  pnl.uniqueID = SysTime()
  pnl.Paint = function(pnl, w, h)
    local x, y = pnl:LocalToScreen(0, 0)

    BSHADOWS.BeginShadow()
     draw.RoundedBox(6, x, y, w, h, ColorAlpha(backgroundCol, pnl.alpha))
    BSHADOWS.EndShadow(1, 2, 2, 200, 0, 0)
  end

  pnl.title = vgui.Create("DLabel", pnl)
  pnl.title:Dock(FILL)
  pnl.title:DockMargin(8, 8, 8, 8)
  pnl.title:SetTextColor(textCol or color_white)
  pnl.title:SetFont("XeninUI.Notification")
  pnl.title:SetText(title)

  surface.SetFont(pnl.title:GetFont())
  local tw, th = surface.GetTextSize(pnl.title:GetText())
  pnl:SetSize(tw + 16, th + 16)

  local offset = 16
  for i, v in pairs(self.notifications) do
    offset = offset + v:GetTall() + 8
  end

  pnl:SetPos(self:GetWide() - 16 - pnl:GetWide(), offset)

  table.insert(self.notifications, pnl)

  timer.Simple(3, function()
    if (!IsValid(pnl)) then return end

    pnl:AlphaTo(0, 0.2)

    timer.Simple(0.2, function()
      if (!IsValid(pnl)) then return end

      for i, v in pairs(self.notifications) do
        if (v.uniqueID != pnl.uniqueID) then continue end

        table.remove(self.notifications, i)

        pnl:Remove()
      end
    end)
  end)
end

vgui.Register("XeninUI.Panel", PANEL)