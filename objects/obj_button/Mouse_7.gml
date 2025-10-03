if(buttonState==ButtonState.PRESSED && instance_exists(obj_button_manager)) {
	obj_button_manager.button_pressed(action);
}
buttonState=ButtonState.FREE;