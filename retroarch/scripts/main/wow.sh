# source from menu
xy=1024
oneshot() {
	pick "Wizard of Wor ${OFF}(c) 06/19${ON}81 Midway"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}${ON}${HBAR}${CROSS}${HBAR}${OFF}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} FIRE ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "Best when played with a 'friend', but beware,"
	frame "it's cut throat action and usually ends in a"
	frame "brawl between brothers. Heh."
	pi500 mame fire
	anykey && arcade wow
}
