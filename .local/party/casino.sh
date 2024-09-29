# source from menu
xy=896
oneshot() {
	comp Dreamcast "Hoyle Casino ${OFF} (c) 20${ON}00${OFF} Sierra"
	frame "Sega Dreamcast on display." 2
	[ "$MODEL" = "Pi5" ] || frame "Might not run well on your ${MODEL}" 2
	roms='Flycast'
	content='casino'
	anykey "Dreamcast - Hoyle Casino.pdf" && qstart -L flycast "$RA/roms/Sega Dreamcast/Hoyle Casino (USA).chd" < /dev/null
}
