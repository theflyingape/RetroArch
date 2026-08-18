# source from menu
xy=896
oneshot() {
	comp C64 "Lode Runner${OFF} (c) 19${ON}83 Broderbund"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}${ON}${HBAR}${CROSS}${HBAR}${OFF}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} BOMB ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "You will like this platform/puzzle game." 2
	roms='VICE x64sc'
	content='lode runner (1983)(broderbund)'
	pi500 reset comp
	anykey "C64 - Lode Runner.pdf" && qstart -L vice_x64sc "$RA/roms/C64 Replay/Lode Runner.crt"
}
