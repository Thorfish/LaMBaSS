if (variable_global_exists("dialogue") && instance_exists(global.dialogue)) {
    instance_destroy();
    exit;
}

global.dialogue = id;
persistent = true;

dialogue = ds_map_create();

#region Joe
create_dialogue("joe", "neutral", "1", "Joe", "What do you want?");
create_dialogue("joe", "neutral", "1", "Joe", "Jason?");
#endregion


/// @description Takes in string parameters to create a dialogue
/// @param _character String: Name of character
/// @param _event String: Name of event
/// @param _id String: Id of the conversation, can be anything
/// @param _speaker String: Actual name of the speaker
/// @param _text String: The actual message being said
/// @param _flag Array<String> (Optional): Used for identifying any special circumstances or requirements for dialogue to appear
/// 
/// @example\n
/// example: create_dialogue("bimbo", "win", "1", "Sophie", "rekt nuub", ["obtained_lock"])
function create_dialogue(_character, _event, _id, _speaker, _text, _flag = []) {
	var character = ensure_map(dialogue, _character);
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


/// @description Takes in the specific dialogue to read out
/// @example eg: global.dialogue[? "dialogue"][? "joe"][? "neutral"][? "1"]
function do_dialogue(array) {
	for (var i = 0; i < array_length(array); i++) {
		show_debug_message(array[i].speaker + ": " + array[i].text);
		
	}
}

/// @description Takes in the struct of the character to randomly pick a dialogue option.
/// @example eg: global.dialogue.accept.jock
function random_dialogue(dialogue) {
	var length = ds_map_size(dialogue);
	
	var i = int64((random_range(1, length + 0.99)));
	var index = string(i)
	
	if (is_array(dialogue[? index])) {
		show_debug_message("Dialogue found");
		do_dialogue(dialogue[? index]);
	}
}