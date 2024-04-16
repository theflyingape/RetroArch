# source from menu
xy=896
oneshot() {
	comp C64 "Star League Baseball${OFF} (c) 19${ON}83 Gamestar"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} ACTION ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "This was my kind of home computer game relative to the" 2
	frame "B&W Atari Baseball coin-op games from the '70s." 2
	roms='VICE x64sc'
	content='Star League Baseball'
	anykey "C64 - Star League Baseball.pdf" && qstart -L vice_x64sc "$RA/roms/C64 Replay/Star League Baseball.crt"
}

