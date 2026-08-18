# source from menu
xy=1024
oneshot() {
	pick "Gridiron Fight${OFF} (c) 03/19${ON}85 Tehkan"
	frame "${PAD} left" 2
	frame "${PAD}${KEY} STICK ${OFF}  ${KEY} ACTION ${OFF}" 2
	frame "${PAD}  run" 2
	anykey && arcade gridiron mame
}
