# source from menu
xy=720
oneshot() {
	pick "Kick Man${OFF} (c) 12/19${ON}81 Midway"
	frame "${PAD} left" 2
	frame "${PAD}${KEY} STICK ${OFF}  ${KEY} KICK ${OFF}" 2
	frame "${PAD} move" 2
	frame "" 2
	frame "The game was first developed back in 19${ON}78${OFF} as a black" 2
	frame "and white game called 'Catch 40'." 2
	anykey && arcade kick
}
