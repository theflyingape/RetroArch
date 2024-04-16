# source from menu
xy=896
oneshot() {
	compete "Pitfall II: Lost Caverns${OFF} (c) 02/19${ON}84 Activision" VCS
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} JUMP ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	if anykey "A2600 - Pitfall II - Lost Caverns.pdf" ; then
		if [ "$got" = "n" ]; then
			qstart -L stella "$RA/roms/Atari 2600/Pitfall II - Lost Caverns (USA).zip"
		else
			cheevos -L stella "$RA/roms/Atari 2600/Pitfall II - Lost Caverns (USA).zip"
		fi
	fi
}
