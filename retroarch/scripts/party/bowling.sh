# source from menu
xy=896
oneshot() {
	compete "Bowling ${OFF}(c) 03/20${ON}00 Tamsoft"
	frame "DATA LOAD from a Memory Card to restore bowler" 2
	frame "profiles and statistics before playing."
	roms='PlayStation'
	content='Bowling (USA)'
	if anykey ; then
		if [ "$got" = "n" ]; then
			qstart -L pcsx_rearmed "$RA/roms/PlayStation/bowling (usa).chd"
		else
			cheevos -L pcsx_rearmed "$RA/roms/PlayStation/bowling (usa).chd"
		fi
	fi
}
