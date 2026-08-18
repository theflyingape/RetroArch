# source from menu
xy=896
oneshot() {
	pick "The Game of Life ${OFF} (c) 09/19${ON}98 Hasbro Interactive"
	roms='PlayStation'
	content='Game of Life (USA)'
	anykey && qstart -L pcsx_rearmed "$RA/roms/PlayStation/Game of Life, The (USA).chd"
}
