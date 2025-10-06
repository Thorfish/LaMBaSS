switch global.game_state {
	case GameState.OVERWORLD:
		overworld();
		break;
	case GameState.DIALOG:
		break;
}

function overworld() {
	/////////////////////////////////////////////////
	#region Movement
	/////////////////////////////////////////////////
	if (up) {
		y -= 5;
	}
	if (down) {
		y += 5;
	}
	if (left) {
		x -= 5;
	}
	if (right) {
		x += 5;
	}


	#endregion

	/////////////////////////////////////////////////
	#region Interact
	/////////////////////////////////////////////////

	// Update only once every x frames
	if (counter < 10) {
		counter++;
	} else {
		ds_list_clear(interactables);
		collision_circle_list(x, y, 50, obj_interactable, false, true, interactables, true);
		counter = 0;
	}

	if (interact) {
		show_debug_message("Im trying to interact");
		if (!ds_list_empty(interactables)) {
			process_interaction(self, interactables[| 0], "talk");
		}
	}

	#endregion
}

