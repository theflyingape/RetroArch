# source from menu
xy=896
oneshot() {
	comp C64 "Boulder Dash${OFF} (c) 19${ON}84 First Star"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} PUSH ${OFF} (or PULL)" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "You will like this action puzzle game." 2
	frame "Press ${KEY} F1 ${OFF} skip title screens." 2
	frame "Press ${KEY} F3 ${OFF} 1-2 player options." 2
	roms='VICE x64sc'
	content='Boulder Dash'
	anykey "C64 - Boulder Dash.pdf" && qstart -L vice_x64sc "$RA/roms/C64 Replay/Boulder Dash.crt"
}
