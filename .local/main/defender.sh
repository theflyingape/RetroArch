# source from menu
xy=896
oneshot() {
	pick "Defender${OFF} (c) 12/19${ON}80 Williams"
	frame "${PAD}shoulder  ${KEY} ${UP} ${OFF}  ${KEY} BOMB ${OFF}   ${KEY} WARP ${OFF}" 2
	frame "${PAD}   ${KEY}${LEFT}${RIGHT}${OFF}      ${ON}${VBAR}${OFF}" 2
	frame "${PAD}reverse   ${KEY} ${DOWN} ${OFF}  ${KEY}${RED} FIRE ${OFF}  ${KEY} THRUST ${OFF}" 2
	frame "" 2
	frame "Arcade industry insiders confidently predicted that both" 2
	frame "${ON}${RED}Defender${OFF} and ${ON}\e[33mPac-Man${OFF} would be commercial flops and that" 2
	frame "${ON}Rally-X${OFF} would be the next major arcade success." 2
	frame "Along with ${ON}Pac-Man${OFF}, Defender shares the title of 'Highest" 2
	frame "Grossing Video Game of All Time' and has earned more than" 2
	frame "${ON}\e[32m\$1B${OFF}." 2
	anykey && arcade "defender"
}
