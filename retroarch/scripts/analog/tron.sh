# source from menu
xy=720
oneshot() {
	pick "Tron${OFF} (c) 05/19${ON}82 Bally Midway"
	frame "${PAD} left     right" 2
	frame "${PAD}${KEY} STICK ${OFF}  ${KEY} STICK ${OFF}  ${KEY} FIRE ${OFF}" 2
	frame "${PAD} move      aim" 2
	frame "" 2
	frame "The levels were named after programming languages and terminology." 2
	frame "The game starts out at RPG and advances through PASCAL, BASIC," 2
	frame "ASSEMBLER, etc. until the USER level is reached." 2
	frame "Don't forget to twirl the knob as you rise into the MCP CONE." 2
	anykey && arcade "tron"
}
