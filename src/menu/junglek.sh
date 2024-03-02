# source from menu
xy=896
oneshot() {
	pick "Jungle King${OFF} (c) 08/19${ON}82 Taito"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} JUMP ${OFF} or KNIFE" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame 
	frame "You can jump even higher over the rocks when"
	frame "joystick is pushed up or up + left"
	anykey && arcade junglek
}
