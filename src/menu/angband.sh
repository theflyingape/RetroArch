# source from menu
oneshot() {
	frame "\e[uAngband ${OFF}v3.5.1 January 20${ON}15${OFF}"
	frame "" 2
	frame "A variant of the classic turn-based dungeon crawler," 2
	frame "${ON}Moria${OFF}. It is a harsh game that can end suddenly" 2
	frame "from one careless move." 2
	if anykey "Linux - Angband Handbook.pdf"; then
		audio "sounds/bravery.mp3"
		reset
		angband
		gameover
	fi
}
