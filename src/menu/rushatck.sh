# source from menu
xy=1024
oneshot() {
	compete "Rush'n Attack${OFF} (c) 07/19${ON}85 Konami"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} KNIFE ${OFF}  ${KEY} SHOOT ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "You will mainly rely on your trusty knife for this mission." 2
	if anykey ; then
		if [ "$got" = "n" ]; then
			qstart -L mame2003_plus "$RA/roms/MAME 2003-Plus/rushatck.zip"
		else
			cheevos -L fbneo "$RA/roms/Tournament/rushatck.zip"
		fi
	fi
}
