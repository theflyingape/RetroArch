# source from menu
xy=1600
oneshot() {
	pick "Tecmo Bowl${OFF} (c) 12/19${ON}87 Tecmo"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} MOVE ${OFF}  ${KEY} ACTION ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "1-4 players. DIP switches set on easier."
	frame "MOVE button for pre-snap select, then jump."
	frame "ACTION button for hike, kick, tackle, throw."
	anykey && arcade tbowl
}
