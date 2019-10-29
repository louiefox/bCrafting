include('shared.lua')

function ENT:Draw()
	self:DrawModel()

    local Pos = self:GetPos()
    local Ang = self:GetAngles()

    Ang:RotateAroundAxis(Ang:Up(), 90)
	Ang:RotateAroundAxis(Ang:Forward(), 90)

	local Distance = LocalPlayer():GetPos():DistToSqr( self:GetPos() )

	local AlphaMulti = 1-(Distance/BCRAFTING.CONFIG.DisplayDist3D2D)
	if( Distance < BCRAFTING.CONFIG.DisplayDist3D2D ) then
		surface.SetAlphaMultiplier( AlphaMulti )
	
		local zOffset = 3+self:OBBMaxs().z
		cam.Start3D2D(Pos - Ang:Right() * 88, Ang, 0.035)
			XeninUI:DrawNPCOverhead( self, { sin = 2, xOffset = 30 } )
		cam.End3D2D()
		surface.SetAlphaMultiplier( 1 )
	end
end

XeninUI:CreateFont("XeninUI.Crafting.Button", 24)
XeninUI:CreateFont("XeninUI.Crafting.Description", 17)
XeninUI:CreateFont("XeninUI.Crafting.DescriptionS", 14)
net.Receive( "bCrafting_Net_UseBench", function( len, ply )
	local Bench = net.ReadEntity()
	local Resources = net.ReadTable() or {}

	if( IsValid( Bench ) and not IsValid( bCrafting_Menu ) ) then
		bCrafting_Menu = vgui.Create( "XeninUI.Frame" )
		bCrafting_Menu:SetSize( ScrW()*0.4, ScrH()*0.5 )
		bCrafting_Menu:Center()
		bCrafting_Menu:MakePopup()
		bCrafting_Menu:SetTitle( BCRAFTING.CONFIG.General.Name )
		bCrafting_Menu:SetAlpha( 0 )
		bCrafting_Menu:AlphaTo( 255, 0.1, 0 )
		bCrafting_Menu.closeBtn.DoClick = function()
			bCrafting_Menu:SetKeyboardInputEnabled( false )
			bCrafting_Menu:SetMouseInputEnabled( false )
			bCrafting_Menu:AlphaTo( 0, 0.1, 0, function() 
				bCrafting_Menu:Remove()
			end )
		end

		local ScrollPanel = vgui.Create( "XeninUI.Scrollpanel.Wyvern", bCrafting_Menu )
		ScrollPanel:Dock( FILL )
		ScrollPanel:DockMargin( 15, 15, 15, 15 )

		local ResourcesList = vgui.Create( "DPanel", ScrollPanel )
		ResourcesList:Dock( TOP )
		ResourcesList:DockMargin( 0, 0, 15, 15 )
		ResourcesList:SetTall( 30 )
		local ResourceString = ""
		for k, v in pairs( Resources ) do
			if( not BCRAFTING.CONFIG.Resources[k] ) then continue end

			ResourceString = ResourceString .. (v or 0) .. " " .. k .. "	"
		end
		ResourcesList.Paint = function( self2, w, h )
			draw.RoundedBox( 6, 0, 0, w, h, XeninUI.Theme.Primary )

			if( ResourceString != "" ) then
				draw.SimpleText( ResourceString, "XeninUI.Crafting.Description", 15, h/2, Color(255,255,255,255), 0, TEXT_ALIGN_CENTER )
			else
				draw.SimpleText( "No resources, collect some from around the map!", "XeninUI.Crafting.Description", 15, h/2, Color(255,255,255,255), 0, TEXT_ALIGN_CENTER )
			end
		end

		for k, v in pairs( BCRAFTING.CONFIG.General.Items ) do
			local CraftEntry = vgui.Create( "DPanel", ScrollPanel )
			CraftEntry:Dock( TOP )
			CraftEntry:DockMargin( 0, 0, 15, 15 )
			CraftEntry:SetTall( 125 )
			CraftEntry.Paint = function( self2, w, h )
				draw.RoundedBox( 6, 0, 0, w, h, XeninUI.Theme.Primary )
				draw.RoundedBoxEx( 6, 0, 0, 6, h, XeninUI.Theme.Accent, true, false, true, false )

				draw.SimpleText( v.Name, "XeninUI.Crafting.Button", h+30, 20, Color(255,255,255,255) )
				draw.SimpleText( v.Description, "XeninUI.Crafting.Description", h+30, 42, Color(255,255,255,255) )
			end

			surface.SetFont( "XeninUI.Crafting.DescriptionS" )
			local TextX, TextY = surface.GetTextSize( "10 Wood" )

			local CraftEntryResourceBack = vgui.Create( "DPanel", CraftEntry )
			CraftEntryResourceBack:SetPos( 155, 62 )
			CraftEntryResourceBack:SetSize( 1000, TextY )
			CraftEntryResourceBack.Paint = function( self2, w, h ) end

			for k, v in pairs( v.Resource ) do
				if( not BCRAFTING.CONFIG.Resources[k] ) then continue end

				local CraftEntryRes = vgui.Create( "DLabel", CraftEntryResourceBack )
				CraftEntryRes:Dock( LEFT )
				CraftEntryRes:DockMargin( 0, 0, 15, 0 )
				CraftEntryRes:SetText( string.Comma(v or 0) .. " " .. k )
				CraftEntryRes:SetFont( "XeninUI.Crafting.DescriptionS" )
				if( (Resources[k] or 0) >= v ) then
					CraftEntryRes:SetTextColor( XeninUI.Theme.Green )
				else
					CraftEntryRes:SetTextColor( Color(255,255,255,255) )
				end
				CraftEntryRes:SizeToContents()
			end

			local CraftEntryButton = vgui.Create( "DButton", CraftEntry )
			CraftEntryButton:Dock( RIGHT )
			CraftEntryButton:SetWide( 150 )
			CraftEntryButton:SetText( "" )
			CraftEntryButton.BackgroundCol = XeninUI.Theme.Navbar
			CraftEntryButton.Paint = function( self2, w, h )
				draw.RoundedBoxEx( 6, 0, 0, w, h, self2.BackgroundCol, false, true, false, true )

				draw.SimpleText( "Craft", "XeninUI.Crafting.Button", w/2, h/2, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
			CraftEntryButton.OnCursorEntered = function(pnl)
				pnl:LerpColor("BackgroundCol", XeninUI.Theme.Accent )
			end
			CraftEntryButton.OnCursorExited = function(pnl)
				pnl:LerpColor("BackgroundCol", XeninUI.Theme.Navbar )
			end
			CraftEntryButton.DoClick = function(pnl)
				net.Start( "bCrafting_Net_CraftItem" )
					net.WriteEntity( Bench )
					net.WriteInt( k, 32 )
				net.SendToServer()
			end

			local CraftEntryIcon = vgui.Create( "DModelPanel", CraftEntry )
			CraftEntryIcon:Dock( LEFT )
			CraftEntryIcon:DockMargin( 25, 6, 6, 6 )
			CraftEntryIcon:SetWide( CraftEntry:GetTall()-12 )
			CraftEntryIcon:SetModel( v.Model )		
			local mn, mx = CraftEntryIcon.Entity:GetRenderBounds()
			local size = 0
			size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
			size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
			size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )

			CraftEntryIcon:SetFOV( 45 )
			CraftEntryIcon:SetCamPos( Vector( size, size, size ) )
			CraftEntryIcon:SetLookAt( ( mn + mx ) * 0.5 )
			function CraftEntryIcon:LayoutEntity( Entity ) return end
		end
	end
end )