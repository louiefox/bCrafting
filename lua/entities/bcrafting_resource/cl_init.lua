include('shared.lua')

function ENT:Draw()
	self:DrawModel()
end

BCRAFTING_RESOURCE_ENTS = {}
function ENT:Initialize()
	BCRAFTING_RESOURCE_ENTS[self:EntIndex()] = self
end

function ENT:OnRemove()
	BCRAFTING_RESOURCE_ENTS[self:EntIndex()] = nil
end

XeninUI:CreateFont("XeninUI.Crafting.Resource", 32)
hook.Add( "HUDPaint", "bCraftingHooks_HUDPaint_DrawResource", function()
	for k, v in pairs( BCRAFTING_RESOURCE_ENTS ) do
		local Distance = LocalPlayer():GetPos():DistToSqr( v:GetPos() )

		local AlphaMulti = 1-(Distance/BCRAFTING.CONFIG.DisplayDist3D2D)

		if( Distance < BCRAFTING.CONFIG.DisplayDist3D2D ) then
			local zOffset = 20
			local x = v:GetPos().x
			local y = v:GetPos().y
			local z = v:GetPos().z
			local pos = Vector(x,y,z+zOffset)
			local pos2d = pos:ToScreen()

			surface.SetAlphaMultiplier( AlphaMulti )
				local str = v.ResourceType or "NIL"
				surface.SetFont("XeninUI.Crafting.Resource")
				local width, height = surface.GetTextSize(str)
				width = width + 40 + 64
			
				local h = height*2.2
			
				XeninUI:DrawRoundedBox( h/2, pos2d.x-(width/2), pos2d.y-(h/2), width, h, Color(0, 0, 0, 255 * 0.95))
				draw.SimpleText( str, "XeninUI.Crafting.Resource", pos2d.x, pos2d.y, Color(225, 225, 225, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

				local Border = 3
				XeninUI:MaskInverse( function()
					XeninUI:DrawRoundedBox( h/2, pos2d.x-(width/2) + Border, pos2d.y-(h/2) + Border, width - (2*Border), h - (2*Border), Color(0, 0, 0, 255) )
				end, function()
					XeninUI:DrawRoundedBox( h/2, pos2d.x-(width/2), pos2d.y-(h/2), width, h, XeninUI.Theme.Accent)
				end)
			surface.SetAlphaMultiplier( 1 )
		end
	end
end )