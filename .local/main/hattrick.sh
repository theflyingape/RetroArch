# source from menu
xy=896
oneshot() {
	pick "Hat Trick${OFF} (c) 19${ON}84 Bally Sente"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}${ON}${HBAR}${CROSS}${HBAR}${OFF}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} SHOOT ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "Despite its simple skate, shoot and save gameplay, it" 2
	frame "was considered one of the better sports games of the" 2
	frame "early 1980's." 2
	anykey && arcade "hattrick"
}
