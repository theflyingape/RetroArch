# source from menu
xy=1024
oneshot() {
	comp VIC "Break-out!${OFF} (c) ${ON}Robert Hurst"
	frame "Best used with a mouse/trackball." 2
	frame "" 2
	frame "I had always wanted to write a Paddle game," 2
	frame "having grown up playing Pong and variants." 2
	roms='VICE xvic'
	content='break-out!'
	anykey && qstart -L vice_xvic "$RA/roms/homebrews/VIC20/8KB/break-out!.prg"
}
