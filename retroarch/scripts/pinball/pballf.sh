# source from menu
xy=1024
oneshot() {
	comp AMIGA "Pinball Fantasies${OFF} (c) 19${ON}91 Digital Illusions"
	frame "1-8 players! Use Left/Right ${KEY} SHIFT ${OFF} flippers" 2
	frame "Down ${KEY} ${DOWN} ${OFF} arrow to pull/release the ball" 2
	roms=PUAE
	content=PinballFantasies_v2.6c_0025
	anykey "Amiga - Pinball Fantasies.pdf" && qstart -L puae "$RA/roms/WHDLoad/PinballFantasies_v2.6c_0025.lha"
}
