# source from menu
xy=896
oneshot() {
	pick "Kung-Fu Master${OFF} (c) 12/19${ON}84 Irem"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} PUNCH ${OFF}  ${KEY} KICK ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	anykey && arcade kungfum
}
