# source from menu
xy=800
oneshot() {
	compete "MegaMania: a space nightmare ${OFF}(c) 09/19${ON}82 Activision" VCS
	frame "${PAD}${KEY} ${LEFT} ${OFF}${HBAR}${ON}•${OFF}${HBAR}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} FIRE ${OFF}" 2
	frame "" 2
	frame "Gameplay resembles Astro Blaster, but its alien spaceships" 2
	frame "are hamburgers, bow ties, and steam irons." 2
	frame "Difficulty switches affect player missile speed." 2
	if anykey "A2600 - MegaMania - A Space Nightmare.pdf" ; then
		pi500 game fire
		if [ "$got" = "n" ]; then
			qstart -L stella "$RA/roms/Atari 2600/MegaMania - A Space Nightmare (USA).a26"
		else
			cheevos -L stella "$RA/roms/Atari 2600/MegaMania - A Space Nightmare (USA).a26"
		fi
	fi
}
