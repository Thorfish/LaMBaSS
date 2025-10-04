if (variable_global_exists("debug") && instance_exists(global.debug)) {
    instance_destroy();
    exit;
}

init_input();

global.debug = id;
persistent = true;