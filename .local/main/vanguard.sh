# source from menu
xy=720
oneshot() {
	pick "Vanguard${OFF} (c) 10/19${ON}81 SNK / Centuri"
	frame "${PAD} left     right" 2
	frame "${PAD}${KEY} STICK ${OFF}  ${KEY} STICK ${OFF}" 2
	frame "${PAD} move     fire" 2
	frame "" 2
	frame "An early shooter I played at Brunswick Lanes" 2
	frame "during my junior bowling league days that winter" 2
	frame "19${ON}81${OFF}-${ON}82${OFF}."
	frame "Your ship flies through a tunnel with multiple" 2
	frame "zones including diagonally. Be careful!" 2
	anykey && arcade vanguard
}
