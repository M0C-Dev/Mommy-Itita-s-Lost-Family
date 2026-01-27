depth = -670670670

// Textbox parameters
textbox_width = 216;
textbox_height = 56;
border = 8;
line_sep = 12;
line_width = textbox_width - border*2;
textb_spr = sprNineSlice;
textb_img = 0;
textb_img_spd = 0; // Caso seja animado, seria a velocidade dividio por 60 (Ex: 8/60)

//The text
page = 0;
page_number = 0;

text[0] = "";

text_length[0] = string_length(text[0]);
draw_char = 0;
text_spd = 1;

//Options
option[0] = "";
option_link_id = -1;
option_pos = 0;
option_number = 0;
option_visual_indicator = sprSelection;

setup = false;

