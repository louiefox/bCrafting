--[[
	Created by Patrick Ratzow (sleeppyy).

	Credits goes to Metamist for his previously closed source library Wyvern,
		CupCakeR for various improvements, the animated texture VGUI panel, and misc.
]]
 
function XeninUI:Debounce(name, wait, func)
  if (timer.Exists("_debounce." .. name)) then
    timer.Remove("_debounce." .. name)
  end

  timer.Create("_debounce." .. name, wait, 1, function()
    func()

    timer.Remove("_debounce." .. name)
  end)
end

if SERVER then
	util.AddNetworkString( "XeninUI.FullClientInit" )

	net.Receive( "XeninUI.FullClientInit", function( len, p )
		if p.XeninUI_FullClientInit then
			ErrorNoHalt( p:Nick() .. " -> already did init? Maybe sent net msg manually?\n" )
			return
		end

		hook.Run( "Xenin.OnClientFullInit", p )
		
		p.XeninUI_FullClientInit = true
	end )
else
	hook.Add( "SetupMove", "Xenin.FullClientInit", function()
		timer.Simple( 15, function()
			net.Start( "XeninUI.FullClientInit" )
			net.SendToServer()
		end )

		hook.Remove( "SetupMove", "Xenin.FullClientInit" )
	end )
end

function XeninUI:LerpColor(fract, from, to)
	return Color(
		Lerp(fract, from.r, to.r),
		Lerp(fract, from.g, to.g),
		Lerp(fract, from.b, to.b),
		Lerp(fract, from.a or 255, to.a or 255)
	)
end

function XeninUI:GetAngleBetweenTwoVectors(a, b)
	local vec = (a - b):GetNormalized()
	local ang = vec:Angle()

	return ang
end

function XeninUI:GetVector2DDistance(a, b)
	-- Euclidean length
  return math.sqrt(
		(a.x - b.x) ^ 2 + 
		(a.y - b.y) ^ 2
	)
end

-- Converts to easing
function XeninUI:LerpVector(frac, from, to)
	local newFract = XeninUI:Ease(frac, 0, 1, 1)

	return LerpVector(newFract, from, to)
end

if SERVER then
	util.AddNetworkString( "XeninUI.OSTime" )

	hook.Add( "PlayerInitialSpawn", "XeninUI.OSTime", function( p )
		net.Start( "XeninUI.OSTime" )
			net.WriteFloat( os.time() )
			net.WriteFloat( CurTime() )
		net.Send( p )
	end )
else
	os._SVRDiff = 0
	
	net.Receive( "XeninUI.OSTime", function()
		local ostime = net.ReadFloat()
		local ct = net.ReadFloat()

		os._SVRDiff = os.time() - ostime + ct - CurTime()
	end )

	function os.ServerTime()
		return os.time() - os._SVRDiff
	end

	local function TCMD()
		print(os.time(),os.ServerTime(),os.date("%I:%M %p",os.time()),os.date("%I:%M %p",os.ServerTime()))
	end
	concommand.Add("print_servertime",TCMD)
end
