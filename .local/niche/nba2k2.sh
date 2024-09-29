# source from menu
xy=896
oneshot() {
	comp Dreamcast "NBA 2K2 ${OFF} (c) 20${ON}01${OFF} Sega"
	frame "        ${KEY} Y ${OFF} pass icons" 2
	frame "         ${UP}" 2
	frame "${KEY} Shoot ${OFF}${LEFT}${HBAR}${CROSS}${HBAR}${RIGHT}${KEY} Crossover ${OFF}" 2
	frame "         ${DOWN}" 2
	frame "       ${KEY} Pass ${OFF}" 2
	[ "$MODEL" = "Pi5" ] || frame "Might not run well on your ${MODEL}" 2
	roms='Dreamcast'
	content='nba2k2'
	anykey "Dreamcast - NBA 2K2.pdf" && qstart -L flycast "$RA/roms/Sega Dreamcast/NBA 2K2 (USA).chd" < /dev/null
}
