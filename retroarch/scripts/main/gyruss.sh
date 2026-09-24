# source from menu
xy=720
oneshot() {
	compete "Gyruss${OFF} (c) 03/19${ON}83 Konami"
	frame "${PAD}${KEY} ${LEFT} ${OFF}${HBAR}${ON}•${OFF}${HBAR}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} FIRE ${OFF}" 2
	if anykey ; then
		if [ "$got" = "n" ]; then
			pi500 mame lr fire
			#qstart -L mame "$RA/roms/MAME/gyruss.zip"
			qstart -L mame2003_plus "$RA/roms/MAME 2003-Plus/gyruss.zip"
		else
			pi500 game lr fire
			cheevos -L fbneo "$RA/roms/MAME/gyruss.zip"
		fi
	fi
}
