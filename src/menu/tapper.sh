# source from menu
xy=896
oneshot() {
	pick "Tapper${OFF} (Budweiser) (c) 12/19${ON}83 Bally Midway"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} POUR ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "Take your time in the first few levels.  You can make a high" 2
	frame "score by leaving one person and waiting for more people." 2
	anykey && arcade "tapper"
}
