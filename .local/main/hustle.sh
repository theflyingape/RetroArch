# source from menu
xy=1024
oneshot() {
	pick "Hustle${OFF} (c) 05/19${ON}77 Gremlin"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}${ON}${HBAR}${CROSS}${HBAR}${OFF}${KEY} ${RIGHT} ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame 
	frame "Simple as it may be, you cannot beat"
	frame "my high score. ;)"
	anykey && arcade "hustle"
}
