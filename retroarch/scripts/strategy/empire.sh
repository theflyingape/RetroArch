# source from menu
xy=1024
oneshot() {
	comp AMIGA "Empire${OFF} - Wargame of the Century"
	frame "\e[A\e[16C(c) 08/19${ON}88 Interstel" 2
	frame "" 2
	frame "Keyboard/Mouse turn-based strategy game." 2
	frame "More sophisticated than ${DIM}Risk${OFF}, this is another famous port from"
	frame "a 19${ON}77${OFF} mainframe onto many home computers of the time." 2
	frame "An interesting read of the autobiographies off page 67."
	anykey "Amiga - Empire - Wargame of the Century.pdf" && qstart -L puae "$RA/roms/WHDLoad/Empire.adf"
}
