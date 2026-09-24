# source from menu
xy=896
oneshot() {
	pick "Missile Command${OFF} (c) 06/19${ON}80 Atari"
	frame "${PAD}${KEY} STICK ${OFF}  ${KEY} BASE ${OFF}  ${KEY} BASE ${OFF}  ${KEY} BASE ${OFF}" 2
	frame "" 2
	frame "Engineering loved the name ${ON}Armageddon${OFF}, but from the top came" 2
	frame "the message, 'We can't use that name, nobody'll know what it" 2
	frame "means, and nobody can spell it.'" 2
	frame "" 2
	frame "Easier with a mouse/trackball using ${KEY} A ${OFF} ${KEY} S ${OFF} ${KEY} D ${OFF} missile bases" 2
	anykey && arcade "missile"
}
