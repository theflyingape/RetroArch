# source from menu
xy=1024
oneshot() {
	pick "Crossbow${OFF} (c) 10/19${ON}83 Exidy"
	frame "${PAD} left" 2
	frame "${PAD}${KEY} STICK ${OFF}  ${KEY} FIRE ${OFF}" 2
	frame "${PAD}  aim" 2
	frame "" 2
	frame "The first video game to completely use digitized sound" 2
	frame "and music." 2
	frame "Best used with a mouse/trackball." 2
	anykey && arcade "crossbow"
}
