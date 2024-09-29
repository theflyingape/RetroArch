# source from menu
xy=720
oneshot() {
	pick "Centipede${OFF} (c) 19${ON}80 Atari"
	frame "${PAD} left" 2
	frame "${PAD}${KEY} STICK ${OFF}  ${KEY} FIRE ${OFF}" 2
	frame "${PAD} move" 2
	frame "" 2
	frame "${PAD}Easier with a mouse/trackball and its button." 2
	frame "" 2
	frame "The first coin-op game designed by a woman, Dona Bailey." 2
	frame "Like ${ON}Pac-Man${OFF}, this game has special appeal to women." 2
	anykey && arcade "centiped"
}
