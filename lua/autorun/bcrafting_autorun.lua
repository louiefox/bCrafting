BCRAFTING = {}

AddCSLuaFile( "bcrafting_config.lua" )
include( "bcrafting_config.lua" )

--[[ CREATES RESOURCES ]]--
for k, v in pairs( BCRAFTING.CONFIG.Resources ) do
    local ENT = {}
    ENT.Type = "anim"
    ENT.Base = "bcrafting_resource"
    
    ENT.PrintName = k
    ENT.Category		= "bCrafting"
    ENT.Author			= "Brick Wall"
    
    ENT.Spawnable = true
    ENT.AdminSpawnable = true
    
    ENT.ResourceType = k

    scripted_ents.Register( ENT, "bcrafting_resource_" .. string.Replace( string.lower( k ), " ", "" ) )
end

if( SERVER ) then
    util.AddNetworkString( "bCrafting_Net_Notify" )
    function BCRAFTING.Notify( ply, Message )
        net.Start( "bCrafting_Net_Notify" )
            net.WriteString( Message )
        net.Send( ply )
    end

    local Resources = {}
    for k, v in pairs( BCRAFTING.CONFIG.Resources ) do
        table.insert( Resources, k )
    end

    hook.Add( "InitPostEntity", "bCrafting_InitPostEntity", function()
        if not file.IsDir("bcrafting_resources", "DATA") then
			file.CreateDir("bcrafting_resources", "DATA")
		end
		
		bCrafting_Resources = {}
		if( file.Exists( "bcrafting_resources/".. string.lower(game.GetMap()) ..".txt", "DATA" ) ) then
			bCrafting_Resources = ( util.JSONToTable( file.Read( "bcrafting_resources/".. string.lower(game.GetMap()) ..".txt", "DATA" ) ) )
        end
        
        timer.Create( "bCrafting_ResourcePlacer", 120, 0, function()
            for k, v in pairs( bCrafting_Resources ) do
                local ThePosition = string.Explode( ";", v )
                local TheVector = Vector(ThePosition[1], ThePosition[2], ThePosition[3])
                local TheAngle = Angle(tonumber(ThePosition[4]), ThePosition[5], ThePosition[6])

                local resource = table.Random( Resources )

                local NewEnt = ents.Create( "bcrafting_resource_" .. string.Replace( string.lower( resource ), " ", "" ) )
                if( not IsValid( NewEnt ) ) then continue end
                NewEnt:SetPos( TheVector )
                NewEnt:SetAngles( TheAngle )
                NewEnt:Spawn()
            end
        end )
    end)

    concommand.Add( "resource_set", function( ply, cmd, args )
        if( not ply:IsSuperAdmin() ) then
            BCRAFTING.Notify( ply, "You must be a super admin!" )
            return
        end

        bCrafting_Resources = bCrafting_Resources or {}

        local EntVector = string.Explode(" ", tostring(ply:GetPos()))
        local EntAngles = string.Explode(" ", tostring(ply:GetAngles()))
        
        local Position = ""..(EntVector[1])..";"..(EntVector[2])..";"..(EntVector[3])..";"..(EntAngles[1])..";"..(EntAngles[2])..";"..(EntAngles[3])..""
        
        table.insert( bCrafting_Resources, Position )
        
        file.Write("bcrafting_resources/".. string.lower(game.GetMap()) ..".txt", util.TableToJSON( bCrafting_Resources ), "DATA")
        BCRAFTING.Notify( ply, "Position for resource set!" )
    end )

    function BCRAFTING.SpawnItem( bench, class )
        local weapon = ents.Create("spawned_weapon")

        local weaponAng = bench:GetAngles()
        local weaponPos = bench:GetAngles():Up() * 40

        local defaultClip, clipSize
        local wepTable = weapons.Get(class)

        if not wepTable then
            weapon:Remove()
            return
        end

        if wepTable.Primary then
            defaultClip = wepTable.Primary.DefaultClip
            clipSize = wepTable.Primary.ClipSize
        end

        local model = wepTable.WorldModel

        weapon:SetWeaponClass(class)
        weapon:SetModel(model)
        weapon.ammoadd = defaultClip
        weapon.clip1 = clipSize
        weapon:SetPos(bench:GetPos() + weaponPos)
        weapon:SetAngles(weaponAng)
        weapon.nodupe = true
        weapon:Spawn()
    end
elseif( CLIENT ) then
    net.Receive( "bCrafting_Net_Notify", function()
        local Message = net.ReadString()

        if( not Message ) then return end

        notification.AddLegacy( Message, 1, 3 )
    end )
end