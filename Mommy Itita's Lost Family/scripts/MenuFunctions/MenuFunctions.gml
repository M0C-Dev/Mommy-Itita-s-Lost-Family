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
		draw_set_font(global.font_main);
		heightLine = 16;
		
		//Auto width
		if ( _width = undefined ) 
		{
			width = 1;
			if ( description != -1 )
			{
				width = max( width, string_width(_description) );
			}
			for ( var i = 0; i < _optionsCount; i++ )
			{
				width = max( width, string_width(_options[i][0]) );
			}
			widthFull = width + xmargin*2;
		} else { widthFull = _width };
		
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
	hover = 0;
}

function MenuGoBack()
{
	subMenuLevel--;
	options = optionsAbove[subMenuLevel];
	hover = 0;
}

function MenuSelectAction( _user, _action )
{
	with (objMenu) { active = false }
	with (objBattle) BeginAction( _user, _action, _user )
	with (objMenu) { instance_destroy(); }
}