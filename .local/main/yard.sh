# source from menu
xy=1024
oneshot() {
	pick "10-yard Fight ${OFF}(c) 12/19${ON}83 Irem"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} RB ${OFF}  ${KEY} WR ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame 
	frame "My 'go to' game upon arrival at ${DIM}DG's Arcade${OFF}"
	frame "in Warwick, RI.  Then Field Combat, Victory Road,"
	frame "Marble Madness, Paperboy, Super Sprint, Toobin',"
	frame "Star Trek and Gridiron Fight!"
	anykey && arcade 10yard mame
}
