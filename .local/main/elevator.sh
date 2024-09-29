# source from menu
xy=896
oneshot() {
	pick "Elevator Action${OFF} (c) 07/19${ON}83 Taito"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}${ON}${HBAR}${CROSS}${HBAR}${OFF}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} SHOOT ${OFF}  ${KEY} JUMP ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "There is an internal time limit on how long you can take to" 2
	frame "get everything out of the building. If you take too much time," 2
	frame "an alarm sounds to really make your life miserable." 2
	anykey && arcade elevator
}
