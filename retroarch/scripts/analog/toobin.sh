# source from menu
xy=720
oneshot() {
	pick "Toobin'${OFF} (c) 06/19${ON}88 Atari"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} COKE ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "Regan and I played this one a lot along with" 2
	frame "Two Tigers and Victory Road." 2
	anykey && arcade "toobin"
}
