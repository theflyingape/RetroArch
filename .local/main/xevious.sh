# source from menu
xy=720
oneshot() {
	pick "Xevious${OFF} (c) 12/19${ON}82 Namco"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} FIRE ${OFF}  ${KEY} BOMB ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "The world's first vertically scrolling shoot-em-up." 2
	frame "You can hold down the fire and bomb buttons to constantly do" 2
	frame "both at a slower rate." 2
	anykey && arcade "xevious"
}
