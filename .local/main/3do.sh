# source from menu
xy=896
oneshot() {
	comp 3DO "Road Rash ${OFF} (c) 07/19${ON}94${OFF} Electronic Arts"
	frame "3DO Interactive on display." 2
	[ "$MODEL" = "Pi5" ] || frame "Might not run well on your ${MODEL}" 2
	roms='3DO'
	content='Road Rash (USA)'
	anykey && qstart -L opera "$RA/roms/3DO/Road Rash (USA).chd"
}
