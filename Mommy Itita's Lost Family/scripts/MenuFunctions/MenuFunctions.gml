/// @desc Menu - makes a menu, options provided in the form [["name", function, argument], [...]]
function Menu( _x, _y, _options, _description = -1, _width = undefined, _height = undefined )
{
	with ( instance_create_depth( _x, _y, -9999999999999, objMenu ) )
	{
		options = _options;
		description = _description;
		var _optionsCount = array_length(_options);
		visibleOptionsMax = _optionsCount;
		
		//Set up size
		xmargin = 8;
		ymargin = 8;
		iconSize = 8;
		iconPadding = 2;
		iconOffset = 0;
		
		//Checa os icones e caso tenha seta certinha a distancia
		CalcIcons();
		
		draw_set_font(global.font_main);
		heightLine = 16;
		
		//Auto width
		CalcWidth();
		
		//Auto height
		if ( _height == undefined )
		{
			height = heightLine * ( _optionsCount + (description != -1) );
			heightFull = height + ymargin*2
		}
		else
		{
			heightFull = _height;
			//Scrolling?
			if ( heightLine * ( _optionsCount + (description != -1) > _height - (ymargin*2) ))
			{
				scrolling = true;
				visibleOptionsMax = ( _height - ymargin * 2 ) div heightLine;
			}
		}
	}
}

function SubMenu(_options)
{
	//Store old options in array and increase submenu level
	optionsAbove[subMenuLevel] = options;
	subMenuLevel++;
	options = _options;
	CalcIcons();
	CalcWidth();
	hover = 0;
}

function MenuGoBack()
{
	subMenuLevel--;
	options = optionsAbove[subMenuLevel];
	//recaclcula icones
	CalcIcons();
	CalcWidth();
	hover = 0;
}

function MenuSelectAction( _user, _action )
{
	with (objMenu) { active = false };
	//Activate the targetting cursor if needed, or simply begin the action
	with (objBattle)
	{
		if ( _action.targetRequired )
		{
			with ( cursor )
			{
				active = true;
				activeAction = _action;
				targetAll = _action.targetAll;
				if ( targetAll == MODE.VARIES ) { targetAll =  true };
				activeUser = _user;
				
				//which side by default
				if ( _action.targetEnemyByDefault )
				{
					targetIndex = 0;
					targetSide = objBattle.enemyUnits;
					activeTarget = objBattle.enemyUnits[targetIndex];
				}
				else
				{
					targetSide = objBattle.partyUnits;
					activeTarget = activeUser;
					var _findSelf = function(_element)
					{
						return ( _element == activeTarget )
					}
					targetIndex = array_find_index(objBattle.partyUnits, _findSelf);
				}
			}
		}
		else
		{
			
			BeginAction( _user, _action, -1 )
			with (objMenu) { instance_destroy(); }
		}
	}
}

function CalcIcons()
{
	hasIcons = false;
	
	//Acess each option and see if it has an icon
	for (var i = 0; i < array_length(options); i++)
	{
		if (array_length(options[i]) > 4 && options[i][4] != -1)
		{
			hasIcons = true;
			break;
		}
	}

	if (hasIcons)
	{
		iconOffset = iconSize + iconPadding;
	}
	else
	{
		iconOffset = 0;
	}
}

function CalcWidth()
{
	draw_set_font(global.font_main);
	width = 1;

	if (description != -1)
	{
		width = max( width, string_width(description) );
	}

	for (var i = 0; i < array_length(options); i++)
	{
		width = max( width, string_width(options[i][0]) + iconOffset );
	}
	widthFull = width + xmargin * 2;
	//Evitar bugs
	widthFull = max(widthFull, 1);
};