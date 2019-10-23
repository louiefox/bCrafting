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
end

util.AddNetworkString( "bCrafting_Net_UseBench" )
function ENT:Use( ply )
	if( IsValid( ply ) and ply:GetEyeTrace().Entity == self ) then
		if( self:GetUseCooldown() > CurTime() ) then return end

		self:SetUseCooldown( CurTime()+1 )

		net.Start( "bCrafting_Net_UseBench" )
		net.Send( ply )
	end
end

function ENT:OnTakeDamage( dmgInfo )
	self:SetHealth( math.Clamp( self:Health()-dmgInfo:GetDamage(), 0, self.BenchHealth ) )
	if( self:Health() <= 0 ) then
		self:Remove()
	end
end

util.AddNetworkString( "BCS_Net_CraftItem" )
net.Receive( "BCS_Net_CraftItem", function( len, ply )
	local BenchType = net.ReadString()
	local ItemKey = net.ReadInt( 32 )
	
	if( not BenchType or not ItemKey ) then return end
	
	ply:CraftBCS_Inventory( BenchType, ItemKey )
end )