# source from menu
xy=720
oneshot() {
	pick "Space Invaders${OFF} (c) 07/19${ON}78 Taito"
	frame "${PAD}${KEY} ${LEFT} ${OFF} - ${KEY} ${RIGHT} ${OFF}  ${KEY} FIRE ${OFF}" 2
	anykey && arcade invaders
}
