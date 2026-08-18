# source from menu
xy=960
oneshot() {
	pick "Tail Gunner${OFF} (c) 11/19${ON}79 Cinematronics"
	frame "${PAD} left" 2 
	frame "${PAD}${KEY} STICK ${OFF}  ${KEY} FIRE ${OFF}  ${KEY} SHIELD ${OFF}" 2
	frame "${PAD}  aim" 2
	frame "" 2
	frame "Easier with a mouse and its two buttons." 2
	frame "Game ends when 10 ships get pass you." 2
	anykey && arcade tailg
}
