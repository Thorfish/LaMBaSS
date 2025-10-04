aura = 10;

/// @description Calculates the aura depending on the action of win, lose, or take
function calculate_aura(player, action) {
	switch action {
		case "win": // The PLAYER wins
			var amount = aura + 100 + random_range(0, 20);
			player.aura += amount;
			show_debug_message("Player gained " + amount + " aura");
			amount = floor(aura / 2);
			aura -= amount;
			show_debug_message("Object lost " + amount + " aura");
			break;
		case "lose": // The PLAYER loses
			amount = floor(player.aura * 0.2)
			player.aura -= amount;
			aura += amount + 100;			
			break;
		case "take":
			player.aura += aura;
			aura = 0;
			break;
		default:
			show_message_debug("Aura action does not exist");
			break;
	}
}

