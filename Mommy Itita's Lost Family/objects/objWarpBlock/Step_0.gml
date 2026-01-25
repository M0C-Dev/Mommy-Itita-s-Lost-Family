if ( place_meeting( x, y, objPlayer ) && !instance_exists(objWarp) )
{
	var warp = instance_create_depth( 0, 0, -676767, objWarp );
	warp.target_rm = target_rm
	warp.target_x = target_x;
	warp.target_y = target_y
	warp.target_face = target_face
}