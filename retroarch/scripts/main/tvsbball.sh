# source from menu
xy=1024
oneshot() {
	comp AMIGA "TV Sports: Basketball${OFF} (c) 19${ON}90 Cinemaware"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}${ON}${HBAR}${CROSS}${HBAR}${OFF}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} ACTION ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "Got this game shortly after Erin was born. Randy came over"
	frame "and took my spare A500 as a free upgrade over his C128 with"
	frame "this game and many others."
	roms=PUAE
	content=TVSportsBasketball_v1.0_2122
	pi500 reset comp
	anykey "Amiga - TV Sports - Basketball.pdf" && qstart -L puae "$RA/roms/WHDLoad/TVSportsBasketball_v1.0_2122.lha"
}

