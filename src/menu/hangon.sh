# source from menu
xy=1024
oneshot() {
	pick "Hang-on${OFF} (c) 07/19${ON}85 Sega"
	frame "${PAD} left" 2
	frame "${PAD}${KEY} STICK ${OFF}  ${KEY} GAS ${OFF}" 2
	frame "${PAD} turn" 2
	anykey && arcade hangon
}
