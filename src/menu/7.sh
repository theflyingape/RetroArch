# source from menu
xy=896
oneshot() {
	comp VIC "Berzerk-MMX${OFF} (c) ${ON}Robert Hurst"
	frame "${PAD}${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} FIRE ${OFF}" 2
	frame "${PAD}${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "${ON}Amok!${OFF} (sold on cassette tape) was the only clone" 2
	frame "available and was sorely lacking in frenetic gameplay." 2
	roms='VICE xvic'
	content='berzerk-mmx-16k'
	anykey && qstart -L vice_xvic "$RA/roms/homebrews/VIC20/16KB/berzerk-mmx-16k.prg"
}
