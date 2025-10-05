if (keyboard_lastkey != vk_nokey && keyboard_check_pressed(keyboard_lastkey)) {
	switch keyboard_lastkey {
		case vk_f1:
			room_goto(rm_title);
			break;
		case vk_f2:
			room_goto(rm_space);
			break;
		case vk_f3:
			room_goto(rm_world);
			break;
		case vk_f4:
			show_debug_message(global.dialogue.dialogue[? "joe"][? "neutral"][? "1"]);
			show_debug_message(json_stringify(global.dialogue.dialogue));
			break;
	}
}