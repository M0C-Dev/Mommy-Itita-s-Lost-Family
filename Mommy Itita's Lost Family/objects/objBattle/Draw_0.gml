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
#macro COLUMN_MP 208

//Draw headings
draw_set_font(global.font_smaller);
draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_colour(c_gray);
draw_text(x+COLUMN_ENEMY, y+164, "ENEMY");
draw_text(x+COLUMN_NAME, y+164, "NAME");
draw_text(x+COLUMN_HP, y+164, "HP");
draw_text(x+COLUMN_MP, y+164, "MP");

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
	
	//MP
	if ( _char.mp < (_char.mpMax*0.5) ) { draw_set_colour(c_orange); };
	if ( _char.mp <= 0 ) { draw_set_colour(c_red); };
	draw_text(x+COLUMN_MP, y+168+(i*11), string(_char.mp) + "/" + string(_char.mpMax));
	
	draw_set_colour(c_white);
}