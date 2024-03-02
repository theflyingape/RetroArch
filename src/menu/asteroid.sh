# source from menu
xy=896
oneshot() {
	compete "Asteroids${OFF} (c) 11/19${ON}79 Atari"
	frame "${PAD}${KEY} ${LEFT} ${OFF} - ${KEY} ${RIGHT} ${OFF}  ${KEY} FIRE ${OFF}  ${KEY} THRUST ${OFF}  ${KEY} WARP ${OFF}" 2
	frame "" 2
	frame "Originally called Cosmos, Asteroids original design brief" 2
	frame "was a simple copy of Space Wars; with asteroids littering" 2
	frame "the playfield purely for visual effect. Two years later," 2
	frame "Atari introduced the concept of free-floating rocks." 2
	frame "On 17 June 19${ON}80${OFF}, Atari's Asteroids and Lunar Lander were" 2
	frame "the first two video games to ever be registered in the" 2
	frame "Copyright Office." 2
	if anykey ; then
		if [ "$got" = "n" ]; then
			qstart -L mame2003_plus "$RA/roms/MAME 2003-Plus/asteroid.zip"
		else
			cheevos -L fbneo "$RA/roms/Tournament/asteroid.zip"
		fi
	fi
}
