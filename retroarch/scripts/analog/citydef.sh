# source from menu
xy=1024
oneshot() {
	comp AMIGA "City Defence${OFF} (c) 19${ON}87 Kingsoft"
	frame "Mouse/Trackball with Left/Right buttons." 2
	roms=PUAE
	content=CityDefence_v1.1
	anykey && qstart -L puae "$RA/roms/WHDLoad/CityDefence_v1.1.lha"
}
