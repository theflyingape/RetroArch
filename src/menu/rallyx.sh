# source from menu
xy=1024
oneshot() {
	pick "Rally-X${OFF} (c) 10/19${ON}80 Namco"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} SMOKE ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	anykey && arcade "rallyx"
}
