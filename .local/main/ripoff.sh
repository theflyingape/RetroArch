# source from menu
xy=1024
oneshot() {
	pick "Rip Off${OFF} (c) 04/19${ON}80 Cinematronics"
	frame "${PAD}${KEY} ${LEFT} ${OFF}${HBAR}${ON}•${OFF}${HBAR}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} FIRE ${OFF}  ${KEY} THRUST ${OFF}" 2
	frame "" 2
	frame "The first two player cooperative video game." 2
	frame "I first encountered this game at ${DIM}Saturn's Rings${OFF}" 2
	frame "arcade in downtown Providence, often skipping school" 2
	frame "to play it and ${ON}Missile Command${OFF}." 2
	anykey && arcade "ripoff"
}
