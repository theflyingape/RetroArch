# source from menu
xy=896
oneshot() {
	comp Dreamcast "NFL 2K2 ${OFF} (c) 20${ON}01${OFF} Sega"
	frame "   ${KEY} Shoulders ${OFF} scroll through plays" 2
	frame "       ${KEY} Y ${OFF} audible menu" 2
	frame "        ${UP}" 2
	frame "${KEY} Flip ${OFF}${LEFT}${HBAR}${CROSS}${HBAR}${RIGHT}${KEY} Prev ${OFF}" 2
	frame "        ${DOWN}" 2
	frame "       ${KEY} A ${OFF} select play, but hold to hide plays" 2
	frame "QB can scramble (with special moves) while holding the Right Trigger down"
	frame "${PAD}   ${KEY} Shoulders ${OFF} stiff arm" 2
	frame "${PAD}       ${KEY} Y ${OFF} hurdle/high step" 2
	frame "${PAD}        ${UP}" 2
	frame "${PAD}${KEY} Dive ${OFF}${LEFT}${HBAR}${CROSS}${HBAR}${RIGHT}${KEY} Spin ${OFF}" 2
	frame "${PAD}        ${DOWN}" 2
	frame "${PAD}       ${KEY} A ${OFF} speed burst / power move, or hold to load up for a more powerful special move" 2
	[ "$MODEL" = "Pi5" ] || frame "Might not run well on your ${MODEL}" 2
	roms='Flycast'
	content='nfl2k2'
	anykey "Dreamcast - NFL 2K2.pdf" && qstart -L flycast "$RA/roms/Sega Dreamcast/NFL 2K2 (USA).chd" < /dev/null
}
