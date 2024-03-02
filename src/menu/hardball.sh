# source from menu
xy=896
oneshot() {
	comp AMIGA "Hardball!${OFF} (c) 19${ON}85 Accolade"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} ACTION ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	roms=PUAE
	content=HardBall_v1.0_0490
	anykey "C64 - Hardball!.pdf" && qstart -L puae "$RA/roms/WHDLoad/HardBall_v1.0_0490.lha"
}
