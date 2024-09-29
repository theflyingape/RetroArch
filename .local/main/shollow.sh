# source from menu
xy=720
oneshot() {
	pick "Satan's Hollow${OFF} (c) 19${ON}81 Bally Midway"
	frame "${PAD}${KEY} ${LEFT} ${OFF}${HBAR}${ON}•${OFF}${HBAR}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} FIRE ${OFF}  ${KEY} SHIELD ${OFF}" 2
	frame "" 2
	frame "Destroy the swarming gargoyles and win bridge pieces" 2
	frame "one-by-one. Build the bridge and cross into the valley" 2
	frame "to battle ${ON}${RED}Satan${OFF} himself." 2
	anykey && arcade shollow
}
