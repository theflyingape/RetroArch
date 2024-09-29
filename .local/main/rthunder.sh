# source from menu
xy=960
oneshot() {
	pick "Rolling Thunder${OFF} (c) 12/19${ON}86 Namco"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}${ON}${HBAR}${CROSS}${HBAR}${OFF}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} FIRE ${OFF}  ${KEY} JUMP ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "It's possible to visit the ammo rooms more than once by" 2
	frame "ensuring that the door in question is completely off screen," 2
	frame "then turn back." 2
	anykey && arcade "rthunder"
}
