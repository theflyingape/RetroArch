# source from menu
oneshot() {
	comp VIC "Quikman+${OFF} (c) ${ON}Robert Hurst"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "The 30-year 'plus' edition to 'pac' both arcade games into one." 2
	frame "My challenge after Atari 2600 ${ON}Pac-Man${OFF} gouged me for \$35" 2
	frame "-- its marketing hype was not even close to expectations --" 2
	frame "to produce a superior video game port on VIC 20." 2
	frame "I wrote the original in a week, November 19${ON}84${OFF}, and rescued" 2
	frame "it from a saved cassette tape, November 20${ON}08${OFF}, to complete" 2
	frame "my challenge dubbed ${ON}Quikman 2K8${OFF}." 2
	roms='VICE xvic'
	content='quikman+8k'
	anykey "VIC20 - Quikman+.pdf" && qstart -L vice_xvic "$RA/roms/homebrews/VIC20/8KB/quikman+8k.prg"
}
