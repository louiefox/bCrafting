--[[
	Created by Patrick Ratzow (sleeppyy).

	Credits goes to Metamist for his previously closed source library Wyvern,
		CupCakeR for various improvements, the animated texture VGUI panel, and misc.
]]
 
-- Should branding be enabled on every frame?
XeninUI.Branding = false -- Material("xenin/pantheon.png", "smooth")

-- Materials
XeninUI.Materials = {
	CloseButton = Material("xenin/closebutton.png", "noclamp smooth"),
	Search = Material("xenin/search.png", "noclamp smooth")
}
-- Animation
XeninUI.TransitionTime = 0.15

-- UI theme
XeninUI.Theme = {
	Primary = Color(48, 48, 48),
	Navbar = Color(41, 41, 41),
	Background = Color(30, 30, 30),
	Accent = Color(41, 128, 185),
	OrangeRed = Color(228, 104, 78),
	Red = Color(230, 58, 64),
	Green = Color(46, 204, 113),
	Blue = Color(41, 128, 185),
	Yellow = Color(201, 176, 15),
	Purple = Color(142, 68, 173)
}

XeninUI.Frame = {
	Width = 960,
	Height = 720
}