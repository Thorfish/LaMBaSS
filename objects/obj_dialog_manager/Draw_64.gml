switch (state) {
    case State.NULL:
		global.game_state = GameState.OVERWORLD;
        break;

	case State.STARTING:
		global.game_state = GameState.DIALOG;
		set_main_position();
		set_name_position();
	
		state = State.FADING_IN;
		
		break;
	
    case State.FADING_IN:
		fade_in(pos_main);
		fade_in(pos_name);
		
		if (is_timer_reached_fade(10)) {
			normalise_position(pos_main, "in");
			normalise_position(pos_name, "in");
			state = State.TYPING;
		}
		
        break;

    case State.TYPING:
		draw_dialog_box(pos_main);
		draw_dialog_box(pos_name);

		display_text(current_speaker, pos_name);
		
		if (interact) {
			update_text_to_display();
		} else {
			update_text_to_display(0);
		}
		
		display_text(text_to_display, pos_main);
		
		if (string_length(current_text) <= 0) {
			state = State.WAITING;
		}
		
        break;

    case State.WAITING:
		draw_dialog_box(pos_main);
		draw_dialog_box(pos_name);
		display_text(current_speaker, pos_name);
		display_text(text_to_display, pos_main);
		// display down arrow
		
		
		if (interact) {
			speaker_status = set_next_line();
			if (speaker_status == "same") {
				state = State.TYPING;
			} else {
				state = State.FADING_OUT;
			}
		}
		
        break;

    case State.FADING_OUT:
		fade_out(pos_main);
		fade_out(pos_name);
		
		if (is_timer_reached_fade(10)) {
			normalise_position(pos_main, "out");
			normalise_position(pos_name, "out");
			
			if (speaker_status == "diff") {
				state = State.STARTING;
			} else {
				state = State.ENDING;
			}
		}
        break;
	case State.ENDING:
		state = State.NULL;
		break;
}