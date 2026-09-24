# source from menu
xy=720
oneshot() {
	pick "Scramble ${OFF}(c) 02/19${ON}81 Konami"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}${ON}${HBAR}${CROSS}${HBAR}${OFF}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} FIRE ${OFF}  ${KEY} BOMB ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "The world's first multi-level shoot'em up, a single"
	frame "player takes control of their spaceship to battle "
	frame "their way through 6 levels without exhausting fuel."
	pi500 mame fire2
	anykey && arcade "scramble"
}
