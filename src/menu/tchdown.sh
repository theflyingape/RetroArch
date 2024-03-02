# source from menu
xy=800
oneshot() {
	pick "Touchdown Football${OFF} (c) 19${ON}85 Electronic Arts" 7800
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} ACTION ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame ""
	frame "Early attempt at football on 8-bit. As Madden said"
	frame "to the EA programmers, \"Where's the other guys?\""
	frame "I played this on my C128 home computer along with"
	frame "${ON}On-Field Football${OFF} and ${ON}10-yard Fight${OFF} at the arcade."
	anykey "A7800 - Touchdown Football.pdf" && qstart -L prosystem "$RA/roms/Atari 7800/tchdown.bin"
}
