# source from menu
xy=1024
oneshot() {
	pick "Mario Kart 64${OFF} (c) 12/19${ON}96 Nintendo" N64
	frame "Use left stick to steer and hold ${KEY} A ${OFF} to accelerate." 2
	frame "Use right stick to change camera or display." 2
	frame "${KEY} B ${OFF} brake or with left stick to reverse" 2
	frame "${KEY} L2 ${OFF} use item" 2
	frame "${KEY} R1 ${OFF} hops (drift)" 2
	anykey && qstart -L mupen64plus_next "$RA/roms/Nintendo 64/Mario Kart 64 (USA).zip"
}
