# source from menu
xy=720
oneshot() {
	compete "Frogger${OFF} (c) 06/19${ON}81 Konami"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}${ON}${HBAR}${CROSS}${HBAR}${OFF}${KEY} ${RIGHT} ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	if anykey ; then
		if [ "$got" = "n" ]; then
			qstart -L mame2003_plus "$RA/roms/MAME 2003-Plus/frogger.zip"
		else
			cheevos -L fbneo "$RA/roms/Tournament/frogger.zip"
		fi
	fi
}
