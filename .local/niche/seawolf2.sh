# source from menu
xy=1024
oneshot() {
	pick "Sea Wolf II${OFF} (c) 06/19${ON}78 Midway"
	frame "${PAD} left" 2
	frame "${PAD}${KEY} STICK ${OFF}  ${KEY} FIRE ${OFF}" 2
	frame "${PAD} scope" 2
	frame "" 2
	frame "Sea Wolf II is the first-ever sequel and probably represents" 2
	frame "the very first 'modern' video game." 2
	anykey && arcade seawolf2 mame
}
