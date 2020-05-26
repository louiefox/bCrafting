BCRAFTING.CONFIG = {}
BCRAFTING.CONFIG.DisplayDist3D2D = 100000

BCRAFTING.CONFIG.Resources = {}
BCRAFTING.CONFIG.Resources["Wood"] = "models/gibs/wood_gib01b.mdl"
BCRAFTING.CONFIG.Resources["Plastic"] = "models/props_junk/garbage_plasticbottle003a.mdl"
BCRAFTING.CONFIG.Resources["Metal"] = "models/props_debris/metal_panelchunk02d.mdl"
BCRAFTING.CONFIG.Resources["Machinery"] = "models/props_canal/mattpipe.mdl"
BCRAFTING.CONFIG.Resources["Glass"] = "models/props_lab/box01a.mdl"
BCRAFTING.CONFIG.Resources["Gunpowder"] = "models/props_lab/jar01a.mdl"
BCRAFTING.CONFIG.Resources["Rope"] = "models/props_lab/box01a.mdl"
BCRAFTING.CONFIG.Resources["Elastic Material"] = "models/props_lab/box01a.mdl"
BCRAFTING.CONFIG.Resources["Explosive Material"] = "models/props_junk/plasticbucket001a.mdl"

BCRAFTING.CONFIG.General = {
    Name = "General Crafting",
    Items = {}
}

BCRAFTING.CONFIG.General.Items[1] = {
    Name = "Rope Restraint",
    Description = "",
    Model = "models/weapons/w_toolgun.mdl",
    Resource = { ["Rope"] = 2, ["Metal"] = 3 },
	WeaponClass = "weapon_cuff_rope"
}

BCRAFTING.CONFIG.General.Items[2] = {
    Name = "Rope Leash",
    Description = "",
    Model = "models/weapons/w_toolgun.mdl",
    Resource = { ["Rope"] = 3, ["Metal"] = 4 },
	WeaponClass = "weapon_leash_rope"
}

BCRAFTING.CONFIG.General.Items[3] = {
    Name = "Basic Handcuffs",
    Description = "",
    Model = "models/weapons/w_toolgun.mdl",
    Resource = { ["Metal"] = 5 },
	WeaponClass = "weapon_cuff_standard"
}

BCRAFTING.CONFIG.General.Items[4] = {
    Name = "Elastic Restraint",
    Description = "",
    Model = "models/weapons/w_toolgun.mdl",
    Resource = { ["Elastic Material"] = 2, ["Metal"] = 3 },
	WeaponClass = "weapon_cuff_elastic"
}

BCRAFTING.CONFIG.General.Items[5] = {
    Name = "Elastic Leash",
    Description = "",
    Model = "models/weapons/w_toolgun.mdl",
    Resource = { ["Elastic Material"] = 3, ["Metal"] = 4 },
	WeaponClass = "weapon_leash_elastic"
}

BCRAFTING.CONFIG.General.Items[6] = {
    Name = "Shackles",
    Description = "",
    Model = "models/weapons/w_toolgun.mdl",
    Resource = { ["Metal"] = 7 },
	WeaponClass = "weapon_cuff_shackles"
}

BCRAFTING.CONFIG.General.Items[7] = {
    Name = "Lockpick",
    Description = "",
    Model = "models/weapons/w_crowbar.mdl",
    Resource = { ["Metal"] = 2 },
	WeaponClass = "lockpick"
}

BCRAFTING.CONFIG.Weapons = {
    Name = "Weapon Crafting",
    Items = {}
}

BCRAFTING.CONFIG.Weapons.Items[1] = {
    Name = "M1911",
    Description = "Uses .45 ACP Ammo",
    Model = "models/weapons/cw_pist_m1911.mdl",
    Resource = { ["Wood"] = 2, ["Metal"] = 3, ["Machinery"] = 1 },
    WeaponClass = "cw_m1911"
}

BCRAFTING.CONFIG.Weapons.Items[2] = {
    Name = "MR-96",
    Description = "Uses .44 Magnum Ammo",
    Model = "models/weapons/w_357.mdl",
    Resource = { ["Plastic"] = 1, ["Metal"] = 4, ["Machinery"] = 1 },
    WeaponClass = "cw_mr96"
}

BCRAFTING.CONFIG.Weapons.Items[3] = {
    Name = "P99",
    Description = "Uses 9x19mm Ammo",
    Model = "models/weapons/w_pist_p228.mdl",
    Resource = { ["Plastic"] = 3, ["Metal"] = 3, ["Machinery"] = 1 },
    WeaponClass = "cw_p99"
}

BCRAFTING.CONFIG.Weapons.Items[4] = {
    Name = "Deagle",
    Description = "Uses .50 AE Ammo",
    Model = "models/weapons/w_pist_deagle.mdl",
    Resource = { ["Plastic"] = 2, ["Metal"] = 5, ["Machinery"] = 1 },
    WeaponClass = "cw_deagle"
}

BCRAFTING.CONFIG.Weapons.Items[5] = {
    Name = "Remington 870",
    Description = "Uses 12 Gauge Ammo",
    Model = "models/weapons/cw2_super_shorty.mdl",
    Resource = { ["Plastic"] = 2, ["Metal"] = 5, ["Machinery"] = 2 },
    WeaponClass = "cw_shorty"
}

BCRAFTING.CONFIG.Weapons.Items[6] = {
    Name = "Benelli M3",
    Description = "Uses 12 Gauge Ammo",
    Model = "models/weapons/w_cstm_m3super90.mdl",
    Resource = { ["Plastic"] = 4, ["Metal"] = 6, ["Machinery"] = 2 },
    WeaponClass = "cw_m3super90"
}

BCRAFTING.CONFIG.Weapons.Items[7] = {
    Name = "MAC-11",
    Description = "Uses 9x17mm Ammo",
    Model = "models/weapons/w_cst_mac11.mdl",
    Resource = { ["Metal"] = 5, ["Machinery"] = 3 },
    WeaponClass = "cw_mac11"
}

BCRAFTING.CONFIG.Weapons.Items[8] = {
    Name = "HK MP5",
    Description = "Uses 9x19mm Ammo",
    Model = "models/weapons/w_smg_mp5.mdl",
    Resource = { ["Plastic"] = 4, ["Metal"] = 4, ["Machinery"] = 3 },
    WeaponClass = "cw_mp5"
}

BCRAFTING.CONFIG.Weapons.Items[9] = {
    Name = "UMP .45",
    Description = "Uses .45 ACP Ammo",
    Model = "models/weapons/w_smg_ump45.mdl",
    Resource = { ["Plastic"] = 4, ["Metal"] = 5, ["Machinery"] = 3 },
    WeaponClass = "cw_ump45"
}

BCRAFTING.CONFIG.Weapons.Items[10] = {
    Name = "AK-74",
    Description = "Uses 5.45x39mm Ammo",
    Model = "models/weapons/w_rif_ak47.mdl",
    Resource = { ["Wood"] = 4, ["Metal"] = 5, ["Machinery"] = 6 },
    WeaponClass = "cw_ak74"
}

BCRAFTING.CONFIG.Weapons.Items[11] = {
    Name = "AR-15",
    Description = "Uses 5.56x45mm Ammo",
    Model = "models/weapons/w_rif_m4a1.mdl",
    Resource = { ["Plastic"] = 5, ["Metal"] = 4, ["Machinery"] = 6 },
    WeaponClass = "cw_ar15"
}

BCRAFTING.CONFIG.Weapons.Items[12] = {
    Name = "FN SCAR-H",
    Description = "Uses 7.62x51mm Ammo",
    Model = "models/cw2/rifles/w_scarh.mdl",
    Resource = { ["Plastic"] = 4, ["Metal"] = 7, ["Machinery"] = 6 },
    WeaponClass = "cw_scarh"
}

BCRAFTING.CONFIG.Weapons.Items[13] = {
    Name = "M14 EBR",
    Description = "Uses 7.62x51mm Ammo",
    Model = "models/weapons/w_cstm_m14.mdl",
    Resource = { ["Plastic"] = 4, ["Metal"] = 8, ["Machinery"] = 7 },
    WeaponClass = "cw_m14"
}

BCRAFTING.CONFIG.Weapons.Items[14] = {
    Name = "M249",
    Description = "Uses 5.56x45mm Ammo",
    Model = "models/weapons/cw2_0_mach_para.mdl",
    Resource = { ["Plastic"] = 6, ["Metal"] = 10, ["Machinery"] = 8 },
    WeaponClass = "cw_m249_official"
}

BCRAFTING.CONFIG.Weapons.Items[15] = {
    Name = "9x19mm Ammo",
    Description = "",
    Model = "models/Items/BoxMRounds.mdl",
    Resource = { ["Gunpowder"] = 2, ["Metal"] = 1 },
    WeaponClass = "cw_ammo_9x19"
}

BCRAFTING.CONFIG.Weapons.Items[16] = {
    Name = "9x17mm Ammo",
    Description = "",
    Model = "models/Items/BoxMRounds.mdl",
    Resource = { ["Gunpowder"] = 2, ["Metal"] = 1 },
    WeaponClass = "cw_ammo_9x17"
}

BCRAFTING.CONFIG.Weapons.Items[17] = {
    Name = ".45 ACP Ammo",
    Description = "",
    Model = "models/Items/BoxMRounds.mdl",
    Resource = { ["Gunpowder"] = 2, ["Metal"] = 1 },
    WeaponClass = "cw_ammo_45acp"
}

BCRAFTING.CONFIG.Weapons.Items[18] = {
    Name = "5.45x39mm Ammo",
    Description = "",
    Model = "models/Items/BoxMRounds.mdl",
    Resource = { ["Gunpowder"] = 3, ["Metal"] = 1 },
    WeaponClass = "cw_ammo_545x39"
}

BCRAFTING.CONFIG.Weapons.Items[19] = {
    Name = ".44 Magnum Ammo",
    Description = "",
    Model = "models/Items/BoxMRounds.mdl",
    Resource = { ["Gunpowder"] = 3, ["Metal"] = 1 },
    WeaponClass = "cw_ammo_44magnum"
}

BCRAFTING.CONFIG.Weapons.Items[20] = {
    Name = "12 Gauge Ammo",
    Description = "",
    Model = "models/Items/BoxMRounds.mdl",
    Resource = { ["Gunpowder"] = 3, ["Metal"] = 1 },
    WeaponClass = "cw_ammo_12gauge"
}

BCRAFTING.CONFIG.Weapons.Items[21] = {
    Name = "5.56x45mm Ammo",
    Description = "",
    Model = "models/Items/BoxMRounds.mdl",
    Resource = { ["Gunpowder"] = 3, ["Metal"] = 1 },
    WeaponClass = "cw_ammo_556x45"
}

BCRAFTING.CONFIG.Weapons.Items[22] = {
    Name = ".50 AE Ammo",
    Description = "",
    Model = "models/Items/BoxMRounds.mdl",
    Resource = { ["Gunpowder"] = 3, ["Metal"] = 1 },
    WeaponClass = "cw_ammo_50ae"
}

BCRAFTING.CONFIG.Weapons.Items[23] = {
    Name = "7.62x51mm Ammo",
    Description = "",
    Model = "models/Items/BoxMRounds.mdl",
    Resource = { ["Gunpowder"] = 4, ["Metal"] = 1 },
    WeaponClass = "cw_ammo_762x51"
}

BCRAFTING.CONFIG.Weapons.Items[24] = {
    Name = "CQB Sights",
    Description = "",
    Model = "models/Items/BoxSRounds.mdl",
    Resource = { ["Plastic"] = 2, ["Metal"] = 1, ["Glass"] = 1 },
    WeaponClass = "cw_attpack_sights_cqb"
}

BCRAFTING.CONFIG.Weapons.Items[25] = {
    Name = "Mid-Range Sight",
    Description = "",
    Model = "models/Items/BoxSRounds.mdl",
    Resource = { ["Plastic"] = 1, ["Metal"] = 2, ["Glass"] = 2 },
    WeaponClass = "cw_attpack_sights_midrange"
}

BCRAFTING.CONFIG.Weapons.Items[26] = {
    Name = "Long-Range Sights",
    Description = "",
    Model = "models/Items/BoxSRounds.mdl",
    Resource = { ["Plastic"] = 1, ["Metal"] = 3, ["Glass"] = 3 },
    WeaponClass = "cw_attpack_sights_longrange"
}

BCRAFTING.CONFIG.Weapons.Items[27] = {
    Name = "Sniper Sight",
    Description = "",
    Model = "models/Items/BoxSRounds.mdl",
    Resource = { ["Plastic"] = 2, ["Metal"] = 3, ["Glass"] = 4 },
    WeaponClass = "cw_attpack_sights_sniper"
}

BCRAFTING.CONFIG.Weapons.Items[28] = {
    Name = "Suppressors",
    Description = "",
    Model = "models/Items/BoxSRounds.mdl",
    Resource = { ["Plastic"] = 4, ["Metal"] = 4},
    WeaponClass = "cw_attpack_suppressors"
}
