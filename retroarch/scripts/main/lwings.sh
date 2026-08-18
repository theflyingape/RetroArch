# source from menu
xy=720
oneshot() {
	pick "Legendary Wings${OFF} (c) 12/19${ON}86 Capcom"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}${ON}${HBAR}${CROSS}${HBAR}${OFF}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} FIRE ${OFF}  ${KEY} BOMB ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "Simple shoot-em-up for 1 or 2 players." 2
	pi500 mame fire2
	anykey && arcade "lwings"
}
