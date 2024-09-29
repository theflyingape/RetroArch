# source from menu
xy=720
oneshot() {
	compete "Galaxian${OFF} (c) 10/19${ON}79 Namco"
	frame "${PAD}${KEY} ${LEFT} ${OFF}${HBAR}${ON}•${OFF}${HBAR}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} FIRE ${OFF}" 2
	frame "" 2
	frame "A color video game that took dimes (1 or 2) per play." 2
	frame "The Galaxian Flagship became a trademark and made cameo" 2
	frame "appearances in other Namco classics. It is also my Gravitar." 2
	if anykey ; then
		if [ "$got" = "n" ]; then
			qstart -L mame2003_plus "$RA/roms/MAME 2003-Plus/galaxian.zip"
		else
			cheevos -L fbneo "$RA/roms/Tournament/galaxian.zip"
		fi
	fi
}
