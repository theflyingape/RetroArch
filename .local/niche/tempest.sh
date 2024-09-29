# source from menu
xy=720
oneshot() {
	compete "Tempest${OFF} (c) 10/19${ON}81 Atari"
	frame "Best used with a mouse/trackball." 2
	if anykey ; then
		if [ "$got" = "n" ]; then
			arcade tempest
		else
			cheevos -L fbneo "/$RA/roms/Tournament/tempest.zip"
		fi
	fi
}
