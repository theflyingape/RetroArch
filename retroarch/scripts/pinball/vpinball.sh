# source from menu
xy=800
oneshot() {
	compete "Video Pinball ${OFF}(c) 06/19${ON}80 Atari" VCS
	frame "${PAD}${KEY} ${LEFT} ${OFF} - ${KEY} ${RIGHT} ${OFF}  ${KEY} FIRE ${OFF}" 2
	frame "" 2
	if anykey "A2600 - Video Pinball.pdf" ; then
		if [ "$got" = "n" ]; then
			qstart -L stella "$RA/roms/Atari 2600/Video Pinball (USA).a26"
		else
			cheevos -L stella "$RA/roms/Atari 2600/Video Pinball (USA).a26"
		fi
	fi
}
