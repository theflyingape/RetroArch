# source from menu
xy=896
oneshot() {
	comp C16 "Jack Attack!${OFF} (c) 19${ON}83 Commodore"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} PUSH/PULL ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "The game title off CEO Jack Tramiel notorious move to teach" 2
	frame "an underachieving employee to 'become Japanese' in business." 2
	frame "" 2
	frame "You will like this game. My only game cartridge purchase for" 2
	frame "my first upgrade off VIC 20 to Commodore 16 on Christmas 19${ON}84" 2
	roms='VICE xplus4'
	content='Jack Attack.bin'
	anykey "C64 - Jack Attack.pdf" && qstart -L vice_xplus4 "$RA/roms/C16/Jack Attack.bin"
}
