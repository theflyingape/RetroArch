# source from menu
xy=720
oneshot() {
	pick "Bomb Jack${OFF} (c) 10/19${ON}84 Tehkan"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} JUMP ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame ""
	frame "Pick up most of the bombs while their fuses are lit to earn" 2
	frame "maximum points." 2
    anykey && arcade "bombjack"
}
