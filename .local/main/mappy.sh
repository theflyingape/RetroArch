# source from menu
xy=720
oneshot() {
	pick "Mappy${OFF} (c) 03/19${ON}83 Namco"
	frame "${PAD}${KEY} ${LEFT} ${OFF} - ${KEY} ${RIGHT} ${OFF}  ${KEY} DOOR ${OFF}" 2
	anykey && arcade "mappy"
}
