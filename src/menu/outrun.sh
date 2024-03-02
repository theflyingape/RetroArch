# source from menu
xy=1024
oneshot() {
	compete "OutRun ${OFF}(c) 09/19${ON}86 Sega"
	frame "    ${KEY} ${LEFT} ${OFF} - ${KEY} ${RIGHT} ${OFF}  ${KEY} GEAR ${OFF}" 2
	frame "R1${KEY} BRAKE ${OFF}       ${KEY} GAS ${OFF}R2" 2
	if anykey ; then
		if [ "$got" = "n" ]; then
			qstart -L mame2003_plus "$RA/roms/MAME 2003-Plus/outrun.zip"
		else
			cheevos -L fbneo "$RA/roms/Tournament/outrun.zip"
		fi
	fi
}
