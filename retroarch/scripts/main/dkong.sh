# source from menu
xy=720
oneshot() {
	compete "Donkey Kong ${OFF}(c) 07/19${ON}81 Nintendo"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}${ON}${HBAR}${CROSS}${HBAR}${OFF}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} JUMP ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame ""
	frame "Leaderboard score is today's High Score." 2
	if anykey ; then
		if [ "$got" = "n" ]; then
			pi500 mame fire
			qstart -L mame2003_plus "$RA/roms/MAME 2003-Plus/dkong.zip"
		else
			pi500 game fire
			cheevos -L fbneo "$RA/roms/MAME/dkong.zip"
		fi
	fi
}
