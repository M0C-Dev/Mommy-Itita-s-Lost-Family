if ( place_meeting( x, y, objPlayer ) && !instance_exists(objWarp) )
{
	criar_warp(target_rm, target_x, target_y, target_face);
}