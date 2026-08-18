# source from menu
xy=896
oneshot() {
	pick "Pole Position${OFF} (c) 09/19${ON}82 Namco"
	frame "${PAD}shoulder" 2
	frame "${PAD}${KEY} SHIFT ${OFF}${DOWN}${UP}" 2
	frame "${PAD}      left" 2
	frame "${PAD}     ${KEY} STICK ${OFF}  ${KEY} GAS ${OFF}  ${KEY} BRAKE ${OFF}" 2
	frame "${PAD}      rotate" 2
	frame "" 2
	frame "Use SHIFT to toggle between LO / HI gear. Check that it's in LO gear" 2
	frame "before START for quicker acceleration. Shift into HI before 180km." 2
	frame "Either release GAS or shift into LO to better navigate hairpin turn." 2
	frame "STICK steering will only slowly re-center itself.  As the Driver," 2
	frame "you rotate the wheel back to center without over-correcting." 2
	anykey && arcade "polepos"
}
