# source from menu
xy=1024
oneshot() {
	comp AMIGA "TV Sports: Basketball${OFF} (c) 19${ON}90 Cinemaware"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} ACTION ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	roms=PUAE
	content=TVSportsBasketball_v1.0_2122
	anykey "Amiga - TV Sports - Basketball.pdf" && qstart -L puae "$RA/roms/WHDLoad/TVSportsBasketball_v1.0_2122.lha"
}

