# source from menu
oneshot() {
	comp VIC "Sprite Invaders${OFF} (c) ${ON}Robert Hurst"
	frame "${PAD}${KEY} ${LEFT} ${OFF}${HBAR}${ON}•${OFF}${HBAR}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} FIRE ${OFF}" 2
	frame "" 2
	frame "Written as part of my VIC ${ON}Software Sprite Stack${OFF}" 2
	frame "using a 6502 assembler to demonstrate its " 2
	frame "'repeating sprites' feature." 2
	roms='VICE xvic'
	content='sprite invaders'
	anykey "VIC20 - Sprite Invaders.pdf" && qstart -L vice_xvic "$RA/roms/homebrews/VIC20/8KB/sprite invaders.prg"
}
