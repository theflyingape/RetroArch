# source from menu
xy=1024
oneshot() {
	pick "RISK${OFF} 05/19${ON}98 Hasbro Interactive"
	frame "The classic board game of global domination." 2
	anykey "PS - Risk.pdf" && qstart -L pcsx_rearmed "$RA/roms/PlayStation/risk - the game of global domination (usa).chd"
}
