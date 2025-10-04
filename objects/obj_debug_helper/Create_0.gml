if (variable_global_exists("debug") && instance_exists(global.debug)) {
    instance_destroy();
    exit;
}

init_input();
instance_create_layer(0, 0, "Utility", obj_dialogue_manager)

global.debug = id;
persistent = true;