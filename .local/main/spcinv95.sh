# source from menu
oneshot() {
	pick "Space Invaders '95 ${OFF}(c) 06/19${ON}95 Taito"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} FIRE ${OFF}  ${KEY} B2 ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}      ${KEY} B3 ${OFF}   ${KEY} B4 ${OFF}" 2
	anykey && arcade "spcinv95"
}
