# source from menu
xy=1112
oneshot() {
	pick "Space Invaders Extreme${OFF} (c) 06/20${ON}08 Taito"
	frame "${PAD}${KEY} ${LEFT} ${OFF}${HBAR}${ON}•${OFF}${HBAR}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} FIRE ${OFF}" 2
	anykey && qstart -L ppsspp "$RA/roms/PSP/Space Invaders Extreme (USA).iso"
}
