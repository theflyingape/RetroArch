# source from menu
xy=1000
oneshot() {
	pick "Time Pilot '84${OFF} (c) 06/19${ON}84 Konami"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} FIRE ${OFF}  ${KEY} MISSILE ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "Look for the old bi-plane over the water and" 2
	frame "shoot it down with a missile." 2
	anykey && arcade "tp84"
}
