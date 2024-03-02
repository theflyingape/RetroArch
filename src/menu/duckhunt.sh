# source from menu
xy=896
oneshot() {
	pick "Duck Hunt${OFF} (c) 03/19${ON}85 Nintendo"
	frame "${PAD} left" 2
	frame "${PAD}${KEY} STICK ${OFF}  ${KEY} FIRE ${OFF}" 2
	frame "${PAD}  aim" 2
	frame "" 2
	frame "Easier with a mouse/trackball and its button." 2
	anykey && arcade "duckhunt"
}
