# source from menu
xy=720
oneshot() {
	pick "Carnival${OFF} (c) 06/19${ON}80 Sega"
	frame "${PAD}${KEY} ${LEFT} ${OFF}${HBAR}${ON}•${OFF}${HBAR}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} FIRE ${OFF}" 2
	frame "" 2
	frame "The official record for this game is 386,750 points on June 3, 2001." 2
	pi500 mame lr fire
	anykey && arcade carnival
}
