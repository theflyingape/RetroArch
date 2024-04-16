# source from menu
xy=1024
oneshot() {
	pick "Magic Sword - Heroic Fantasy${OFF} (c) 06/19${ON}90 Capcom"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} FIGHT ${OFF}  ${KEY} MAGIC ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	anykey && arcade mswordu
}
