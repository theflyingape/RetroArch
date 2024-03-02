# source from menu
xy=720
oneshot() {
	pick "Spiders${OFF} (c) 07/19${ON}81 Sigma Enterprises"
	frame "${PAD}${KEY} ${LEFT} ${OFF} - ${KEY} ${RIGHT} ${OFF}  ${KEY} FIRE ${OFF}" 2
	frame 
	frame "My 'go to' game upon arrival at ${DIM}Star Castle${OFF} arcade"
	frame "in Smithfield, RI.  Then Phoenix, Battlezone,"
	frame "Tail Gunner, Robotron, Centipede and Pac-Man."
	anykey && arcade spiders mame
}
