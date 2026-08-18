# source from menu
xy=720
oneshot() {
	pick "Time Pilot${OFF} (c) 11/19${ON}82 Konami"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}${ON}${HBAR}${CROSS}${HBAR}${OFF}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} FIRE ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "On the second stage, don't shoot anything but the bombers." 2
	frame "Collect the parachutes while avoiding the planes." 2
	pi500 mame fire
	anykey && arcade "timeplt"
}
