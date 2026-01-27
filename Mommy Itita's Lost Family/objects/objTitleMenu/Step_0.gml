// Get Input
up_key = keyboard_check_pressed( vk_up );
down_key = keyboard_check_pressed( vk_down );
accept_key = keyboard_check_pressed( vk_enter );

// Store number of options in current menu
op_length = array_length(option[menu_level])

// Move in the menu
pos += down_key - up_key;
if ( pos >= op_length ) { pos = 0; };
if ( pos < 0 ) { pos = op_length-1; };

// Using the options
if ( accept_key && !instance_exists(objPauser))
{
	var _sml = menu_level;
	
	switch(menu_level)
	{
		// Main Menu
		case 0:
			switch(pos)
			{
				//Start Game
				case 0:
					room_goto_next();
					break
				//Settings
				case 1:
					menu_level = 1;
					break
				//Quit
				case 2:
					game_end();
					break
			}
		break
		
		//Settings
		case 1:
			switch(pos)
			{
				//Window Size
				case 0:
					break
				//Master Volume
				case 1:
					break
				//Music Volume
				case 2:
					break
				//SFX Volume
				case 3:
					break
				//Back
				case 4:
					menu_level = 0;
					break
			}
	}
	
	// Set pos back
	if ( _sml != menu_level )
	{
		pos = 0;
	}
	// Correct option legth
	op_length = array_length(option[menu_level])
}