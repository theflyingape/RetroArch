# source from menu
xy=720
oneshot() {
	pick "Space Invaders '95 ${OFF}(c) 06/19${ON}95 Taito"
	frame "${PAD}${KEY} ${LEFT} ${OFF}${HBAR}${ON}•${OFF}${HBAR}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} FIRE ${OFF}  ${KEY} B2 ${OFF}" 2
	frame "\e[17C${KEY} B3 ${OFF}   ${KEY} B4 ${OFF}" 2
	pi500 mame lr fire2
	anykey && arcade "spcnv95u"
}
