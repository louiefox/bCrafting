AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

function ENT:Initialize()
	self:SetModel( "models/workshop/workbench/workbench.mdl" )
	
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

util.AddNetworkString( "bCrafting_Net_UseBench" )
function ENT:Use( ply )
	if( IsValid( ply ) and ply:GetEyeTrace().Entity == self ) then
		if( self:GetUseCooldown() > CurTime() ) then return end

		self:SetUseCooldown( CurTime()+1 )

		net.Start( "bCrafting_Net_UseBench" )
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

util.AddNetworkString( "bCrafting_Net_CraftItem" )
net.Receive( "bCrafting_Net_CraftItem", function( len, ply )
	local Bench = net.ReadEntity()
	local Key = net.ReadInt( 32 )
	
	if( not Bench or not Key ) then return end
	if( not IsValid( Bench ) or not BCRAFTING.CONFIG.General.Items[Key] ) then return end
	
	local Item = BCRAFTING.CONFIG.General.Items[Key]
	local HasItems = true
	for k, v in pairs( Item.Resource ) do
		if( not Bench.Resources[k] or Bench.Resources[k] < v ) then
			HasItems = false
			break
		end
	end

	if( HasItems ) then
		for k, v in pairs( Item.Resource ) do
			Bench.Resources[k] = math.max( (Bench.Resources[k] or 0)-v, 0 )
		end

		if( Item.onCraft ) then
			Item.onCraft( ply )
		end

		if( Item.WeaponClass ) then
			ply:Give( Item.WeaponClass )
		end

		BCRAFTING.Notify( ply, "You have crafted the item '" .. Item.Name .. "'." )
	else
		BCRAFTING.Notify( ply, "You don't have enough resources to craft this item!" )
	end
end )
