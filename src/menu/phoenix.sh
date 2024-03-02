# source from menu
xy=720
oneshot() {
	compete "Phoenix ${OFF}(c) 12/19${ON}80 Amstar"
	frame "${PAD}${KEY} ${LEFT} ${OFF} - ${KEY} ${RIGHT} ${OFF}  ${KEY} FIRE ${OFF}  ${KEY} SHIELD ${OFF}" 2
	frame "" 2
	frame "No Leaderboards -- shoot, or die!" 2
	if anykey ; then
		if [ "$got" = "n" ]; then
			qstart -L mame2003_plus "$RA/roms/MAME 2003-Plus/phoenix.zip"
		else
			cheevos -L fbneo "$RA/roms/Tournament/phoenix.zip"
		fi
	fi
}
