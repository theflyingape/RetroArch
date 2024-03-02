# source from menu
xy=1024
oneshot() {
	pick "Gauntlet II${OFF} (c) 08/19${ON}86 Atari"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} FIRE ${OFF}  ${KEY} MAGIC ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "This is a classic quarter-eating machine, as up to 4 players" 2
	frame "can join in anytime and adding coins for health during game." 2
	frame "The game setup is in an Easier mode with 2x Health per coin." 2
	frame "Press ${KEY} TAB ${OFF} to review its ${ON}History${OFF} for useful Tips & Tricks!" 2
	anykey && arcade "gaunt2"
}
