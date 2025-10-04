/////////////////////////////////////////////////
#region Movement
/////////////////////////////////////////////////
if (keyboard_check(global.input.up)) {
	y -= 5;
}
if (keyboard_check(global.input.down)) {
	y += 5;
}
if (keyboard_check(global.input.left)) {
	x -= 5;
}
if (keyboard_check(global.input.right)) {
	x += 5;
}


#endregion