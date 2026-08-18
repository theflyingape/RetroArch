# source from menu
xy=1024
oneshot() {
	pick "Mortal Kombat ${OFF}(c) 07/19${ON}92 Midway"
	pi500 mame
	anykey && arcade "mk"
}
