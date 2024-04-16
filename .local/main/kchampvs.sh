# source from menu
xy=720
oneshot() {
	pick "Karate Champ${OFF} (c) 09/19${ON}84 Data East"
	frame "${PAD} left     right" 2
	frame "${PAD}${KEY} STICK ${OFF}  ${KEY} STICK ${OFF}" 2
	frame "${PAD} move     attack" 2
	frame "" 2
	frame "The seminal one-on-one fighting game." 2
	anykey && arcade "kchampvs"
}
