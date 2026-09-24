# source from menu
xy=1024
oneshot() {
	pick "Mario Party 2${OFF} (c) 01/20${ON}00 Nintendo" N64
	if anykey "N64 - Mario Party 2.pdf"; then
		qstart -L mupen64plus_next "$RA/roms/Nintendo 64/Mario Party 2 (USA).zip"
	fi
}
