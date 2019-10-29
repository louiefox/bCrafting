BCRAFTING.CONFIG = {}
BCRAFTING.CONFIG.DisplayDist3D2D = 100000

BCRAFTING.CONFIG.Resources = {}
BCRAFTING.CONFIG.Resources["Wood"] = "models/gibs/wood_gib01b.mdl"
BCRAFTING.CONFIG.Resources["Plastic"] = "models/props_junk/garbage_plasticbottle003a.mdl"
BCRAFTING.CONFIG.Resources["Metal"] = "models/props_debris/metal_panelchunk02d.mdl"


BCRAFTING.CONFIG.General = {
    Name = "General Crafting",
    Items = {}
}

BCRAFTING.CONFIG.General.Items[1] = {
    Name = "50 Health",
    Description = "Gives you 50 health!",
    Model = "models/healthvial.mdl",
    Resource = { ["Plastic"] = 2, ["Metal"] = 5 },
    onCraft = function( ply )
        ply:SetHealth( math.Clamp( ply:Health()+50, 0, 100 ) )
    end
}
BCRAFTING.CONFIG.General.Items[2] = {
    Name = "75 Health",
    Description = "Gives you 75 health!",
    Model = "models/items/healthkit.mdl",
    Resource = { ["Plastic"] = 2, ["Metal"] = 7 },
    onCraft = function( ply )
        ply:SetHealth( math.Clamp( ply:Health()+75, 0, 100 ) )
    end
}
BCRAFTING.CONFIG.General.Items[3] = {
    Name = "100 Health",
    Description = "Gives you 100 health!",
    Model = "models/items/healthkit.mdl",
    Resource = { ["Plastic"] = 4, ["Metal"] = 8 },
    onCraft = function( ply )
        ply:SetHealth( math.Clamp( ply:Health()+100, 0, 100 ) )
    end
}
BCRAFTING.CONFIG.General.Items[4] = {
    Name = "50 Armor",
    Description = "Gives you 50 armor!",
    Model = "models/items/battery.mdl",
    Resource = { ["Plastic"] = 2, ["Metal"] = 10 },
    onCraft = function( ply )
        ply:SetArmor( math.Clamp( ply:Armor()+50, 0, 100 ) )
    end
}
BCRAFTING.CONFIG.General.Items[5] = {
    Name = "75 Armor",
    Description = "Gives you 75 armor!",
    Model = "models/items/battery.mdl",
    Resource = { ["Plastic"] = 4, ["Metal"] = 10 },
    onCraft = function( ply )
        ply:SetArmor( math.Clamp( ply:Armor()+75, 0, 100 ) )
    end
}
BCRAFTING.CONFIG.General.Items[6] = {
    Name = "100 Armor",
    Description = "Gives you 100 armor!",
    Model = "models/items/battery.mdl",
    Resource = { ["Plastic"] = 10, ["Metal"] = 10 },
    onCraft = function( ply )
        ply:SetArmor( math.Clamp( ply:Armor()+100, 0, 100 ) )
    end
}

BCRAFTING.CONFIG.Weapons = {
    Name = "Weapon Crafting",
    Items = {}
}

BCRAFTING.CONFIG.Weapons.Items[1] = {
    Name = "Shotgun",
    Description = "Gives you a shotgun!",
    Model = "models/weapons/w_shotgun.mdl",
    Resource = { ["Plastic"] = 10, ["Metal"] = 15 },
    WeaponClass = "weapon_shotgun"
}
BCRAFTING.CONFIG.Weapons.Items[2] = {
    Name = "9mm Pistol",
    Description = "Gives you a pisol!",
    Model = "models/weapons/w_pistol.mdl",
    Resource = { ["Plastic"] = 10, ["Metal"] = 10 },
    WeaponClass = "weapon_pistol"
}
BCRAFTING.CONFIG.Weapons.Items[3] = {
    Name = "Crossbow",
    Description = "Gives you a crossbow!",
    Model = "models/weapons/w_crossbow.mdl",
    Resource = { ["Plastic"] = 1, ["Metal"] = 1 },
    WeaponClass = "weapon_crossbow"
}