# source from menu
xy=1024
oneshot() {
	pick "Make Trax${OFF} (c) 06/19${ON}81 Williams Electronics"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "Paint your trax while crushing the critters." 2
	frame "Another Cranston Bowl arcade machine played." 2
	anykey && arcade "maketrax"
}
