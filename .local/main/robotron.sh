# source from menu
xy=1024
oneshot() {
	pick "Robotron: 2084${OFF} (c) 03/19${ON}82 Williams"
	frame "${PAD} left     right" 2
	frame "${PAD}${KEY} STICK ${OFF}  ${KEY} STICK ${OFF}" 2
	frame "${PAD} move     fire" 2
	frame "" 2
	frame "The design was influenced by ${ON}Berzerk${OFF} and the Commodore PET game" 2
	frame "${ON}Chase${OFF}.  The inspiration for the character Mikey was from the" 2
	frame "1970's commercial for 'Life' cereal." 2
	anykey && arcade "robotron"
}
