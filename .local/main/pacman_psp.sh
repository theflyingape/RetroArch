# source from menu
xy=1112
oneshot() {
	pick "Pac-Man Championship Edition${OFF} (c) 02/20${ON}11 Namco"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}${ON}${HBAR}${CROSS}${HBAR}${OFF}${KEY} ${RIGHT} ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	anykey && qstart -L ppsspp "$RA/roms/PSP/0397 - Pac-Man Championship Edition (USA) (minis) (PSN).iso"
}
