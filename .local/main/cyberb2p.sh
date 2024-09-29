# source from menu
xy=1024
oneshot() {
	pick "Cyberball - Football in the 21st Century"
	frame "\e[A\e[24C${OFF}(c) 11/19${ON}89 Atari Games" 2
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}${ON}${HBAR}${CROSS}${HBAR}${OFF}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} PASS ${OFF} or TURBO" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	anykey && arcade cyberb2p
}
