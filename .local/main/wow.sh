# source from menu
xy=1024
oneshot() {
	pick "Wizard of Wor ${OFF}(c) 06/19${ON}81 Midway"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} FIRE ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame 
	frame "Best when played with a 'friend', but beware,"
	frame "it's cut throat action and usually ends in a"
	frame "brawl between brothers. Heh."
	anykey && arcade wow
}
