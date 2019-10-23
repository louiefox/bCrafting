
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName		= "Crafting Bench"
ENT.Category		= "bCrafting"
ENT.Author			= "Brick Wall"
ENT.AutomaticFrameAdvance = true
ENT.Spawnable		= false

function ENT:SetupDataTables()
	self:NetworkVar( "Int", 0, "Health" )
	self:NetworkVar( "Int", 1, "UseCooldown" )
end

ENT.BenchHealth = 100