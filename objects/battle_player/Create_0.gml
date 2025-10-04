function gain_block(b) {
	block += b;
}

function take_damage(d) {
	if d > block {
		d -= block;
		block = 0;
		health -= d;
	} else {
		block -= d;
	}
}