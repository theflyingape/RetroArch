# source from menu
xy=1024
oneshot() {
	compete "Super Mario Kart ${OFF}(c) 08/19${ON}92 Nintendo"
	if anykey "SNES - Super Mario Kart.pdf" ; then
		if [ "$got" = "n" ]; then
			qstart -L snes9x "$RA/roms/Super Nintendo/Super Mario Kart (USA).zip"
		else
			cheevos -L snes9x "$RA/roms/Super Nintendo/Super Mario Kart (USA).zip"
		fi
	fi
}
