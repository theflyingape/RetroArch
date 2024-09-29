# source from menu
xy=1024
oneshot() {
	compete "Bubble Bobble${OFF} (c) 08/19${ON}86 Taito"
	frame "${PAD}${KEY} ${LEFT} ${OFF}${HBAR}${ON}•${OFF}${HBAR}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} BUBBLE ${OFF}  ${KEY} JUMP ${OFF}" 2
	frame "" 2
	frame "Simple-yet-involving gameplay with its two-player co-operative" 2
	frame "mode, coupled with the incredible amount of hidden secrets and" 2
	frame "potential for strategic play." 2
	frame "'The Trick!' is matching the 100s & 10s digit after popping" 2
	frame "the last monster." 2
	if anykey ; then
		if [ "$got" = "n" ]; then
			arcade bublbobl
		else
			cheevos -L fbneo "$RA/roms/Tournament/bublbobl.zip"
		fi
	fi
}
