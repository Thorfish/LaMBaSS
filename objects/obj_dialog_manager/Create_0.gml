if (variable_global_exists("dialog") && instance_exists(global.dialog)) {
    instance_destroy();
    exit;
}

global.dialog = id;
persistent = true;

dialog = ds_map_create();
branch = [];

enum Type {
	
}

#region Joe
create_dialog("joe", "neutral", "1", "Jason", "Bruhhh. What do you want?");

create_dialog("joe", "neutral", "2", "Jason", "Minecraft?");
create_dialog("joe", "neutral", "2", "Jason", "Cmon modded minecraft is the best dude.");
create_dialog("joe", "neutral", "2", "Bully", "Nah dude minecraft is so lame lmao.");
create_dialog("joe", "neutral", "2", "Bully", "Stinky poopy butthole");

create_dialog("joe", "neutral", "3", "Not Jason", "Yo wassup dude, did you wanna hang out with me? You seem like a very chill guy, and I just wanted to say hi to you.");
create_dialog("joe", "neutral", "3", "Not Jason", "Just kidding do you wanna fight instead");
branch = [
	branch_dialog("yes", "joe/accept_fight"), 
	branch_dialog("no", "joe/reject_fight")
]
create_dialog("joe", "neutral", "3", "Not Jason", "Fight this person?", branch);

create_dialog("joe", "accept_fight", "1", "Not Jason", "Ok cool ig we fighting now.", [], GameState.BATTLE);
create_dialog("joe", "reject_fight", "1", "Not Jason", "Oh what you don't wanna fight now? Ok bruh whatever.");

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
/// @param _flag Array<String> (Optional): Differing branch paths for dialogue. Use branch_dialog() inside an array to create the struct
/// 
/// @example\n
/// example: create_dialog("bimbo", "win", "1", "Sophie", "rekt nuub", [branch_dialog("yes", "joe/accept_fight")])
function create_dialog(_character, _event, _id, _speaker, _text, _flag = [], state = GameState.NULL) {
	var character = ensure_map(dialog, _character);
	var event = ensure_map(character, _event);
	
	var line = {
		"speaker": _speaker,
		"flag": _flag,
		"text": _text,
		"game_state": state,
	}
	
	if (!is_array(event[? _id])) {
		event[? _id] = [];	
	}
	
	array_push(event[? _id], line);
	
	show_debug_message("Message created for " + _character + " for " + _event + " with convo id of " + _id);
}

/// @description Creats a struct that includes the text displayed as an option and the path to new dialogue
/// @param text String: Text to be displayed as an option
/// @param path String: String for the path for new dialog, separated by /. If the convo id is not included, it will choose a random dialog of the same character and event
/// @example branch_dialog("yes", "joe/accept_fight")
function branch_dialog(text, path) {
	var array = sep_string(path, "/");
	if (array_length(array) < 3) {
		array_push(array, -1);
	} 
	
	var struct = {
		"text": text,
		"path": array,
	}
	
	return struct;
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
	var array = get_dialog(_character, _event, _id);
	init_dialog_gui(array);
}

function get_dialog(_character, _event, _id = "-1") {
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
	
	return array;
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
	ASKING,
	ANSWERING,
}

state = State.NULL;

current_dialog = [];
current_speaker = "";
current_text = "";
current_flag = [];
current_transition_state = GameState.NULL;

text_to_display = "";
dialog_index = 0;
speaker_status = "";
answer_index = 0;


margin = 0.05;
gui_width = display_get_gui_width();
gui_height = display_get_gui_height();
gap_size = 30;
box_border_horizontal = 29;
box_border_vertical = 22;

// Timer stuff
fade_timer = 0;
text_timer = 0;
interact_timer = 0;

function init_dialog_gui(dialog) {
	dialog_index = 0;
	current_dialog = dialog;
	set_next_line();
	if (state = State.NULL) {
		state = State.STARTING;
	}
	
}

function set_gui_border() {
	margin = 0.1;
	gui_width = display_get_gui_width();
	gui_height = display_get_gui_height();
}

function set_next_line() {
	show_debug_message(current_dialog);
	var flag = "";
	text_to_display = "";
	
	if (dialog_index < array_length(current_dialog)) {
		
		show_debug_message("Setting next line");
		if (current_speaker == current_dialog[dialog_index].speaker) {
			flag = "same";
		} else {
			flag = "diff";
		}

		current_speaker = current_dialog[dialog_index].speaker;
		current_text = current_dialog[dialog_index].text;
		current_flag = current_dialog[dialog_index].flag;
		current_transition_state = current_dialog[dialog_index].game_state;
		
		show_debug_message(current_text);
		dialog_index++;
	} else {
		show_debug_message("No new lines, transition to dialog ending");
		
		dialog_index = 0;
	}
	
	return flag;
}

/// @description Sets the boundaries by setting starting position, current position, and ending position of main box
function set_main_position() {
	set_gui_border();
	draw_set_font(m5x7);
	v_offset_main = 0.6; // Dialog box starts x% below the 
	
	pos_main = {
		start_pos: { x: gui_width * margin, y: gui_height * v_offset_main },
		end_pos: { x: gui_width * (1 - margin), y: gui_height * (1 - margin) },
	}
	
	pos_main.current_pos = variable_clone(pos_main.start_pos);
}

/// @description Sets the boundaries of the name box in relation to main box. Offsetted by string height of speaker and arbitrary values
function set_name_position() {
	draw_set_font(m5x7);
	gap_size = 30;
	box_border_horizontal = 29;
	box_border_vertical = 22;
	pos_name = {
			start_pos: { x: gui_width * margin, y: gui_height * v_offset_main - string_height(current_speaker) - box_border_vertical * 2 - gap_size },
			end_pos: { x: gui_width * margin + string_width(current_speaker) + box_border_horizontal * 2, y: gui_height * v_offset_main - gap_size },
	}	
	
	pos_name.current_pos = variable_clone(pos_name.start_pos);
}

function normalise_position(pos, flag) {
	switch flag {
		case "in":
			pos.current_pos = variable_clone(pos.end_pos);
			break;
		
		case "out":
			pos.current_pos = variable_clone(pos.start_pos);
			break;
	}
}

function draw_dialog_box(pos) {
	draw_sprite_stretched(spr_dialog_box, 0, pos.start_pos.x, pos.start_pos.y, pos.end_pos.x - pos.start_pos.x, pos.current_pos.y - pos.start_pos.y);
}

function fade_in(pos) {
	draw_dialog_box(pos);
	pos.current_pos.y = lerp(pos.current_pos.y, pos.end_pos.y, 0.5);
}

function fade_out(pos) {
	draw_dialog_box(pos);
	pos.current_pos.y = lerp(pos.current_pos.y, pos.start_pos.y, 0.5);
}

/// @descrition Takes in text to read at a certain speed. Leave delay empty to make it instant, delay 0 is the fastest
function update_text_to_display(delay = -1) {
	show_debug_message("Starting to update text");
	if (delay == -1) {
		text_to_display = string_concat(text_to_display, current_text);
		current_text = string_delete(current_text, 1, string_length(current_text));
		return;
	}

	if (is_timer_reached_text(delay)) {
		var char = string_copy(current_text, 1, 1);
		show_debug_message("Adding " + char);
		text_to_display += char;
		current_text = string_delete(current_text, 1, 1);
	}
}

function display_text(text, pos_box) {
	if (current_speaker == "Bully") {
		draw_set_color(c_yellow);
	}
	
	draw_text_ext(
		pos_box.start_pos.x + box_border_horizontal, 
		pos_box.start_pos.y + box_border_vertical, 
		text, 
		font_get_size(draw_get_font()) + 3, 
		pos_box.end_pos.x - pos_box.start_pos.x - box_border_horizontal * 2
	);
	draw_set_color(c_white);
}

function display_options(array, pos_box) {
	var spacing = (1 / (array_length(array) + 1)) * (pos_box.end_pos.x - pos_box.start_pos.x - box_border_horizontal * 2)
	for (var i = 0; i < array_length(array); i++) {
		var text_length = string_length(array[i].text);
		
		if (i == answer_index) {
			draw_set_color(c_yellow);
		} 
		
		draw_text(
			pos_box.start_pos.x + box_border_horizontal + (i + 1) * spacing - text_length ,
			pos_box.end_pos.y - box_border_vertical * 2, 
			array[i].text
		);
		draw_set_color(c_white);
	}	
}

/// @description Returns boolean if timer is reached. Automatically increments and resets the timer if reached end timer
function is_timer_reached_text(end_timer) {
	if (text_timer >= end_timer) {
		text_timer = 0;
		return true;
	}
	text_timer++;
	return false;
}

function is_timer_reached_fade(end_timer) {
	if (fade_timer >= end_timer) {
		fade_timer = 0;
		return true;
	}
	fade_timer++;
	return false;
}

#endregion
//////////////////////////////////////////////////////////////////////////////////////////////////