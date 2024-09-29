# source from menu
xy=720
oneshot() {
	compete "Donkey Kong Jr.${OFF} (c) 08/19${ON}82 Nintendo"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}${ON}${HBAR}${CROSS}${HBAR}${OFF}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} JUMP ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "The only Mario game in which he is cast as the villain." 2
	if anykey ; then
		if [ "$got" = "n" ]; then
			qstart -L mame2003_plus "$RA/roms/MAME 2003-Plus/dkongjr.zip"
		else
			cheevos -L fbneo "$RA/roms/Tournament/dkongjr.zip"
		fi
	fi
}
