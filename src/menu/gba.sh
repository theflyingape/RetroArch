# source from menu
oneshot() {
	comp AMIGA "GBA Championship Basketball${OFF} (c) 19${ON}86 Activision"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} PASS ${OFF} or hold to JUMP/SHOOT" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "Don's favorite C64 game. \"Put it in!\""
	frame "He fared the same with this Amiga port."
	roms=PUAE
	content=GBAChampionshipBasketball_v1.0_2948
	anykey && qstart -L puae "$RA/roms/WHDLoad/GBAChampionshipBasketball_v1.0_2948.lha"
}
