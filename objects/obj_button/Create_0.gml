enum ButtonState {
	FREE=0,
	PRESSED=1
}

buttonState = ButtonState.FREE;

function do_action() {
	switch(action) {
		case "uninitialised":
			show_debug_message("Uninitialised button pressed!");
			break;
		case "play":
			room_goto(rm_space);
			break;
		case "rules":
			show_debug_message("Rules not yet added!");
			break;
		case "exit":
			game_end();
			break;
	}
}