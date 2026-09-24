# source from menu
xy=896
oneshot() {
	pick "Star Wars${OFF} (c) 05/19${ON}83 Atari"
	frame "${PAD} left" 2
	frame "${PAD}${KEY} STICK ${OFF}  ${KEY} FIRE ${OFF}" 2
	frame "${PAD}  aim" 2
	frame "" 2
	frame "Best used with a mouse/trackball." 2
	frame "" 2
	frame "The first Atari game to have speech." 2
	frame "In the trench you can get extra bonus points by not shooting" 2
	frame "ANYTHING until 'USE THE FORCE' appears." 2
	anykey && arcade "starwars"
}
