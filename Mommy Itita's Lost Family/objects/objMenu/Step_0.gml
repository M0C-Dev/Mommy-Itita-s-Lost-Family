// Get Input
up_key = keyboard_check_pressed( vk_up );
down_key = keyboard_check_pressed( vk_down );
accept_key = keyboard_check_pressed( vk_enter );
escape_key = keyboard_check_pressed( vk_escape );

if ( active )
{
	// Move in the menu
	hover += down_key - up_key;
	if ( hover > array_length(options)-1 ) { hover = 0; };
	if ( hover < 0 ) { hover = array_length(options)-1; };
	
	//Execute selected option
	if ( accept_key )
	{
		if ( (array_length(options[hover]) > 1 ) && ( options[hover][3] == true ) )
		{
			if ( options[hover][1] != -1 )
			{
				var _func = options[hover][1];
				if ( options[hover][2] != -1 )
				{
					script_execute_ext( _func, options[hover][2] );
				} else { _func() };
			}
		}
	}
	
	if ( escape_key )
	{
		if ( subMenuLevel > 0 )
		{
			MenuGoBack();
		}
	}
	
}
