# source from menu
xy=896
oneshot() {
	comp A800 "Star Raiders${OFF} (c) 03/19${ON}80 Atari" 2
	frame "" 2
	frame "${KEY} F2 ${OFF} Option   ${KEY} F3 ${OFF}${ON} Select${OFF}" 2
	frame "${KEY} F4 ${OFF}${ON} Start${OFF}    ${KEY} F5 ${OFF} RESET" 2
	frame "" 2
	frame "A space real-time strategy game in an 8k rom." 2
	anykey "A800 - Star Raiders.pdf" && qstart -L atari800 "$RA/roms/Atari 800/8KB/star raiders.atr"
}
