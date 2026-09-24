# source from menu
xy=1024
oneshot() {
	compete "Hustle${OFF} (c) 05/19${ON}77 Gremlin"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}${ON}${HBAR}${CROSS}${HBAR}${OFF}${KEY} ${RIGHT} ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame 
	frame "Simple as it may be, you cannot beat"
	frame "my high score. ;)"
	if anykey; then
		pi500 mame 4way
		if [ "$got" = "n" ]; then
			arcade hustle
		else
			cheevos -L fbneo "$RA/roms/Final Burn Alpha/hustle.zip"
		fi
	fi
}
