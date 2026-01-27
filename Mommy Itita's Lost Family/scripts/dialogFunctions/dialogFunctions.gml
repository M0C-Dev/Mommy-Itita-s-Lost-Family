/// @param text
function scrText(_text){

text[page_number] = _text;

page_number++;

}

/// @param optiom
/// @param link_id
function scrOption(_option, _link_id){
	
	option[option_number] = _option;
	option_link_id[option_number] = _link_id;
	
	option_number++;
}

/// @param text_id
function createTextbox(_text_id){
	with( instance_create_depth(0, 0, -99999, objTextbox) )
	{
	scrGameText(_text_id);
	}
}