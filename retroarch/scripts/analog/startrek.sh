# source from menu
xy=960
oneshot() {
	pick "Star Trek - Strategic Operations Simulator"
	frame "\e[A\e[35C(c) 19${ON}82 Sega" 2
	frame "${PAD} left    ${KEY} PHOTON ${OFF}  ${KEY} WARP ${OFF}" 2
	frame "${PAD}${KEY} STICK ${OFF}   ${KEY} FIRE ${OFF}  ${KEY} THRUST ${OFF}" 2
	frame "${PAD} rotate" 2
	frame "" 2
	frame "As much as possible to maximize scoring, avoid resupplying" 2
	frame "at a starbase." 2
	anykey && arcade "startrek"
}
