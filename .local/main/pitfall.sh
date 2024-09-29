# source from menu
xy=896
oneshot() {
	compete "Pitfall!${OFF} (c) 08/19${ON}82 Activision" VCS
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}${ON}${HBAR}${CROSS}${HBAR}${OFF}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} JUMP ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "First to set World Record 'Bank Heist' for the Fastest"
	frame "Time recorded (49.31 sec) to pick up the first money bag."
	frame "It was tied 2-weeks later after I posted how I did it."
	if anykey "A2600 - Pitfall! - Pitfall Harry's Jungle Adventure.pdf" ; then
		if [ "$got" = "n" ]; then
			qstart -L stella2014 "$RA/roms/Atari 2600/Pitfall! - Pitfall Harry's Jungle Adventure (USA).zip"
		else
			cheevos -L stella2014 "$RA/roms/Atari 2600/Pitfall! - Pitfall Harry's Jungle Adventure (USA).zip"
		fi
	fi
}
