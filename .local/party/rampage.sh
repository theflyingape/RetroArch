# source from menu
xy=1024
oneshot() {
	pick "Rampage${OFF} (c) 10/19${ON}86 Bally Midway"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} PUNCH ${OFF}  ${KEY} JUMP ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	anykey && arcade "rampage"
}
