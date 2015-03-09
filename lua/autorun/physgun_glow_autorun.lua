PhysgunGlow = {}

PhysgunGlow.Print = function( msg )
	local col = Color( 0, 128, 255 )
	MsgC( col, "[Physgun Glow] " )
	MsgC( Color( 255, 255, 255 ), msg.."\n" )
end

if SERVER then
	resource.AddWorkshop( "111249028" )
else
	PhysgunGlow.Print( "Loading Physgun Glow" )
	include( "physgunglow/glow.lua" )
end
