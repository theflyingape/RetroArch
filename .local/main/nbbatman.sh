# source from menu
xy=1024
oneshot() {
	pick "Ninja Baseball Batman${OFF} (c) 10/19${ON}93 Irem"
	frame "Up to ${DIM}4${OFF} players in this classic fun beat'em up!" 2
	frame "A deep fighting system with a lot of special moves." 2
	frame "" 2
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} ATTACK ${OFF}  ${KEY} JUMP ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	anykey && arcade nbbatman mame
}
