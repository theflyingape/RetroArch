# source from menu
xy=1024
oneshot() {
	pick "Star Castle${OFF} (c) 09/19${ON}80 Cinematronics"
	frame "${PAD}${KEY} ${LEFT} ${OFF} - ${KEY} ${RIGHT} ${OFF}  ${KEY} FIRE ${OFF}  ${KEY} THRUST ${OFF}" 2
	frame "" 2
	frame "The original inspiration came from a never-released game," 2
	frame "${ON}Oops!${OFF} in which the player controlled a sperm trying to fertilize" 2
	frame "an egg in the center of the screen." 2
	anykey && arcade "starcas"
}
