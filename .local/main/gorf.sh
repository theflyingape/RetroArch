# source from menu
xy=720
oneshot() {
	pick "GORF${OFF} (c) 02/19${ON}81 Midway"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}${ON}${HBAR}${CROSS}${HBAR}${OFF}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} FIRE ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "Galactic Orbital Robot Force was the first game ever to" 2
	frame "show multiple scenes. A Star Trek tie in was originally" 2
	frame "planned by Midway, but when the first movie fell flat," 2
	frame "the Enterprise sprite was reused as the Gorf flagship." 2
	frame "" 2
	frame "'Try again, I devour coins!', 'Ha ha ha ha!', 'Prepare" 2
	frame "for annihilation!', 'All hail the supreme Gorfian Empire!'" 2
	frame "and the infamous 'Long Live Gorf!'" 2
	anykey && arcade gorf mame
}
