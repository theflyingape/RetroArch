# source from menu
oneshot() {
	frame "\e[u0 A.D. Ancient Warfare January 20${ON}23${OFF}"
	frame "" 2
	frame "Since 2001, began as a mod concept for Age of Empires II:" 2
	frame "The Age of Kings" 2
	frame "The player controls any of twelve ancient civilizations" 2
	frame "at its peak: Athenians, Britons, Carthaginians, Gauls," 2
	frame "Iberians, Macedonians, Mauryans, Persians, Ptolemies," 2
	frame "Romans, Seleucids, and Spartans." 2

	if anykey ; then
		reset
		0ad
		gameover
	fi
}
