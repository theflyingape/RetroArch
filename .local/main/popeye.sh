# source from menu
xy=896
oneshot() {
	pick "Popeye${OFF} (c) 12/19${ON}82 Nintendo"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}${ON}${HBAR}${CROSS}${HBAR}${OFF}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} PUNCH ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "Popeye and its cast of characters: Olive Oyl, Bluto, Wimpy," 2
	frame "Sweetpea, the Sea Hag and her Vulture." 2
	anykey && arcade "popeye"
}
