battleState();

//Cursor control
if ( cursor.active )
{
	with (cursor)
	{
		//Input
		// Get Input
		var _up_key = keyboard_check_pressed( vk_up );
		var _down_key = keyboard_check_pressed( vk_down );
		var _left_key = keyboard_check_pressed( vk_left );
		var _right_key = keyboard_check_pressed( vk_right );

		var _key_toggle = false;
		var _key_confirm = false;
		var _key_cancel = false;
		
		confirmDelay++;
		if (confirmDelay > 1)
		{
			var _key_toggle = keyboard_check_pressed( vk_shift );
			var _key_confirm = keyboard_check_pressed( vk_enter );
			var _key_cancel = keyboard_check_pressed( vk_escape );
		}
		
		var _moveH = _right_key - _left_key;
		var _moveV = _down_key - _up_key;
		
		if (_moveH == -1) { targetSide = objBattle.partyUnits };
		if (_moveH == 1) { targetSide = objBattle.enemyUnits };
		
		//Verify target list
		if ( targetSide == objBattle.enemyUnits )
		{
			targetSide = array_filter(targetSide, function(_element,_index)
			{
				return _element.hp > 0;
			});
		}
		
		//move between targets
		if ( targetAll == false ) // single target mode
		{
			if (_moveV == -1) { targetIndex++ };
			if (_moveV == 1) { targetIndex-- };
			
			//Wrap
			var _targets = array_length(targetSide);
			if ( targetIndex < 0 ) { targetIndex = _targets - 1 };
			if ( targetIndex > (_targets - 1) ) { targetIndex = 0 };
			
			//indentify target
			activeTarget = targetSide[targetIndex];
			
			//toggle all mode
			if ( (activeAction.targetAll == MODE.VARIES) && (_key_toggle) )
			{
				targetAll = true;
			}
		} else //target all mode
		{
			activeTarget = targetSide;
			if ( (activeAction.targetAll == MODE.VARIES) && (_key_toggle) )
			{
				targetAll = false;
			}
		}
		//Confirm
		if (_key_confirm)
		{
			with (objBattle)
			{
				BeginAction(cursor.activeUser, cursor.activeAction, cursor.activeTarget);
			}
			with (objMenu)
			{
				instance_destroy();
			}
			active = false;
			confirmDelay = 0;
		}
		//cancel
		if ( (_key_cancel) && (!_key_confirm) )
		{
			with (objMenu)
			{
				active = true;
			}
			active = false;
			confirmDelay = 0;
		}
	}
}