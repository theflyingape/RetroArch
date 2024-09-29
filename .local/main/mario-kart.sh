# source from menu
xy=1024
oneshot() {
	compete "Super Mario Kart ${OFF}(c) 08/19${ON}92 Nintendo"
	frame "L/R Button hop or power slide" 2
	frame "${PAD}        ${KEY} Mirror ${OFF}" 2
	frame "${PAD}${KEY} Brakes ${OFF}   ${KEY}${RED} FIRE ${OFF}" 2
	frame "${PAD}        ${KEY}   Go ${OFF}" 2
	if anykey "SNES - Super Mario Kart.pdf" ; then
		if [ "$got" = "n" ]; then
			qstart -L snes9x "$RA/roms/Super Nintendo/Super Mario Kart (USA).zip"
		else
			cheevos -L bsnes-jg "$RA/roms/Super Nintendo/Super Mario Kart (USA).zip"
		fi
	fi
}
