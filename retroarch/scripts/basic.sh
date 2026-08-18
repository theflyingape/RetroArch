# source from menu
oneshot() {
	frame "\e[uBASIC - learn how to program"
	frame "" 2
	frame "Press ${KEY} Ctrl ${OFF}-${KEY} 1 ${OFF} to load last program" 2
	frame "Click File -> Exit or press ${KEY} Ctrl ${OFF}-${KEY} Q ${OFF}" 2

	if anykey ; then
		reset
		env XCURSOR_SIZE=48 weston --shell=kiosk-shell.so --use-pixman --xwayland \
			-c $RA/scripts/basic.ini 2>$RT/weston.err
		gameover
	fi
}
