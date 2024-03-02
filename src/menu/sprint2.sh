# source from menu
xy=896
oneshot() {
	pick "Sprint 2${OFF} (c) 11/19${ON}76 Atari"
	frame "    ${KEY}  TRACK  ${OFF}    ${KEY}   GAS   ${OFF}" 2
	frame "${PAD} left   ${PAD} ${KEY} G4 ${OFF}" 2
	frame "${PAD}${KEY} STICK ${OFF}   ${KEY} G3 ${OFF}    ${KEY} G1 ${OFF}" 2
	frame "${PAD} steer  ${PAD} ${KEY} G2 ${OFF}" 2
	frame "" 2
	frame "Let's start at the very beginning ... " 2
	frame "This hit followed ${DIM}Sea Wolf${OFF} and ${DIM}Night Driver${OFF}, marking" 2
	frame "the end of the ${ON}50${OFF}-year run for electro-mechanical" 2
	frame "arcade games." 2
	anykey && arcade sprint2
}
