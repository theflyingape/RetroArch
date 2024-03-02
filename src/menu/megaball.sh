# source from menu
oneshot() {
	comp AMIGA "MegaBall${OFF} (c) 19${ON}95 Ed Mackey"
	frame "Use mouse as the game paddle for 1 or 2 players."
	roms=PUAE
	content=MegaBall_v1.02_1MB
	anykey && qstart -L puae "$RA/roms/WHDLoad/MegaBall_v1.02_1MB.lha"
}

