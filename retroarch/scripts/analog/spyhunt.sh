# source from menu
xy=720
oneshot() {
	pick "Spy Hunter${OFF} (c) 01/19${ON}84 Bally Midway"
	frame "Best played with a PS5 DualSense controller" 2
	frame 
	frame "${PAD} ${KEY} GAS ${OFF}    ${KEY}${RED}  GUN  ${OFF}" 2
	frame "${PAD} ${KEY}SHIFT${OFF}    ${KEY}MISSILE${OFF}" 2
	frame "${PAD}           ${KEY}SMOKE${OFF}" 2
	frame "${PAD}${LEFT}${KEY}STICK${OFF}${RIGHT}  ${KEY}VAN${OFF}   ${KEY}OIL${OFF}" 2
	frame "${PAD}            ${KEY}GUN${OFF}" 2
	# assign DualSense feedback patterns for Gas Pedal and Maching Gun trigger
	TRIGGER=( "left vibration-raw 0 1 2 3 4 5 6 7 8 8 127" "right machine 1 9 7 7 9 1" )
	anykey && arcade spyhunt mame
}
