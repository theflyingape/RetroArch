# source from menu
xy=896
oneshot() {
	pick "Gauntlet${OFF} (c) 12/19${ON}85 Atari"
	frame "${PAD}   ${KEY} ${UP} ${OFF}" 2
	frame "${PAD}${KEY} ${LEFT} ${OFF} + ${KEY} ${RIGHT} ${OFF}  ${KEY} FIRE ${OFF}  ${KEY} MAGIC ${OFF}" 2
	frame "${PAD}   ${KEY} ${DOWN} ${OFF}" 2
	frame "" 2
	frame "This is a classic quarter-eating machine, as up to 4 players" 2
	frame "can join in anytime and adding coins for health during game." 2
	frame "The game setup is in an Easier mode with 2x Health per coin." 2
	frame "Stay motionless for 30 health for all doors to open, and for" 2
	frame "180 health to allow all the walls to turn into exits." 2
	frame "The first 8 levels are the same. The next 92 are random." 2
	anykey && arcade "gauntlet"
}
