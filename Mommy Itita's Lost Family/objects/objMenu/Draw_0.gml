if (!active) exit;// Nao exibe se desativado!

draw_sprite_stretched(boxSpr, 0, x, y, widthFull, heightFull);
draw_set_colour(c_white);
draw_set_font(global.font_main);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var _desc = (description != -1);
var _scrollPush = max(0, hover - (visibleOptionsMax-1));

for ( l = 0; l < (visibleOptionsMax + _desc); l++ )
{
	var _hoverMargin = 0
	
	if ( l >= array_length(options) ) { break };
	draw_set_colour(c_white);
	if ( (l == 0) && (_desc) )
	{
		draw_text( x+xmargin, y+ymargin, description );
	} else
	{
		var _optionToShow = l-_desc+_scrollPush;
		var _str = options[_optionToShow][0];
		if ( hover == _optionToShow - _desc )
		{
			_hoverMargin += 4;
			draw_set_colour(c_yellow);
		}
		if ( options[_optionToShow][3] == false )
		{
			draw_set_colour(c_gray);
		}
		draw_text( x+xmargin+_hoverMargin, y+ymargin + l*heightLine, _str );
	}
}
//Se tiver ponteiro aqui q vai o codigo pra desenhar ele, pode ser so um draw sprite na posição e o y (y+ (hover - _scrollPush)*heightLine)+7)
if ( (visibleOptionsMax < array_length(options)) && (hover < array_length(options)-1) )
{
	draw_sprite(sprDownArrow, 0, x + widthFull*0.5, y + heightFull - 7);
}