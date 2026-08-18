# source from menu
xy=896
oneshot() {
	compete "Skiing(c) 19${ON}80 Activision" VCS
	frame "${PAD}${KEY} ${LEFT} ${OFF}${HBAR}${ON}•${OFF}${HBAR}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} JUMP ${OFF}" 2
	frame "" 2
	frame "${KEY} L1 ${OFF} shoulder sets ${KEY}B${OFF} novice"
	frame "${KEY} L2 ${OFF} bumper sets ${KEY}A${OFF} expert"
	frame "Games 1-5  Slalom - Difficulty ${KEY}A${OFF} adds trees" 2
	frame "Games 6-10  Downhill - Difficulty ${KEY}A${OFF} to jump" 2
	if anykey "A2600 - Skiing.pdf" ; then
		pi500 game fire
		if [ "$got" = "n" ]; then
			qstart -L stella "$RA/roms/Atari 2600/Skiing (USA).a26"
		else
			cheevos -L stella "$RA/roms/Atari 2600/Skiing (USA).a26"
		fi
	fi
}
