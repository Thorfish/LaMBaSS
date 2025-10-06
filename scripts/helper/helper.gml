function sep_string(str, sep) {
    var result = [];
    var index = string_pos(sep, str);
    while (index != 0) {
        var word = string_copy(str, 1, index - 1);
		show_debug_message("Pushing word: " + word);
        array_push(result, word);
        str = string_delete(str, 1, index);
		index = string_pos(sep, str);
    }

    // Push the final remaining part
    if (string_length(str) > 0) {
        array_push(result, str);
    }
	
	show_debug_message(result);
    return result;
}