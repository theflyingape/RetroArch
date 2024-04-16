# source from menu
xy=896
oneshot() {
	pick "New Rally-X${OFF} (c) 02/19${ON}81 Namco"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} SMOKE ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "The sequel has slightly different graphics to the" 2
	frame "original game and has more forgiving gameplay." 2
	anykey && arcade nrallyx
}
