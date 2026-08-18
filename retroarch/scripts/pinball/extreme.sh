# source from menu
xy=1024
oneshot() {
	pick "Extreme Pinball${OFF} 4/19${ON}96 Electronic Arts"
	frame "" 2
	anykey && qstart -L pcsx_rearmed "$RA/roms/PlayStation/extreme pinball (usa).chd"
}
