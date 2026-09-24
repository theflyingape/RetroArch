# source from menu
xy=720
oneshot() {
	compete "Pac-Man${OFF} (c) 10/19${ON}80 Namco"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}${ON}${HBAR}${CROSS}${HBAR}${OFF}${KEY} ${RIGHT} ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "It is still regarded as the hallmark of the 'golden age'" 2
	frame "of video games." 2
	if anykey ; then
		if [ "$got" = "n" ]; then
			pi500 mame 4way
			qstart -L mame2003_plus "$RA/roms/MAME 2003-Plus/pacman.zip"
		else
			pi500 game 4way
			cheevos -L fbneo "$RA/roms/MAME/pacman.zip"
		fi
	fi
}
