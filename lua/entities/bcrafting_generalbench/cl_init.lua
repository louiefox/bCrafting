include('shared.lua')

function ENT:Draw()
	self:DrawModel()
end

net.Receive( "bCrafting_Net_UseBench", function( len, ply )
	if( not IsValid( bCrafting_Menu ) ) then
		bCrafting_Menu = vgui.Create( "brickscrafting_vgui_bench" )
		bCrafting_Menu:SetSize( ScrW()*0.5, ScrH()*0.5 )
		bCrafting_Menu:Center()
		bCrafting_Menu:MakePopup()
		bCrafting_Menu:SetTitle( "Crafting Bench" )
	end
end )