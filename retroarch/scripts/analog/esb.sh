# source from menu
xy=1024
oneshot() {
	pick "The Empire Strikes Back${OFF} (c) 03/19${ON}85 Atari Games"
	frame "${PAD} left" 2
	frame "${PAD}${KEY} STICK ${OFF}  ${KEY} FIRE ${OFF}" 2
	frame "${PAD}  aim" 2
	frame "" 2
	frame "Best used with a mouse/trackball." 2
	anykey && arcade esb
}
