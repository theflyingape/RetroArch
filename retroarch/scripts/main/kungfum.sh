# source from menu
xy=896
oneshot() {
	pick "Kung-Fu Master${OFF} (c) 12/19${ON}84 Irem"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}${ON}${HBAR}${CROSS}${HBAR}${OFF}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} PUNCH ${OFF}  ${KEY} KICK ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "Inspired by the Bruce Lee film ${ON}Game of Death${OFF}," 2
	frame "which can be found here in Videos." 2
	pi500 mame fire2
	anykey && arcade kungfum
}
