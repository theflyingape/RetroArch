# source from menu
xy=896
oneshot() {
	comp Dreamcast "Club Kart 2K3 ${OFF} (c) 20${ON}02 Sega"
	frame "Sega Dreamcast on display." 2
	roms='Flycast'
	content='clubk2k3'
	anykey && qstart -L flycast "$RA/roms/Sega Dreamcast/clubk2k3.zip"
}
