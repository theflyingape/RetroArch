# source from menu
xy=896
oneshot() {
	compete "Joust${OFF} (c) 09/19${ON}82 Williams"
	frame "${PAD}${KEY} ${LEFT} ${OFF}${HBAR}${ON}•${OFF}${HBAR}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} FLAP ${OFF}" 2
	frame 
	frame "The biggest thrill is killing a pterodactyl." 2
	frame "Or two." 2
	if anykey ; then
		if [ "$got" = "n" ]; then
			pi500 mame lr fire
			arcade joust
		else
			pi500 game lr fire
			cheevos -L fbneo "$RA/roms/MAME 2003-Plus/joust.zip"
		fi
	fi
}
