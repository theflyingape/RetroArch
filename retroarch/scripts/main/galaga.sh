# source from menu
xy=720
oneshot() {
	compete "Galaga${OFF} (c) 09/19${ON}81 Namco"
	frame "${PAD}${KEY} ${LEFT} ${OFF}${HBAR}${ON}•${OFF}${HBAR}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} FIRE ${OFF}" 2
	frame "" 2
	frame "It is possible to end the game with a 200% ratio. The 200% hit-miss" 2
	frame "ratio trick can only be done with your first shot of the game." 2
	frame "When the game starts, don't move, and fire only one shot. If you" 2
	frame "time it correctly, two enemies will be killed at once." 2
	frame "Let your remaining ships be destroyed -- perfect, eh?" 2
	if anykey ; then
		if [ "$got" = "n" ]; then
			pi500 mame lr fire
			qstart -L mame2003_plus "$RA/roms/MAME 2003-Plus/galaga.zip"
		else
			pi500 game lr fire
			cheevos -L fbneo "$RA/roms/MAME/galaga.zip"
		fi
	fi
}
