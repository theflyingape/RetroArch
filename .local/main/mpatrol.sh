# source from menu
xy=1024
oneshot() {
	compete "Moon Patrol${OFF} (c) 05/19${ON}82 Irem"
	frame "${PAD}${KEY} ${LEFT} ${OFF} - ${KEY} ${RIGHT} ${OFF}  ${KEY} FIRE ${OFF}  ${KEY} JUMP ${OFF}" 2
	frame "" 2
	frame "The first game to feature parallax scrolling." 2
	if anykey ; then
		if [ "$got" = "n" ]; then
			qstart -L mame2003_plus "$RA/roms/MAME 2003-Plus/mpatrol.zip"
		else
			cheevos -L fbneo "$RA/roms/Tournament/mpatrol.zip"
		fi
	fi
}
