# source from menu
oneshot() {
	comp VIC "Omega Fury${OFF} (c) ${ON}Robert Hurst"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}${ON}${HBAR}${CROSS}${HBAR}${OFF}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} FIRE ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "My sequel inspired by \e[1;34mC\e[31m=${OFF} Andy Finkel's ${ON}Omega Race${OFF}." 2
	frame "It was the first game cartridge I bought for VIC 20 in 19${ON}82${OFF}." 2
	frame "It opened the window for me into 'hi-res' graphics over" 2
	frame "text using ${ON}6502${OFF} machine code programming." 2
	roms='VICE xvic'
	content='omega-fury'
	anykey "VIC20 - Omega Fury.pdf" && qstart -L vice_xvic "$RA/roms/homebrews/VIC20/16KB/omega-fury.prg"
}
