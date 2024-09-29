# source from menu
xy=1024
oneshot() {
	pick "True Pinball${OFF} 4/19${ON}96 Ocean"
	frame "" 2
	anykey && qstart -L pcsx_rearmed "$RA/roms/PlayStation/true pinball (usa).chd"
}
