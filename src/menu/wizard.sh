# source from menu
xy=896
oneshot() {
	comp C64 "Wizard${OFF} (c) 19${ON}84 Progressive Peripherals & Software"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} JUMP ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "A more sophisticated ${ON}Jumpman${OFF} game." 2
	frame "Use ${KEY} SPACE ${OFF} to release spell." 2
	roms='VICE x64sc'
	content='wizard'
	anykey "C64 - Ultimate Wizard.pdf" && qstart -L vice_x64sc "$RA/roms/C64/wizard.d64"
}
