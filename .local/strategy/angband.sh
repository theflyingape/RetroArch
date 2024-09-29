# source from menu
oneshot() {
	frame "\e[uAngband ${OFF}v3.5.1 January 20${ON}15${OFF}"
	frame "" 2
	frame "A variant of the classic turn-based dungeon crawler," 2
	frame "${ON}Umoria${OFF} since April 19${ON}93${OFF}."
	frame "It is a harsh game that can end suddenly from one" 2
	frame "careless move. RUN AWAY is a tactical move." 2
	if anykey "Linux - Angband Handbook.pdf"; then
		audio "sounds/bravery.mp3"
		reset
		angband
		gameover
	fi
}
