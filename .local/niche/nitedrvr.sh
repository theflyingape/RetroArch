# source from menu
xy=896
oneshot() {
	compete "Night Driver ${OFF}(c) 10/19${ON}76 Atari"
	frame "${PAD}    left" 2
	frame "${PAD}   ${KEY} STICK ${OFF}  ${KEY} GAS ${OFF}  ${KEY} GEAR${UP} ${OFF}  ${KEY} GEAR${DOWN} ${OFF}" 2
	frame "${PAD}    rotate" 2
	frame "" 2
	frame "Another game I mastered, heh." 2
	frame "Leaderboard score is today's High Score." 2
	if anykey ; then
		if [ "$got" = "n" ]; then
			qstart -L mame2003_plus "$RA/roms/MAME 2003-Plus/nitedrvr.zip"
		else
			cheevos -L fbneo "$RA/roms/Tournament/nitedrvr.zip"
		fi
	fi
}
