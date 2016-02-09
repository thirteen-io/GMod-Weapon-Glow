local enable = CreateConVar( "physgun_glow_enable", "1", FCVAR_ARCHIVE, "Enable physgun wall glow." )
local maxdist = CreateConVar( "physgun_glow_maxdist", "8192", FCVAR_ARCHIVE, "Maximum render distance for physgun wall glow." )

PhysgunGlow.Weapons = {
	weapon_physcannon = {
		color = { 1, 0.78, 0 }
	},
	weapon_crossbow = {
		color = { 1, 0.4, 0 }
	},
	weapon_rpg = {
		color = { 0.2, 0, 0 }
	},
	weapon_medkit = {
		color = { 0.025, 0.05, 0 }
	},
	weapon_physgun = {
		color = nil
	}
}

PhysgunGlow.ShouldGlow = function( ply )

	--These are used in the CVar section
	local view = hook.Call( "CalcView", GAMEMODE, LocalPlayer(), LocalPlayer():EyePos(), LocalPlayer():EyeAngles(), LocalPlayer():GetFOV(), 4, 30000 )

	--CVar (Max Dist)
	if ( !enable:GetBool() ) then return false end
	if ( ply:GetPos():Distance( (view and view.origin) or ply:GetPos() ) > maxdist:GetInt() ) then return false end

	--Weapon specific
	local weapon_e = ply:GetActiveWeapon()
	if ( weapon_e == nil ) then return false end
	if ( !weapon_e:IsValid() ) then return false end
	local weapon = weapon_e:GetClass()
	if ( PhysgunGlow.Weapons[ weapon ] == nil ) then return false end

	--Addon support
	if ( hook.Call( "ShouldEmitWeaponGlow", GAMEMODE, ply ) == false ) then return false end

	--Core GMod
	if ( !ply:GetActiveWeapon():IsValid() ) then return false end
	if ( ply:InVehicle() ) then return false end

	return true

end
