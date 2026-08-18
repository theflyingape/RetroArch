# source from menu
xy=896
oneshot() {
	pick "Armor Attack${OFF} (c) 10/19${ON}80 Cinematronics"
	frame "${PAD}${KEY} ${LEFT} ${OFF}${HBAR}${ON}•${OFF}${HBAR}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} FIRE ${OFF}  ${KEY} GAS ${OFF}" 2
	frame "" 2
	frame "The morse code sound effects spell out a message," 2
	frame "\"${ON}Don't register${OFF}\", as a form of protest by its" 2
	frame "programmer against draft registration that had been" 2
	frame "recently re-instated." 2
	pi500 mame lr fire2
	anykey && arcade armora mame
}
