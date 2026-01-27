/// @param text_id
function scrGameText(_text_id){

switch(_text_id)
{
	
	
	
	case "plant 1":
		scrText("I'm a plant Robert.");
		scrText("Kill me.");
			scrOption("Yes", "plant 1 - yes");
			scrOption("No", "plant 1 - no");
		break;
		// Yes
		case "plant 1 - yes":
			scrText("Thank god.");
			break
		// No
		case "plant 1 - no":
			scrText("I shall do not forget.");
			break

	case "plant 2":
		scrText("I'm a plant David.");
		scrText("I'm happy and alive.");
		break;
		
		
		
}

}