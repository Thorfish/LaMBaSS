if (variable_global_exists("dialog") && instance_exists(global.dialog)) {
    instance_destroy();
    exit;
}

global.dialog = id;
persistent = true;

dialog = ds_map_create();

#region Joe
create_dialog("joe", "neutral", "1", "Joe", "What do you want?");
create_dialog("joe", "neutral", "2", "Joe", "Jason?");
#endregion
//////////////////////////////////////////////////////////////////////////////////////////////////
#region Dialog creation function
//////////////////////////////////////////////////////////////////////////////////////////////////

/// @description Takes in string parameters to create a dialog
/// @param _character String: Name of character
/// @param _event String: Name of event
/// @param _id String: Id of the conversation, can be anything
/// @param _speaker String: Actual name of the speaker
/// @param _text String: The actual message being said
/// @param _flag Array<String> (Optional): Used to modify dialog, such as bold, italic, etc?
/// 
/// @example\n
/// example: create_dialog("bimbo", "win", "1", "Sophie", "rekt nuub", ["bold"])
function create_dialog(_character, _event, _id, _speaker, _text, _flag = []) {
	var character = ensure_map(dialog, _character);
	var event = ensure_map(character, _event);
	
	var line = {
		"speaker": _speaker,
		"flag": _flag,
		"text": _text						
	}
	
	if (!is_array(event[? _id])) {
		event[? _id] = [];	
	}
	
	array_push(event[? _id], line);
	
	show_debug_message("Message created for " + _character + " for " + _event + " with convo id of " + _id);
}

function ensure_map(parent, character) {
	if (!ds_map_exists(parent, character)) {
		var new_map = ds_map_create();
		parent[? character] = new_map;
	}
	
	return parent[? character];
}

/// @description Reads the dialog of this character of this event of the convo id.
/// ASSUMES dialog ACTUALLY EXISTS
/// @param _character String: Name of character
/// @param _event String: Name of event
/// @param _id String: Id of convo. Leave empty if you want a random dialog
function do_dialog(_character, _event, _id = "-1") {
	var array = [];
	var index = "";
	
	// Gets random id index and converts to string if _id is not given
	if (_id == "-1") {
		var length = ds_map_size(dialog[? _character][? _event]);
		var i = int64((random_range(1, length + 0.99)));
		index = string(i);
	} else {
		index = _id;	
	}
	
	array = dialog[? _character][? _event][? index];
	
	init_dialog_gui(array);
}

#endregion
//////////////////////////////////////////////////////////////////////////////////////////////////
#region Dialog GUI

enum State {
	NULL,
	STARTING,
	WAITING,
	TYPING,
	ENDING,
	FADING_IN,
	FADING_OUT,
}

state = State.NULL;

current_dialog = [];
current_speaker = "";
current_text = "";
counter = 0;

margin = 0.05;
gui_width = display_get_gui_width();
gui_height = display_get_gui_height();
gap_size = 30;
box_border_size = 64;

// Main dialog box dimensions
v_offset_main = 0.6; // Dialog box starts x% below the top
		 
pos_main = {
	start_pos: { x: gui_width * margin, y: gui_height * v_offset_main },
	current_pos: { x: gui_width * margin, y: gui_height * v_offset_main },
	end_pos: { x: gui_width * (1 - margin), y: gui_height * (1 - margin) },
}
		
// Name box dimensions
show_debug_message("String height is: " + string(string_height(current_speaker)));
var gap_size = 30;
var box_border_size = 64;
pos_name = {
	start_pos: { x: gui_width * margin, y: gui_height * v_offset_main - string_height(current_speaker) - box_border_size - gap_size}, 
	current_pos: { x: gui_width * margin, y: gui_height * v_offset_main - string_height(current_speaker) - box_border_size - gap_size}, 
	end_pos: { x: gui_width * margin + string_width(current_speaker) + box_border_size, y: gui_height * v_offset_main - gap_size },
}	

// Fading stuff
fade_timer = 0;

/// @description Prints dialog to UI
function init_dialog_gui(dialog) {
	counter = 0;
	current_dialog = dialog;
	set_next_line();	
	state = State.STARTING;
}

function draw_dialog_box(pos) {
	draw_sprite_stretched(spr_dialog_box, 0, pos.start_pos.x, pos.start_pos.y, pos.end_pos.x - pos.start_pos.x, pos.current_pos.y - pos.start_pos.y);
	show_debug_message("Stretch by: " + string(pos.current_pos.y - pos.start_pos.y));
	show_debug_message(pos.start_pos.y);
	show_debug_message(pos.current_pos.y);
}

function fade_in(pos) {
	show_debug_message("Tried to draw a fade in");
	draw_dialog_box(pos);
	pos.current_pos.y = lerp(pos.current_pos.y, pos.end_pos.y, 0.5);
	show_debug_message(pos.end_pos.y);
}

function reset_fade_timer() {
	fade_timer = 10;
}

function set_next_line() {
	show_debug_message(counter);
	show_debug_message(current_dialog);
	if (counter < array_length(current_dialog)) {
		current_speaker = current_dialog[counter].speaker;
		current_text = current_dialog[counter].text;
		counter++;
	} else {
		counter = 0;
		state = State.ENDING;
	}
}

#endregion
//////////////////////////////////////////////////////////////////////////////////////////////////