# source from menu
xy=720
oneshot() {
	pick "Mr. Do's Castle${OFF} (c) 09/19${ON}83 Universal"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} MALLET ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	anykey && arcade "docastle"
}
