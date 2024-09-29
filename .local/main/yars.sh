# source from menu
xy=800
oneshot() {
	compete "Yar's Revenge${OFF} (c) 05/19${ON}82 Atari" VCS
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} CANNON ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "Yar must nibble or shoot through a barrier in order to" 2
	frame "fire the Zorlon Cannon into the breach and destroy the" 2
	frame "evil Qotile." 2
	frame "Use Difficulty A for harder gameplay." 2
	if anykey "A2600 - Yars' Revenge.pdf" ; then
		if [ "$got" = "n" ]; then
			qstart -L stella2014 "$RA/roms/Atari 2600/Yars' Revenge (USA).zip"
		else
			cheevos -L stella2014 "$RA/roms/Atari 2600/Yars' Revenge (USA).zip"
		fi
	fi
}
