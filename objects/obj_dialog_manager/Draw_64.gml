switch (state) {
    case State.NULL:
        break;

	case State.STARTING:

		set_main_position();
		set_name_position();
	
		reset_fade_timer();
		state = State.FADING_IN;
		
		
		break;
	
    case State.FADING_IN:
		show_debug_message("Fading in main");
		fade_in(pos_main);
		show_debug_message("Fading in name");
		fade_in(pos_name);
		
		fade_timer--;
		if (fade_timer <= 0) {
			reset_fade_timer();
			state = State.TYPING;
		}
		
        break;

    case State.TYPING:
		draw_dialog_box(pos_main);
		draw_dialog_box(pos_name);
		draw_text_ext(pos_name.start_pos.x + box_border_horizontal, pos_name.start_pos.y + box_border_vertical, current_speaker, font_get_size(draw_get_font()) + 3, pos_name.end_pos.x - pos_name.start_pos.x - box_border_horizontal * 2);
		draw_text_ext(pos_main.start_pos.x + box_border_horizontal, pos_main.start_pos.y + box_border_vertical, current_text, font_get_size(draw_get_font()) + 3, pos_main.end_pos.x - pos_main.start_pos.x - box_border_horizontal * 2);
        break;

    case State.WAITING:
        break;

    case State.FADING_OUT:
        break;
}