function NewEncounter(_enemies, _bg){
	if ( !instance_exists(objBattle) )
	{
		instance_create_depth
		(
			camera_get_view_x(view_camera[0]),
			camera_get_view_y(view_camera[0]),
			-99999999,
			objBattle,
			{
				enemies: _enemies, creator: id, battleBackground: _bg
			}
		);
	}
	
};