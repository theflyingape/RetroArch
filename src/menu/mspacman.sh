# source from menu
xy=720
oneshot() {
	compete "Ms. Pac-Man${OFF} (c) 19${ON}81 Midway"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "In its initial run 110,000 units were produced in the U.S." 2
	frame "making it the best selling domestic arcade video game of" 2
	frame "all time."
	if anykey ; then
		if [ "$got" = "n" ]; then
			qstart -L mame2003_plus "$RA/roms/MAME 2003-Plus/mspacman.zip"
		else
			cheevos -L fbneo "$RA/roms/Tournament/mspacman.zip"
		fi
	fi
}
