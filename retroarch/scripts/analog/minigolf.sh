# source from menu
xy=896
oneshot() {
	pick "Mini Golf${OFF} (c) 11/19${ON}85 Bally Sente"
	frame "${PAD} left" 2
	frame "${PAD}${KEY} STICK ${OFF}  ${KEY} PLACE ${OFF}" 2
	frame "${PAD} putt" 2
	frame "" 2
	frame "PLACE ball on one of the matt's starting position." 2
	frame "PUTT in the direction & force from an analog device." 2
	anykey && arcade "minigolf"
}
