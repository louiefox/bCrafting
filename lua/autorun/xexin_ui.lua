--[[
	Created by Patrick Ratzow (sleeppyy).

	Credits goes to Metamist for his previously closed source library Wyvern,
		CupCakeR for various improvements, the animated texture VGUI panel, and misc.
]]

XeninUI = XeninUI or {}

function XeninUI:CreateFont(name, size, weight)
	surface.CreateFont(name, {
		font = "Montserrat",
		size = size,
		weight = weight or 500
	})
end

function XeninUI:IncludeClient(path)
	if (CLIENT) then
		include("xeninui/" .. path .. ".lua")
	end

	if (SERVER) then
		AddCSLuaFile("xeninui/" .. path .. ".lua")
	end
end

function XeninUI:IncludeServer(path)
	if (SERVER) then
		include("xeninui/" .. path .. ".lua")
	end
end

function XeninUI:IncludeShared(path)
	XeninUI:IncludeServer(path)
	XeninUI:IncludeClient(path)
end

XeninUI:IncludeShared("settings/settings")

XeninUI:IncludeClient("libs/debug")
XeninUI:IncludeClient("libs/animations")
XeninUI:IncludeClient("libs/shadows")
XeninUI:IncludeClient("libs/essentials")
XeninUI:IncludeShared("libs/essentials_sh")
XeninUI:IncludeShared("libs/v0n_sh")
XeninUI:IncludeClient("libs/wyvern")
XeninUI:IncludeClient("libs/time")
XeninUI:IncludeShared("libs/promises")

XeninUI:IncludeClient("elements/button")
XeninUI:IncludeClient("elements/frame")
XeninUI:IncludeClient("elements/navbar")
XeninUI:IncludeClient("elements/sidebar")
XeninUI:IncludeClient("elements/textentry")
XeninUI:IncludeClient("elements/popup")
XeninUI:IncludeClient("elements/notifications")
XeninUI:IncludeClient("elements/avatar")
XeninUI:IncludeClient("elements/grid")
XeninUI:IncludeClient("elements/dropdown_popup")
XeninUI:IncludeClient("elements/category")
XeninUI:IncludeClient("elements/scrollpanel")
XeninUI:IncludeClient("elements/checkbox")
XeninUI:IncludeClient("elements/wyvern_scrollbar")
XeninUI:IncludeClient("elements/wyvern_scrollpanel")
XeninUI:IncludeClient("elements/query")
XeninUI:IncludeClient("elements/query_single_button")
XeninUI:IncludeClient("elements/slider")
XeninUI:IncludeClient("elements/purchase_confirmation")
XeninUI:IncludeClient("elements/panel")
XeninUI:IncludeClient("elements/animated_texture")
XeninUI:IncludeClient("elements/tooltip")
XeninUI:IncludeClient("elements/sidebar_animated")

/*
-- Icarus lib stuff
XeninUI:IncludeClient("libs/icarus/compability")
XeninUI:IncludeClient("libs/icarus/3d_ui/tdui_lib")
XeninUI:IncludeClient("libs/icarus/3d_ui/base")
XeninUI:IncludeClient("libs/icarus/3d_ui/button")
XeninUI:IncludeClient("libs/icarus/3d_ui/line")
XeninUI:IncludeClient("libs/icarus/3d_ui/navbar")
XeninUI:IncludeClient("libs/icarus/3d_ui/rect")
XeninUI:IncludeClient("libs/icarus/3d_ui/slider")
XeninUI:IncludeClient("libs/icarus/3d_ui/text")
XeninUI:IncludeClient("libs/icarus/3d_ui/view_list")
*/

XeninUI:IncludeServer("server/notification")
XeninUI:IncludeServer("server/database")
