# source from menu
xy=896
oneshot() {
	compete "Super Smash Bros Melee ${OFF} (c) 12/20${ON}01${OFF} Nintendo"
	frame "Nintendo GameCube on display." 2
	frame "For best results, run this game first after a reboot." 2
	[ "$MODEL" = "Pi5" ] || frame "Does not run well on your ${MODEL} - play N64 version" 2
	roms='GameCube'
	content='Super Smash Bros Melee'
	if anykey "GameCube - Super Smash Bros Melee.pdf" ; then
		if [ "$got" = "n" ]; then
			qstart -L mupen64plus_next "$RA/roms/Nintendo 64/Super Smash Bros. (USA).zip"
		else
			qstart -L dolphin "$RA/roms/GameCube/Super Smash Bros. Melee (USA) (En,Ja) (Rev 2).rvz"
		fi
	fi
}
