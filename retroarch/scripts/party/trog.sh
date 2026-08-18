# source from menu
xy=896
oneshot() {
	pick "Trog${OFF} (c) 02/19${ON}91 Midway"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} PUNCH ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "Pick your dino \e[1;31mRex${OFF}, \e[1;34mBloop${OFF}, \e[1;33mSpike${OFF}, or \e[1;32mGwen${OFF} and collect all" 2
	frame "your eggs that lay on one of the 49 islands." 2
	frame "If you take the shiny egg last in the lower-right corner," 2
	frame "holes with warp grids may form to advance more levels" 2
	frame "with a big bonus." 2
	anykey && arcade trog
}
