# source from menu
xy=720
oneshot() {
	pick "Pinball Action ${OFF}(c) 07/19${ON}85 Tehkan"
	frame "${PAD}${LEFT}${KEY} A ${OFF} + ${KEY} B ${OFF}${RIGHT}  ${KEY} Y ${OFF} Start" 2
	frame "" 2
	anykey && arcade pbaction
}
