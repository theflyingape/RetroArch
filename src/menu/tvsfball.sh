# source from menu
xy=1024
oneshot() {
	comp AMIGA "TV Sports: Football${OFF} (c) 19${ON}88 Cinemaware"
	frame "The best capture of pro football atmosphere of its time." 2
	frame "" 2
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} ACTION ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	roms=PUAE
	content=TVSportsFootball_v1.03_0407
	anykey "Amiga - TV Sports - Football.pdf" && qstart -L puae "$RA/roms/WHDLoad/TVSportsFootball_v1.03_0407.lha"
}
