# source from menu
xy=1024
oneshot() {
	compete "OutRun ${OFF}(c) 09/19${ON}86 Sega"
	frame " ${PAD}${KEY} ${LEFT} ${OFF}${HBAR}${ON}•${OFF}${HBAR}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} SHIFT ${OFF}" 2
	frame "R1${KEY} BRAKE ${OFF}          ${KEY} GAS ${OFF}R2" 2
	if anykey ; then
		if [ "$got" = "n" ]; then
			pi500 mame
			qstart -L mame2003_plus "$RA/roms/MAME 2003-Plus/outrun.zip"
		else
			pi500 game
			cheevos -L fbneo "$RA/roms/MAME/outrun.zip"
		fi
	fi
}
