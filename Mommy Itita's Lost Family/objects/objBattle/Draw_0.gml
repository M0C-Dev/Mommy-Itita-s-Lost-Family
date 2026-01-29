//Draw background
draw_sprite( sprBattleBackground, 0, x, y );

//Draw units in depth order
var _unitWithCurrentTurn = unitTurnOrder[turn].id;
for ( var i = 0; i < array_length(unitRenderOrder); i++ )
{
	with ( unitRenderOrder[i] )
	{
		draw_self();
	}
}

//Draw ui boxes
	//Variable Box
	var textbox_x = camera_get_view_x(view_camera[0]);
	var textbox_y = camera_get_view_y(view_camera[0]);
	var txtb_spr_w = sprite_get_width(sprNineSlice);
	var txtb_spr_h = sprite_get_height(sprNineSlice);

	draw_sprite_ext(sprNineSlice, image_index, textbox_x + 80, textbox_y + 160, 208/txtb_spr_w, 56/txtb_spr_h, 0, c_white, 1 )
	draw_sprite_ext(sprNineSlice, image_index, textbox_x, textbox_y + 160, 80/txtb_spr_w, 56/txtb_spr_h, 0, c_white, 1 )
	//draw_sprite_ext(sprNineSlice, image_index, textbox_x+32, textbox_y + 48, 72/txtb_spr_w, 72/txtb_spr_h, 0, c_white, 1 )
	
//Positions
#macro COLUMN_ENEMY 8
#macro COLUMN_NAME 88
#macro COLUMN_HP 168
#macro COLUMN_EP 208

//Draw headings
draw_set_font(global.font_smaller);
draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_colour(c_gray);
draw_text(x+COLUMN_ENEMY, y+164, "ENEMY");
draw_text(x+COLUMN_NAME, y+164, "NAME");
draw_text(x+COLUMN_HP, y+164, "HP");
draw_text(x+COLUMN_EP, y+164, "EP");

//Draw enemy names
draw_set_font(global.font_main);
draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_colour(c_white);
var _drawLimit = 3;
var _drawn = 0;
for ( var i = 0; (i < array_length(enemyUnits)) && (_drawn < _drawLimit); i++ )
{
	var _char = enemyUnits[i];
	if (_char.hp > 0)
	{
		_drawn++;
		draw_set_colour(c_white);
		if ( _char.id == _unitWithCurrentTurn ) { draw_set_colour(c_yellow); };
		draw_text(x+COLUMN_ENEMY, y+168+(i*11), _char.name);
	}
}

//Draw party
for ( var i = 0; (i < array_length(partyUnits)); i++ )
{
	draw_set_colour(c_white);
	var _char = partyUnits[i];
	
	//Name
	if ( _char.id == _unitWithCurrentTurn ) { draw_set_colour(c_yellow); };
	if ( _char.hp <= 0 ) { draw_set_colour(c_red); };
	draw_text(x+COLUMN_NAME, y+168+(i*11), _char.name);
	
	//HP
	if ( _char.hp < (_char.hpMax*0.5) ) { draw_set_colour(c_orange); };
	if ( _char.hp <= 0 ) { draw_set_colour(c_red); };
	draw_text(x+COLUMN_HP, y+168+(i*11), string(_char.hp) + "/" + string(_char.hpMax));
	
	//EP
	if ( _char.ep < (_char.epMax*0.5) ) { draw_set_colour(c_orange); };
	if ( _char.ep <= 0 ) { draw_set_colour(c_red); };
	draw_text(x+COLUMN_EP, y+168+(i*11), string(_char.ep) + "/" + string(_char.epMax));
	
	draw_set_colour(c_white);
}

//Draw target cursor
if ( cursor.active )
{
	with ( cursor )
	{
		if ( activeTarget != noone )
		{
			if (!is_array(activeTarget))
			{
				draw_sprite(sprSelector, 0, activeTarget.x, activeTarget.y);
			}
			else
			{
				draw_set_alpha(sin(get_timer()/50000)+1);
				for ( var i = 0; i < array_length(activeTarget); i++ )
				{
					draw_sprite(sprSelector, 0, activeTarget[i].x, activeTarget[i].y);
				}
				draw_set_alpha(1.0)
			}
		}
	}
}

//Draw battle text
if ( battleText != "" )
{
	var _w = string_width(battleText)+20;
	draw_sprite_stretched(sprNineSlice,0,x+144-(_w*0.5),y+0,_w,25);
	draw_set_halign(fa_center);
	draw_set_colour(c_white);
	draw_text(x+144, y+5, battleText)
}