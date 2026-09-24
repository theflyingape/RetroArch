# source from menu
xy=720
oneshot() {
	compete "Space Invaders${OFF} (c) 07/19${ON}78 Taito"
	frame "${PAD}${KEY} ${LEFT} ${OFF}${HBAR}${ON}•${OFF}${HBAR}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} FIRE ${OFF}" 2
	if anykey ; then
		if [ "$got" = "n" ]; then
			pi500 mame lr fire
			arcade invaders
		else
			pi500 game lr fire
			cheevos -L fbneo "$RA/roms/MAME/invaders.zip"
		fi
	fi
}
