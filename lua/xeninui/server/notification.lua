--[[
	Created by Patrick Ratzow (sleeppyy).

	Credits goes to Metamist for his previously closed source library Wyvern,
		CupCakeR for various improvements, the animated texture VGUI panel, and misc.
]]
 
util.AddNetworkString("XeninUI.Notification")

function XeninUI:Notify(ply, str, icon, duration, progressColor, textColor, markup)
  net.Start("XeninUI.Notification")
    net.WriteTable({
      str = str,
      icon = icon,
      dur = duration,
      progressCol = progressColor,
      textCol = textColor,
      markup = markup
    })
  net.Send(ply)
end