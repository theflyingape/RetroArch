# source from menu
xy=720
oneshot() {
	pick "Lady Bug${OFF} (c) 10/19${ON}81 Universal"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "Eat the \e[1;7;34mBLUE\e[m hearts (up to x5) as soon as possible." 2
	anykey && arcade "ladybug"
}
