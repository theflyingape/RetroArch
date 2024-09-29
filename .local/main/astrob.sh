# source from menu
xy=720
oneshot() {
	pick "Astro Blaster${OFF} (c) 02/19${ON}81 Sega"
	frame "${PAD}${KEY} ${LEFT} ${OFF}${HBAR}${ON}•${OFF}${HBAR}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} FIRE ${OFF}  ${KEY} WARP ${OFF}" 2
	frame "" 2
	frame "NOTE: Fuel is a very precious commodity in this game. If you" 2
	frame "run out of fuel, your game is over regardless of any star" 2
	frame "ships remaining." 2
	anykey && arcade "astrob"
}
