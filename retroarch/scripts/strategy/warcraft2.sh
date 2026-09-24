# source from menu
xy=1024
oneshot() {
	comp DOS "WarCraft II${OFF} - The Dark Saga"
	frame "\e[A\e[16C(c) 11/19${ON}97 Blizzard Entertainment" 2
	frame "" 2
	frame "Keyboard/Mouse real-time strategy game." 2
	frame "A decent sequel played here on PlayStation." 2
	anykey "PS - WarCraft II - The Dark Saga.pdf" && qstart -L pcsx_rearmed "$RA/roms/PlayStation/warcraft ii - the dark saga (usa) (en,fr,de,es,it).chd"
}
