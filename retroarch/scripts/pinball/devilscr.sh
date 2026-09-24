# source from menu
xy=1280
oneshot() {
	pick "Devil's Crush${OFF} 10/19${ON}90 NEC"
	frame "Hold ${KEY} A ${OFF} button down to launch" 2
	frame "${KEY} ${LEFT} ${OFF} for left flipper" 2
	frame "${KEY} A ${OFF} for right flipper" 2
	anykey "TG16 - Devil's Crush.pdf" && qstart -L mednafen_pce "$RA/roms/TurboGrafX-16/Devil's Crush (USA).zip"
}
