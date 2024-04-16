# source from menu
oneshot() {
	comp VIC "Omega Fury${OFF} (c) ${ON}Robert Hurst"
	frame "${PAD}    ${KEY} THRUST ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}  ROTATE  ${KEY} ${RIGHT} ${OFF}  ${KEY} FIRE ${OFF}" 2
	frame "${PAD}     ${KEY} SLOW ${OFF}" 2
	frame "" 2
	frame "My sequel inspired by \e[1;34mC\e[31m=${OFF} Andy Finkel's ${ON}Omega Race${OFF}." 2
	frame "It was the first game cartridge I bought for VIC 20 in 19${ON}82${OFF}." 2
	frame "It also opened a window for me into 'hi-res' graphics" 2
	frame "and ${ON}6502${OFF} machine code programming." 2
	roms='VICE xvic'
	content='omega-fury'
	anykey "VIC20 - Omega Fury.pdf" && qstart -L vice_xvic "$RA/roms/homebrews/VIC20/16KB/omega-fury.prg"
}
