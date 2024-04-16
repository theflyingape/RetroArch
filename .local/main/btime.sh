# source from menu
xy=720
oneshot() {
	compete "Burger Time${OFF} (c) 19${ON}82 Data East"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} PEPPER ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "It's possible to move chef Peter Pepper up & down on the ladders" 2
	frame "faster using rapid presses, rather than holding the direction." 2
	if anykey ; then
		if [ "$got" = "n" ]; then
			qstart -L mame2003_plus "$RA/roms/MAME 2003-Plus/btime.zip"
		else
			cheevos -L fbneo "$RA/roms/MAME 2003-Plus/btime.zip"
		fi
	fi
}
