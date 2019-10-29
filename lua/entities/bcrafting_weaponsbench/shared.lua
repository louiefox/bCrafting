
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName		= BCRAFTING.CONFIG.Weapons.Name
ENT.Category		= "bCrafting"
ENT.Author			= "Brick Wall"
ENT.AutomaticFrameAdvance = true
ENT.Spawnable		= true

function ENT:SetupDataTables()
	self:NetworkVar( "Int", 0, "Health" )
	self:NetworkVar( "Int", 1, "UseCooldown" )
end

ENT.BenchHealth = 100