# source from menu
xy=896
oneshot() {
	compete "Berzerk${OFF} (c) 10/19${ON}80 Stern Electronics"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF}${ON}${HBAR}${CROSS}${HBAR}${OFF}${KEY} ${RIGHT} ${OFF}  ${KEY}${RED} FIRE ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "The first game to feature talking enemies. The speech synthesis" 2
	frame "technology of the time being so new that it cost \$1000 to" 2
	frame "program each individual word into the game's ROM." 2
	frame "I was able to reuse the ROM words into a compatible format that" 2
	frame "allowed my VIC 20 conversion, ${ON}Berzerk MMX${OFF}, to speak using a" 2
	frame "software technique off its Volume register." 2
	if anykey ; then
		if [ "$got" = "n" ]; then
			pi500 mame fire
			arcade berzerk
		else
			pi500 game fire
			cheevos -L fbneo "$RA/roms/MAME/berzerk.zip"
		fi
	fi
}
