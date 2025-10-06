if (variable_global_exists("debug") && instance_exists(global.debug)) {
    instance_destroy();
    exit;
}

init_input();
instance_create_layer(0, 0, "Utility", obj_dialog_manager)

enum GameState {
	NULL,
	OVERWORLD,
	DIALOG,
	BATTLE,
}

global.game_state = GameState.OVERWORLD;

global.debug = id;
persistent = true;