# source from menu
xy=800
oneshot() {
	pick "Sea Wolf${OFF} (c) 03/19${ON}76 Midway"
	frame "${PAD} left" 2
	frame "${PAD}${KEY} STICK ${OFF}  ${KEY} FIRE ${OFF}" 2
	frame "${PAD} scope" 2
	frame "" 2
	frame "Sea Wolf has one of the all-time great cabinets." 2
	frame "10,000 units were made." 2
	anykey && arcade seawolf mame
}
