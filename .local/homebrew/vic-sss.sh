# source from menu
oneshot() {
	comp VIC "Sprite Invaders${OFF} (c) ${ON}Robert Hurst"
	frame "${PAD}${KEY} ${LEFT} ${OFF} - ${KEY} ${RIGHT} ${OFF}  ${KEY} FIRE ${OFF}" 2
	frame "" 2
	frame "Written as part of my VIC Software Sprite Stack library" 2
	frame "to demonstrate its 'repeating sprites' feature." 2
	roms='VICE xvic'
	content='sprite invaders'
	anykey "VIC20 - Sprite Invaders.pdf" && qstart -L vice_xvic "$RA/roms/homebrews/VIC20/8KB/sprite invaders.prg"
}
