# source from menu
xy=896
oneshot() {
	compete "Skiing(c) 19${ON}80 Activision" VCS
	frame "${PAD}${KEY} ${LEFT} ${OFF} - ${KEY} ${RIGHT} ${OFF}  ${KEY} JUMP ${OFF}" 2
	frame "" 2
	frame "Games 1-5  Slalom - Difficulty A adds trees" 2
	frame "Games 6-10  Downhill - Difficulty A to jump" 2
	if anykey "A2600 - Skiing.pdf" ; then
		if [ "$got" = "n" ]; then
			qstart -L stella "$RA/roms/Atari 2600/Skiing (USA).zip"
		else
			cheevos -L stella "$RA/roms/Atari 2600/Skiing (USA).zip"
		fi
	fi
}
