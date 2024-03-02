# source from menu
xy=1024
oneshot() {
	pick "Hustle${OFF} (c) 05/19${ON}77 Gremlin"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	anykey && arcade "hustle"
}
