# source from menu
xy=1024
oneshot() {
	compete "Black Tiger${OFF} (c) 08/19${ON}87 Capcom"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}${ON}${HBAR}${CROSS}${HBAR}${OFF}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} HIT ${OFF}  ${KEY} JUMP ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	if anykey ; then
		if [ "$got" = "n" ]; then
			pi500 mame fire2
			arcade blktiger
		else
			pi500 game fire2
			cheevos -L fbneo "$RA/roms/MAME/blktiger.zip"
		fi
	fi
}
