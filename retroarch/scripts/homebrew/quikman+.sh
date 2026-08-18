# source from menu
oneshot() {
	comp VIC "Quikman+${OFF} (c) ${ON}Robert Hurst"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}${ON}${HBAR}${CROSS}${HBAR}${OFF}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} START ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "The 30-year 'plus' edition to 'pac' both arcade" 2
	frame "games into one. I was motivated to do this after" 2
	frame "Atari 2600 ${ON}Pac-Man${OFF} gouged me for \$35 over its" 2
	frame "marketing hype. My work resulted in a superior" 2
	frame "edition produced on VIC 20 with a cassette tape drive." 2
	frame "I wrote the original in a week, November 19${ON}84${OFF}, and rescued" 2
	frame "it from that saved tape, November 20${ON}08${OFF}, to complete" 2
	frame "it as ${ON}Quikman 2K8${OFF}. My 8K version refreshed 20${ON}14${OFF}." 2
	roms='VICE xvic'
	content='quikman+8k'
	anykey "VIC20 - Quikman+.pdf" && qstart -L vice_xvic "$RA/roms/homebrews/VIC20/8KB/quikman+8k.prg"
}
