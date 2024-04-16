# source from menu
xy=720
oneshot() {
	compete "Donkey Kong ${OFF}(c) 07/19${ON}81 Nintendo"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} JUMP ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame ""
	frame "Leaderboard score is today's High Score." 2
	if anykey ; then
		if [ "$got" = "n" ]; then
			qstart -L mame2003_plus "$RA/roms/MAME 2003-Plus/dkong.zip"
		else
			cheevos -L fbneo "$RA/roms/Tournament/dkong.zip"
		fi
	fi
}
