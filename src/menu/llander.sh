# source from menu
xy=1024
oneshot() {
	pick "Lunar Lander${OFF} (c) 08/19${ON}79 Atari"
	frame "${PAD}${KEY} ${LEFT} ${OFF} - ${KEY} ${RIGHT} ${OFF}  ${KEY} THRUST ${OFF}  ${KEY} ABORT ${OFF}" 2
	anykey && arcade llander mame
}
