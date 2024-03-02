# source from menu
xy=1024
oneshot() {
	pick "Omega Race${OFF} (c) 06/19${ON}81 Midway"
	frame "${PAD} left" 2
	frame "${PAD}${KEY} STICK ${OFF}  ${KEY} THRUST ${OFF}  ${KEY} FIRE ${OFF}" 2
	frame "${PAD} rotate" 2
	frame "" 2
	frame "Its storyline was my inspiration to write a sequel," 2
	frame "${DIM}Omega Fury${OFF}." 2
	anykey && arcade "omegrace"
}
