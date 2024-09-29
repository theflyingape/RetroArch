# source from menu
xy=896
oneshot() {
	pick "Joust${OFF} (c) 09/19${ON}82 Williams"
	frame "${PAD}${KEY} ${LEFT} ${OFF}${HBAR}${ON}•${OFF}${HBAR}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} FLAP ${OFF}" 2
	frame 
	frame "The biggest thrill is killing a pterodactyl." 2
	frame "Or two." 2
	anykey && arcade joust
}
