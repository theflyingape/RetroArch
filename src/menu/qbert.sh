# source from menu
oneshot() {
	compete "Q*bert${OFF} (c) 10/19${ON}82 Gottlieb"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "Hold the joypad rotated 45\x0ef\x0f clockwise to align the" 2
	frame "4-way directional buttons with the cubes." 2
	if anykey ; then
		if [ "$got" = "n" ]; then
			qstart -L mame2003_plus "$RA/roms/MAME 2003-Plus/qbert.zip"
		else
			cheevos -L fbneo "$RA/roms/Tournament/qbert.zip"
		fi
	fi
}
