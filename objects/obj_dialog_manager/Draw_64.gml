switch (state) {
    case State.NULL:
        break;

	case State.STARTING:
		draw_set_font(m5x7);
		margin = 0.05;
		gui_width = display_get_gui_width();
		gui_height = display_get_gui_height();

		// Main dialog box dimensions
		v_offset_main = 0.6; // Dialog box starts x% below the top
		 
		pos_main = {
			start_pos: { x: gui_width * margin, y: gui_height * v_offset_main },
			current_pos: { x: gui_width * margin, y: gui_height * v_offset_main },
			end_pos: { x: gui_width * (1 - margin), y: gui_height * (1 - margin) },
		}
		
		// Name box dimensions
		show_debug_message("String height is: " + string(string_height(current_speaker)));
		gap_size = 30;
		box_border_size = 64;
		pos_name = {
			start_pos: { x: gui_width * margin, y: gui_height * v_offset_main - string_height(current_speaker) - box_border_size - gap_size}, 
			current_pos: { x: gui_width * margin, y: gui_height * v_offset_main - string_height(current_speaker) - box_border_size - gap_size}, 
			end_pos: { x: gui_width * margin + string_width(current_speaker) + box_border_size, y: gui_height * v_offset_main - gap_size },
		}		
		
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
		draw_text(pos_name.start_pos.x + box_border_size / 2, pos_name.start_pos.y + box_border_size / 2, current_speaker);
		draw_text(pos_main.start_pos.x + box_border_size / 2, pos_main.start_pos.y + box_border_size / 2, current_text);
        break;

    case State.WAITING:
        break;

    case State.FADING_OUT:
        break;
}