# source from menu
xy=1024
oneshot() {
	compete "Extra Innings ${OFF}(c) 03/19${ON}92 Sony Imagesoft"
	if anykey "SNES - Extra Innings.pdf" ; then
		if [ "$got" = "n" ]; then
			qstart -L snes9x "$RA/roms/Super Nintendo/Extra Innings (USA).zip"
		else
			cheevos -L snes9x "$RA/roms/Super Nintendo/Extra Innings (USA).zip"
		fi
	fi
}
