# source from menu
xy=1024
oneshot() {
	compete "Extra Innings ${OFF}(c) 03/19${ON}92 Sony Imagesoft"
	if anykey "SNES - Extra Innings.pdf" ; then
		pi500 game fire4
		[ $MODEL = "Pi4" ] && core="snes9x" || core="bsnes-jg"
		if [ "$got" = "n" ]; then
			qstart -L $core "$RA/roms/Super Nintendo/Extra Innings (USA).zip"
		else
			cheevos -L $core "$RA/roms/Super Nintendo/Extra Innings (USA).zip"
		fi
	fi
}
