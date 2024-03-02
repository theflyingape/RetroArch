# source from menu
xy=800
oneshot() {
	pick "Space Wars${OFF} (c) 10/19${ON}77 Cinematronics"
	frame "${PAD}${KEY} ${LEFT} ${OFF} - ${KEY} ${RIGHT} ${OFF}  ${KEY} FIRE ${OFF}  ${KEY} THRUST ${OFF}  ${KEY} WARP ${OFF}" 2
	frame "" 2
	frame "Based upon Spacewar! on the PDP-1 mainframe in 19${ON}62${OFF}, this" 2
	frame "arcade hit would 'inspire' Atari Asteroids 2-years later." 2
	frame "" 2
	frame "Hold ${KEY}${RED} Fn ${OFF} for numeric keypad input. In-game mods:" 2
	frame "  ${KEY}${RED} 1 ${OFF}/${KEY}${RED} 2 ${OFF} Bounce / Wrap    ${KEY}${RED} 4 ${OFF}/${KEY}${RED} 5 ${OFF} Negative / No Gravity"
	frame "  ${KEY}${RED} 3 ${OFF} Black Hole"
	frame "" 2
	frame "Game starts from a numeric keypad selection:" 2
	frame "      Beginner        Intermediate        Expert" 2
	frame "  ${KEY}${RED} 0 ${OFF} Slow        ${KEY}${RED} 3 ${OFF} Fast            ${KEY}${RED} 6 ${OFF} Very Slow" 2
	frame "  ${KEY}${RED} 1 ${OFF} Fast        ${KEY}${RED} 4 ${OFF} Fast Missiles   ${KEY}${RED} 7 ${OFF} Slow" 2
	frame "  ${KEY}${RED} 2 ${OFF} Very Fast   ${KEY}${RED} 5 ${OFF} Very Fast       ${KEY}${RED} 8 ${OFF} Fast" 2
	frame "                                      ${KEY}${RED} 9 ${OFF} Strong Gravity"
	anykey && arcade "spacewar"
}
