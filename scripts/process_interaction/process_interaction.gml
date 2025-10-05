function process_interaction(player, interactable, action) {
	switch action {
		case "talk":
			interactable.talk();
			break;
		case "accept":
			interactable.accept();
			break;
		case "reject":
			interactable.reject();
			break;
		case "examine":
			interactable.examine();
			break;
		case "enter":
			interactable.enter();
			break;
	}
}