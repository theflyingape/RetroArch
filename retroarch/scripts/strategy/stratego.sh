# source from menu
xy=1024
oneshot() {
	comp AMIGA "Stratego${OFF} (c) 19${ON}91 Accolade" 2
	frame "" 2
	frame "Mouse turn-based strategy game." 2
	anykey "Amiga - Stratego.pdf" && qstart -L puae "$RA/roms/WHDLoad/Stratego_v1.1.1.lha"
}
