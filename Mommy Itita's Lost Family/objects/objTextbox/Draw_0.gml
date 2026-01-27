// -------------------------- Variables -------------------------- 
accept_key = keyboard_check_pressed( vk_enter );

textbox_x = camera_get_view_x(view_camera[0]);
textbox_y = camera_get_view_y(view_camera[0]) + 152;

// -------------------------- Setup -------------------------- 
if ( !setup )
{
	setup = true;
	
	draw_set_font(global.font_main);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	
	//Loop on pages
	for ( var _p = 0; _p < page_number; _p++; )
	{
		// Quantos caracteres tem em cada pagina
		text_length[_p] = string_length(text[_p]);
		
		// Get x position for the textbox
			// Nenhum personagem, centralizado.
			text_x_offset[_p] = 32;
	}
}

// -------------------------- Typing -------------------------- 
if ( draw_char < text_length[page] )
{
	draw_char += text_spd;
	draw_char = clamp(draw_char, 0, text_length[page]);
}

// -------------------------- Flip pages -------------------------- 
if ( accept_key )
{
	//If done, next page
	if ( draw_char == text_length[page] )
	{
		//Next page
		if ( page < page_number-1 )
		{
			page++;
			draw_char = 0;
		}
		// Destroy textbox
		else
		{
			if ( option_number > 0 )
			{
				createTextbox(option_link_id[option_pos]);
			}
			instance_destroy();
		}
	}
	// If not done typing
	else
	{
		draw_char = text_length[page];
	}
}


// -------------------------- Draw textbox -------------------------- 
var _txtb_x = textbox_x+text_x_offset[page];
var _txtb_y = textbox_y
textb_img += textb_img_spd;
txtb_spr_w = sprite_get_width(textb_spr);
txtb_spr_h = sprite_get_height(textb_spr);
// Draw back
draw_sprite_ext( textb_spr, textb_img, _txtb_x, _txtb_y, textbox_width/txtb_spr_w, textbox_height/txtb_spr_h, 0, c_white, 1 );

// -------------------------- Options -------------------------- 
if ( draw_char == text_length[page] && page == page_number-1 )
{
	//Option selection
	option_pos += keyboard_check_pressed(vk_down)-keyboard_check_pressed(vk_up);
	option_pos = clamp(option_pos, 0, option_number-1);
	
	//Draw tne options
	var _op_space = 18;
	var _op_border = 8;
	var _op_distance_border = 18;
	
	for ( var op = 0; op < option_number; op++; )
	{
		//Option box
		var _o_w = string_width(option[op]) + _op_border*2;
		draw_sprite_ext( textb_spr, textb_img, _txtb_x+_op_distance_border, _txtb_y - _op_space*option_number + _op_space*op, _o_w/txtb_spr_w, (_op_space-1)/txtb_spr_h, 0, c_white, 1 );
		
		//Visual indicator
		if ( option_pos == op )
		{
			draw_sprite(option_visual_indicator, 0, _txtb_x, _txtb_y - _op_space*option_number + _op_space*op)
		}
		
		//The option text
		draw_text( _txtb_x+_op_distance_border + _op_border, _txtb_y - _op_space*option_number + _op_space*op+1, option[op] )
	}
}

// Draw text
var _drawtext = string_copy(text[page], 1, draw_char);
draw_text_ext( _txtb_x+border, _txtb_y+border, _drawtext, line_sep, line_width )