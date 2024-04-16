# source from menu
xy=720
oneshot() {
	compete "Krull ${OFF}(c) 03/19${ON}83 Gottlieb"
	frame "${PAD} left     right" 2
	frame "${PAD}${KEY} STICK ${OFF}  ${KEY} STICK ${OFF}" 2
	frame "${PAD} move     fire" 2
	frame "" 2
	frame "Insanely difficult, but I did save Lyssa TWICE," 2
	frame "but 3x is needed to Master this game." 2
	if anykey ; then
		if [ "$got" = "n" ]; then
			qstart -L mame2003_plus "$RA/roms/MAME 2003-Plus/krull.zip"
		else
			cheevos -L fbneo "$RA/roms/Tournament/krull.zip"
		fi
	fi
}
