--[[
	Created by Patrick Ratzow (sleeppyy).

	Credits goes to Metamist for his previously closed source library Wyvern,
		CupCakeR for various improvements, the animated texture VGUI panel, and misc.
]]
 
function XeninUI:InvokeSQL(str, name, successFunc, errFunc)
	local p = XeninUI.Promises.new()

	local successDetour = function(result)
		MsgC(XeninUI.Theme.Yellow, "[SQL] ", color_white, name, XeninUI.Theme.Green, " Success!\n")
	end
	local _successFunc = function(result)
		successDetour(result)
		p:resolve(result)
	end
	local errDetour = function(err)
		MsgC(XeninUI.Theme.Yellow, "[SQL] ", color_white, name, XeninUI.Theme.Red, " Failure!\n")
	end
	local _errFunc = function(err)
		errDetour(err)
		p:reject(err)
	end

	MySQLite.query(str, _successFunc, _errFunc)

	return p
end
