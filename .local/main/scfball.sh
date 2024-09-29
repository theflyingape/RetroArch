# source from menu
xy=896
oneshot() {
	pick "Super Challenge Football${OFF} (c) 05/19${ON}82 M Network" VCS
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} ACTION ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "For TWO players only" 2
	anykey "A2600 - Super Challenge Football.pdf" && qstart -L stella2014 "$RA/roms/Atari 2600/Super Challenge Football (USA).zip"
}
