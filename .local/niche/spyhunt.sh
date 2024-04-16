# source from menu
xy=1024
oneshot() {
	pick "Spy Hunter${OFF} (c) 03/19${ON}85 Midway"
	frame "${PAD} left" 2
	frame "${PAD}${KEY} STICK ${OFF}  ${KEY} ACTION ${OFF}" 2
	frame "${PAD}  run" 2
	anykey && arcade spyhunt mame
}
