# source from menu
xy=896
oneshot() {
	pick "Super Challenge Baseball${OFF} (c) 05/19${ON}82 M Network" VCS
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} ACTION ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "Difficulty A - you control baserunner" 2
	anykey "A2600 - Super Challenge Baseball.pdf" && qstart -L stella "$RA/roms/Atari 2600/Super Challenge Baseball (USA).zip"
}
