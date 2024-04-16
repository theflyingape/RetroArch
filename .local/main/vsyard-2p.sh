# source from menu
xy=1024
oneshot() {
	pick "10-yard Fight${OFF} VS (c) 19${ON}83 Irem"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} RB ${OFF}  ${KEY} WR ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame 
	frame "Player VS Player version."
	anykey && arcade vsyard
}
