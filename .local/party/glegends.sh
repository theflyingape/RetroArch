# source from menu
xy=896
oneshot() {
	comp Dreamcast "Gauntlet Legends ${OFF} (c) 20${ON}00${OFF} Midway"
	frame "Sega Dreamcast on display." 2
	[ "$MODEL" = "Pi5" ] || frame "Might not run well on your ${MODEL}" 2
	roms='Flycast'
	content='glegends'
	anykey && qstart -L flycast "$RA/roms/Sega Dreamcast/Gauntlet Legends (USA).chd" < /dev/null
}
