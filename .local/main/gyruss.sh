# source from menu
xy=720
oneshot() {
	compete "Gyruss${OFF} (c) 03/19${ON}83 Konami"
	frame "${PAD} left" 2
	frame "${PAD}${KEY} STICK ${OFF}  ${KEY} FIRE ${OFF}" 2
	frame "${PAD} rotate" 2
	if anykey ; then
		if [ "$got" = "n" ]; then
			qstart -L mame2003_plus "$RA/roms/MAME 2003-Plus/gyruss.zip"
		else
			cheevos -L fbneo "$RA/roms/Tournament/gyruss.zip"
		fi
	fi
}
