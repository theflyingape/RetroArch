# source from menu
xy=720
oneshot() {
	pick "Qix${OFF} (c) 10/19${ON}81 Taito"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}${ON}${HBAR}${CROSS}${HBAR}${OFF}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} SLOW ${OFF}  ${KEY} FAST ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "The author named the game 'QIX' (pronounced 'KICKS' and" 2
	frame "not 'QUIX') because his car tags was 'JUS4QIX'." 2
	anykey && arcade qix
}
