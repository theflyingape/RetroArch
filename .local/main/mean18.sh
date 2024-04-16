# source from menu
xy=800
oneshot() {
	pick "Mean 18${OFF} (c) 19${ON}86 Accolade" 7800
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} SWING ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	anykey "A7800 - Mean 18 Ultimate Golf.pdf" && qstart -L prosystem "$RA/roms/Atari 7800/mean18.bin"
}
