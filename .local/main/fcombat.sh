# source from menu
xy=720
oneshot() {
	pick "Field Combat${OFF} (c) 05/19${ON}85 Jaleco"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}${ON}${HBAR}${CROSS}${HBAR}${OFF}${KEY} ${RIGHT} ${OFF}  ${KEY} CAPTURE ${OFF}  ${KEY}${RED} FIRE ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "Press BOTH buttons to release your selected" 2
	frame "field combat troops from the bottom panel." 2
	anykey && arcade fcombat mame
}
