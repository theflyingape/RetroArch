# source from menu
xy=1024
oneshot() {
	comp AMIGA "TV Sports: Football${OFF} (c) 19${ON}88 Cinemaware"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}${ON}${HBAR}${CROSS}${HBAR}${OFF}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} ACTION ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "The best capture of pro football atmosphere of its time."
	frame "As the GOAT, I went 200-0 with Grogan versus Don as he desperately"
	frame "rebuilt team after team: Broncos (Elway), Eagles (Cunningham),"
	frame "and 49ers (Montana then Young) to _finally_ get a win.  ;)"
	roms=PUAE
	content=TVSportsFootball_v1.03_0407
	pi500 reset comp
	anykey "Amiga - TV Sports - Football.pdf" && qstart -L puae "$RA/roms/WHDLoad/TVSportsFootball_v1.03_0407.lha"
}
