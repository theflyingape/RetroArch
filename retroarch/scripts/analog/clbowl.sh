# source from menu
xy=720
oneshot() {
	pick "Coors Light Bowling"
        frame "\e[A\e[21C(c) 19${ON}89 Incredible Technologies" 2
	frame "${PAD} left" 2
	frame "${PAD}${KEY} STICK ${OFF}  ${LEFT}${KEY} HOOK ${OFF}  ${KEY} HOOK ${OFF}${RIGHT}" 2
	frame "${PAD}aim/roll" 2
	anykey && arcade "clbowl"
}
