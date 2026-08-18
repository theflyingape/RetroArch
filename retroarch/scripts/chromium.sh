# source from menu
oneshot() {
	frame "\e[uChromium web browser"
	frame "" 2
	frame "Close browser window or press ${KEY} Ctrl ${OFF}-${KEY} W ${OFF}" 2

	if anykey ; then
		reset
		env XCURSOR_SIZE=48 weston --shell=kiosk-shell.so --use-pixman --xwayland \
			-c $RA/scripts/chromium.ini 2>$RT/weston.err
		gameover
	fi
}
