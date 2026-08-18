# source from menu
xy=720
oneshot() {
	compete "Phoenix ${OFF}(c) 12/19${ON}80 Amstar"
	frame "${PAD}${KEY} ${LEFT} ${OFF}${HBAR}${ON}•${OFF}${HBAR}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} FIRE ${OFF}  ${KEY} SHIELD ${OFF}" 2
	frame "" 2
	frame "No Leaderboards -- shoot, or die!" 2
	if anykey ; then
		if [ "$got" = "n" ]; then
			pi500 mame lr fire2
			qstart -L mame2003_plus "$RA/roms/MAME 2003-Plus/phoenix.zip"
		else
			pi500 game lr fire2
			cheevos -L fbneo "$RA/roms/MAME/phoenix.zip"
		fi
	fi
}
