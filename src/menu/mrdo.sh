# source from menu
xy=720
oneshot() {
	pick "Mr. Do!${OFF} (c) 19${ON}82 Universal"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} BALL ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "It's possible to win 255 lives on the first screen, but only" 2
	frame "if an apple appears in the top two rows of the playfield." 2
	anykey && arcade mrdo
}
