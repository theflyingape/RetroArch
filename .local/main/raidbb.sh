# source from menu
xy=896
oneshot() {
	comp C64 "Raid on Bungeling Bay${OFF} (c) 19${ON}84 Broderbund"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} FIRE ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "Your task is to BOMB all 6 factories protected by" 2
	frame "guns, tanks, and planes. If not, The War Machine" 2
	frame "will pursue and take out your carrier and win." 2
	frame "Hold FIRE for 1/2 sec & release to DROP BOMB." 2
	roms='VICE x64sc'
	content='Raid on Bungeling Bay'
	anykey "C64 - Raid on Bungeling Bay.pdf" && qstart -L vice_x64sc "$RA/roms/C64 Replay/Raid on Bungeling Bay.crt"
}
