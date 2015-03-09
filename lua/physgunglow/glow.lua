include( "util.lua" )

local function DrawGlow( ply )
	local pos = ply:EyePos()
	local ang = ply:EyeAngles()
	local light = DynamicLight( ply:EntIndex() )
	if ( light ) then

		--Ordinary Bullshit
		light.Brightness = 1
		light.Size = 128
		light.Decay = 256
		light.Style = 0

		--Check the weapon.
		local weapon = ply:GetActiveWeapon():GetClass()
		local col = ply:GetWeaponColor()
		if ( PhysgunGlow.Weapons[ weapon ].color != nil ) then
			col = PhysgunGlow.Weapons[ weapon ].color
		end
		light.r = col[1] * 255
		light.g = col[2] * 255
		light.b = col[3] * 255

		light.Pos = pos + ( ang:Forward() * 32 )
		if ( ply == LocalPlayer() ) then
			if ( !hook.Call( "ShouldDrawLocalPlayer", GAMEMODE, ply ) ) then
				light.Pos = pos
			end
		end

		--Die!!!!!!!11
		light.DieTime = CurTime() + 1
	end
end

hook.Add( "RenderScene", "PhysgunGlow", function()

	--Loop through players
	for _, ply in pairs ( player.GetAll() ) do

		if ( PhysgunGlow.ShouldGlow( ply ) ) then
			DrawGlow( ply )
		end

	end
end )