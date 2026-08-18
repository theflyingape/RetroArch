# source from menu
xy=1024
oneshot() {
	compete "Moon Patrol${OFF} (c) 05/19${ON}82 Irem"
	frame "${PAD}${KEY} ${LEFT} ${OFF}${HBAR}${ON}•${OFF}${HBAR}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} FIRE ${OFF}  ${KEY} JUMP ${OFF}" 2
	frame "" 2
	frame "The first game to feature parallax scrolling." 2
	if anykey ; then
		if [ "$got" = "n" ]; then
			pi500 mame fire2
			qstart -L mame2003_plus "$RA/roms/MAME 2003-Plus/mpatrol.zip"
		else
			pi500 game fire2
			cheevos -L fbneo "$RA/roms/MAME/mpatrol.zip"
		fi
	fi
}
