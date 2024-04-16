# source from menu
xy=896
oneshot() {
	comp C64 "Jumpman${OFF} (c) 19${ON}83 Epyx"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} JUMP ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "Press ${KEY} RETURN ${OFF} for game menu startup instructions." 2
	frame "" 2
	frame "You will like this game. Try ${ON}Jumpman Junior${OFF} and ${ON}Wizard${OFF}" 2
	frame "next off the Computers ${RIGHT} ${ON}Favorites${OFF} playlist." 2
	roms='VICE x64sc'
	content='Jumpman (1983)(Epyx)'
	anykey "C64 - Jumpman Junior.pdf" && qstart -L vice_x64sc "$RA/roms/C64/Jumpman (1983)(Epyx).d64"
}
