# source from menu
xy=1024
oneshot() {
	pick "Ghosts'n Goblins${OFF} (c) 09/19${ON}85 Capcom"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} FIRE ${OFF}  ${KEY} JUMP ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	anykey && arcade "gngt"
}
