# source from menu
xy=1024
oneshot() {
	pick "10-yard Fight${OFF} VS (c) 19${ON}83 Irem"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}${ON}${HBAR}${CROSS}${HBAR}${OFF}${KEY} ${RIGHT} ${OFF}  ${KEY} RB ${OFF}  ${KEY}${RED} WR ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "Player VS Player version."
	pi500 mame fire2
	anykey && arcade vsyard
}
