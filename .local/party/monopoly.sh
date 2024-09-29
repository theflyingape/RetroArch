# source from menu
xy=896
oneshot() {
	pick "Monopoly${OFF} (c) 19${ON}92 Parker Brothers"
	roms='Sega Genesis'
	content='Monopoly (USA)'
	anykey && qstart -L genesis_plus_gx "$RA/roms/Sega Genesis/Monopoly (USA).zip"
}
