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
	page_number = array_length(text);
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
textb_img += textb_img_spd;
txtb_spr_w = sprite_get_width(textb_spr);
txtb_spr_h = sprite_get_height(textb_spr);
// Draw back
draw_sprite_ext( textb_spr, textb_img, textbox_x+text_x_offset[page], textbox_y, textbox_width/txtb_spr_w, textbox_height/txtb_spr_h, 0, c_white, 1 );

// Draw text
var _drawtext = string_copy(text[page], 1, draw_char);
draw_text_ext( textbox_x+text_x_offset[page]+border, textbox_y+border, _drawtext, line_sep, line_width )