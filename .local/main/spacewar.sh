# source from menu
xy=1024
oneshot() {
	comp AMIGA "Space War${OFF} (c) Jul 19${ON}93 Amiga Power #27"
	frame "Two player F-U-N !!!  (Just ask Don)" 2
	frame "Hold mouse right-button down for Amiga pulldown menu" 2
	frame "gameplay options. By default, the players for the" 2
	frame "Romulan ship are the cursor arrow keys while the" 2
	frame "Enterprise ship uses a joystick." 2
	roms=PUAE
	content=
	anykey && qstart -L puae "$RA/roms/Commodore/Amiga/AmigaPower_27_199307.adf"
}
