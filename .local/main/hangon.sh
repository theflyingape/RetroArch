# source from menu
xy=1024
oneshot() {
	pick "Hang-on${OFF} (c) 07/19${ON}85 Sega"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}${ON}${HBAR}${CROSS}${HBAR}${OFF}${KEY} ${RIGHT} ${OFF}" 2
	frame "" 2
	frame "Must use left analog stick for best handling:" 2
	frame "Up to throttle and angling thru the turns." 2
	anykey && arcade hangon
}
