AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()
	self:SetModel( "models/workshop/workbench/workbench_weapons.mdl" )
	
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end

	self:SetUseCooldown( 0 )
	self:SetSkin( 1 )
	self.Resources = {}
end

util.AddNetworkString( "bCrafting_Net_WUseBench" )
function ENT:Use( ply )
	if( IsValid( ply ) and ply:GetEyeTrace().Entity == self ) then
		if( self:GetUseCooldown() > CurTime() ) then return end

		self:SetUseCooldown( CurTime()+1 )

		net.Start( "bCrafting_Net_WUseBench" )
			net.WriteEntity( self )
			net.WriteTable( self.Resources )
		net.Send( ply )
	end
end

function ENT:OnTakeDamage( dmgInfo )
	self:SetHealth( math.Clamp( self:Health()-dmgInfo:GetDamage(), 1, self.BenchHealth ) )
	if( self:Health() <= 0 ) then
		self:Remove()
	end
end

function ENT:StartTouch( ent )
	if( ent.ResourceType and BCRAFTING.CONFIG.Resources[ent.ResourceType] ) then
		self.Resources[ent.ResourceType] = (self.Resources[ent.ResourceType] or 0)+1
		ent:Remove()
	end
end

util.AddNetworkString( "bCrafting_Net_WCraftItem" )
net.Receive( "bCrafting_Net_WCraftItem", function( len, ply )
	local Bench = net.ReadEntity()
	local Key = net.ReadInt( 32 )
	
	if( not Bench or not Key ) then return end
	if( not IsValid( Bench ) or not BCRAFTING.CONFIG.Weapons.Items[Key] ) then return end
	
	local Item = BCRAFTING.CONFIG.Weapons.Items[Key]
	local HasItems = true
	for k, v in pairs( Item.Resource ) do
		if( not Bench.Resources[k] or Bench.Resources[k] < v ) then
			HasItems = false
			break
		end
	end

	if( HasItems ) then
		if( Item.WeaponClass ) then
			local weapon = ents.Create( Item.WeaponClass )
			if not IsValid( weapon ) then return end
			weapon:SetPos( Bench:GetPos() + Vector( 0, 0, 50 ) )
			weapon:Spawn()
		end

		-- Don't take items if failed to create weapon
		for k, v in pairs( Item.Resource ) do
			Bench.Resources[k] = math.max( (Bench.Resources[k] or 0)-v, 0 )
		end

		BCRAFTING.Notify( ply, "You have crafted the item '" .. Item.Name .. "'." )
	else
		BCRAFTING.Notify( ply, "You don't have enough resources to craft this item!" )
	end
end )
