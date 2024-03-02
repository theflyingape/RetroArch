# source from menu
xy=1024
oneshot() {
	pick "Space Duel${OFF} (c) 02/19${ON}82 Atari"
	frame "${PAD}           ${KEY} SHIELD ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} - ${KEY} ${RIGHT} ${OFF}   ${KEY} FIRE ${OFF}  ${KEY} THRUST ${OFF}" 2
	frame "" 2
	frame "In 2 player mode, you can shoot your partner and it will" 2
	frame "regenerate their shield." 2
	anykey && arcade "spacduel"
}
