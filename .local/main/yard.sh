# source from menu
xy=1024
oneshot() {
	pick "10-yard Fight ${OFF}(c) 12/19${ON}83 Irem"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} RB ${OFF}  ${KEY} WR ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame 
	frame "My 'go to' game upon arrival at ${DIM}DG's Arcade${OFF} in Warwick,"
	frame "RI (19${ON}83${OFF}-${ON}89${OFF}). Regan would team up and play Victory"
	frame "Road, Marble Madness, Paperboy, Super Sprint, Toobin',"
	frame "Two Tigers and Field Combat -- when it was working."
	frame "I'd finish with Gridiron Fight or Time Pilot '84, but"
	frame "always their sitdown cockpit version of Star Trek."
	anykey && arcade 10yard mame
}
