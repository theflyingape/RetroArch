# source from menu
xy=1024
oneshot() {
	comp DOS "WarCraft${OFF} - Orcs and Humans"
	frame "\e[A\e[16C(c) 11/19${ON}94 Blizzard Entertainment" 2
	frame "" 2
	frame "Keyboard/Mouse real-time strategy game." 2
	frame "My first PC running Windows 98 game, followed" 2
	frame "by Microsoft Dungeon Siege.  PC sucks, heh." 2
	anykey "DOS - WarCraft - Orcs & Humans.pdf" && qstart -L dosbox_pure "$RA/roms/DOS/WarCraft - Orcs and Humans (1994).zip"
}
