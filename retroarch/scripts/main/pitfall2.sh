# source from menu
xy=896
oneshot() {
	compete "Pitfall II: Lost Caverns${OFF} (c) 02/19${ON}84 Activision" VCS
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}${ON}${HBAR}${CROSS}${HBAR}${OFF}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} JUMP ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	if anykey "A2600 - Pitfall II - Lost Caverns.pdf" ; then
		pi500 game fire
		if [ "$got" = "n" ]; then
			qstart -L stella "$RA/roms/Atari 2600/Pitfall II - Lost Caverns (USA).a26"
		else
			cheevos -L stella "$RA/roms/Atari 2600/Pitfall II - Lost Caverns (USA).a26"
		fi
	fi
}
