# source from menu
xy=720
oneshot() {
	pick "Scramble ${OFF}(c) 02/19${ON}81 Konami"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} FIRE ${OFF}  ${KEY} BOMB ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame ""
	frame "The world's first multi-level shoot'em up, a single"
	frame "player takes control of their spaceship to battle "
	frame "their way through 6 levels without exhausting fuel."
	anykey && arcade "scramble"
}
