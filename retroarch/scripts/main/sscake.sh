# source from menu
xy=896
oneshot() {
	compete "Strawberry Shortcake${OFF} (c) 19${ON}83 Parker Brothers" VCS
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "Another game I mastered, heh." 2
	frame "Kids puzzle game that gets harder per ${KEY} SELECT ${OFF} game level." 2
	if anykey "A2600 - Strawberry Shortcake.pdf" ; then
		pi500 game fire
		if [ "$got" = "n" ]; then
			oneshot -L stella "$RA/roms/Atari 2600/Strawberry Shortcake - Musical Match-Ups (USA).a26"
		else
			cheevos -L stella "$RA/roms/Atari 2600/Strawberry Shortcake - Musical Match-Ups (USA).a26"
		fi
	fi
}
