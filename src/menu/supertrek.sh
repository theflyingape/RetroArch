# source from menu
xy=896
oneshot() {
	comp C64 "Super Trek 64+${OFF} (c) 19${ON}85 ShareData"
	frame "The 19${ON}71${OFF} Star Trek mainframe computer game" 2
	frame "remade for the home computer." 2
	roms='VICE x64sc'
	content='supertrek'
	anykey && qstart -L vice_x64sc "$RA/roms/homebrews/C64/supertrek.prg"
}
