#!/bin/bash
#
# helpers for starting up into console or desktop session

makelink() {
	[ "$( file -b "${2}" | cut -d' ' -f4- )" = "${1}" ] || ln -sf "${1}" "${2}"
}

replace() {
	grep -q "$1" "$3" && sed -i "s/$1/$2/g" "$3"
}

# assure 512mb filesystem reservation
rootdev="/dev/`lsblk -l | grep '/$' | awk '{ print $1 }'`"
let -i blocks=`sudo tune2fs -l $rootdev | grep 'Reserved block count' | awk -F: '{ print $2 }' | tr -d ' '`
[ $blocks -ne 65536 ] && sudo tune2fs -r $(( 64 * 1024 )) $rootdev

#
# check for this machine's Bluetooth adapter to fix the gap with Plasma control
ADAPTER=$(bluetoothctl list | awk '{print $2}')
if ! grep -cq "${ADAPTER}_powered=true" ~/.config/bluedevilglobalrc ; then

cat > ~/.config/bluedevilglobalrc <<EOD
[Adapters]
${ADAPTER}_powered=true

[Devices]
connectedDevices=

[Global]
launchState=enable
EOD

bluetoothctl power on
fi

# count of active network adapters
let net=$((`tail +2 /proc/net/arp | wc -l`+0))

# mount access to my GDrive Bookshelf folder
if ! pidof -q rclone ; then
	sudo umount Bookshelf &> /dev/null
	rclone mount Bookshelf: Bookshelf --daemon &
fi
# Plymouth startup
#sudo plymouth-set-default-theme solar
#sudo update-initramfs -u

# assure critical logical links have not changed ... 
RA=/retroarch
[ -n "$XDG_RUNTIME_DIR" ] && RT="$XDG_RUNTIME_DIR" || RT=/run/user/$UID
makelink "${RA}" "${HOME}/.config/"
makelink "${RA}/content_favorites.lpl" "${RT}/"
#makelink themesettings/es-theme-carbon-master.sys "${RA}/.emulationstation/es_settings.cfg"
# ... and make a runtime copy of the base configuration
[ -f $RT/retroarch.cfg ] || cp $RA/template.cfg $RT/retroarch.cfg
sudo cp -p $RA/content_video_history.lpl $RA/playlists/builtin/
makelink "${RT}/retroarch.cfg" "${RA}/"
[ -d "${RT}/chromium" ] || mkdir "${RT}/chromium"
makelink "${RT}/chromium" "${HOME}/.cache/"
[ -d "${RT}/thumbnails" ] || mkdir "${RT}/thumbnails"
makelink "${RT}/thumbnails" "${HOME}/.cache/"

# if using an official Pi keyboard, replace missing hotkeys with these alternatives
if lsusb | grep 'Raspberry Pi' | grep -qc 'Keyboard' ; then
	sed -i 's/input_game_focus_toggle = ".*"/input_game_focus_toggle = "'capslock'"/' \
		$RT/retroarch.cfg
	sed -i 's/input_pause_toggle = ".*"/input_pause_toggle = "'num0'"/' \
		$RT/retroarch.cfg
fi

# checks between Raspberry models, else assume a gamer Linux PC  :)
case $MODEL in
linux)
	;;
Pi4*)
	makelink "libCameraInterface.pi4" "$RA/scripts/Lightgun/Application/libCameraInterface.so"
	makelink "libSdlInterface.pi4" "$RA/scripts/Lightgun/Application/libSdlInterface.so"
	shader=$( grep shader_enable "$RA/config/Beetle PCE/Beetle PCE.cfg" | awk -F= '{ print $2 }' | tr -d [:punct:][:space:] )
	[ "$shader" = "false" ] || sed -i 's/shader_enable = ".*"/shader_enable = "false"/' "$RA/config/Beetle PCE/Beetle PCE.cfg"
	replace '(bsnes-jg)' '(Snes9x - Current)' "$RA/playlists/Nintendo - Super Nintendo Entertainment System.lpl"
	replace '(bsnes-jg)' '(Snes9x - Current)' "$RA/content_favorites.lpl"
	replace '(bsnes-jg)' '(Snes9x - Current)' "$RA/playlists_consoles/content_favorites.lpl"
	replace 'bsnes-jg_' 'snes9x_' "$RA/playlists/Nintendo - Super Nintendo Entertainment System.lpl"
	replace 'bsnes-jg_' 'snes9x_' "$RA/content_favorites.lpl"
	replace 'bsnes-jg_' 'snes9x_' "$RA/playlists_consoles/content_favorites.lpl"
	makelink "Flycast.pi4" "$RA/config/Flycast/Flycast.opt"
	makelink "Sega Dreamcast.pi4" "$RA/config/Flycast/Sega Dreamcast.cfg"
	makelink "../zfast-crt.glslp" "$RA/config/MAME/MAME.glslp"
	makelink "../zfast-crt.slangp" "$RA/config/MAME/MAME.slangp"
	makelink "../global.glslp" "$RA/config/Mupen64Plus-Next/Nintendo 64.glslp"
	makelink "../global.slangp" "$RA/config/Mupen64Plus-Next/Nintendo 64.slangp"
	makelink "Nintendo 64.pi4" "$RA/config/Mupen64Plus-Next/Nintendo 64.opt"
	#drc=$( grep _drc $RA/config/PCSX-ReARMed/PCSX-ReARMed.opt | awk -F= '{ print $2 }' | tr -d [:punct:][:space:] )
	#[ "$drc" = "disabled" ] || sed -i 's/_drc = ".*"/_drc = "disabled"/' $RA/config/PCSX-ReARMed/PCSX-ReARMed.opt
	makelink "../zfast-crt.glslp" "$RA/config/PCSX-ReARMed/PCSX-ReARMed.glslp"
	makelink "../zfast-crt.slangp" "$RA/config/PCSX-ReARMed/PCSX-ReARMed.slangp"
	makelink "../zfast-crt.glslp" "$RA/config/PPSSPP/PPSSPP.glslp"
	makelink "../zfast-crt.slangp" "$RA/config/PPSSPP/PPSSPP.slangp"
	makelink "../zfast-crt.glslp" "$RA/config/VICE x128/C128-VDC.glslp"
	makelink "../zfast-crt.slangp" "$RA/config/VICE x128/C128-VDC.slangp"
	makelink "../zfast-crt.glslp" "$RA/config/Yabause/Yabause.glslp"
	makelink "../zfast-crt.slangp" "$RA/config/Yabause/Yabause.slangp"
	;;
Pi5*)
	makelink "libCameraInterface.pi5" "$RA/scripts/Lightgun/Application/libCameraInterface.so"
	makelink "libSdlInterface.pi5" "$RA/scripts/Lightgun/Application/libSdlInterface.so"
	shader=$( grep shader_enable "$RA/config/Beetle PCE/Beetle PCE.cfg" | awk -F= '{ print $2 }' | tr -d [:punct:][:space:] )
	[ "$shader" = "true" ] || sed -i 's/shader_enable = ".*"/shader_enable = "true"/' "$RA/config/Beetle PCE/Beetle PCE.cfg"
	replace '(Snes9x - Current)' '(bsnes-jg)' "$RA/playlists/Nintendo - Super Nintendo Entertainment System.lpl"
	replace '(Snes9x - Current)' '(bsnes-jg)' "$RA/content_favorites.lpl"
	replace '(Snes9x - Current)' '(bsnes-jg)' "$RA/playlists_consoles/content_favorites.lpl"
	replace 'snes9x_' 'bsnes-jg_' "$RA/playlists/Nintendo - Super Nintendo Entertainment System.lpl"
	replace 'snes9x_' 'bsnes-jg_' "$RA/content_favorites.lpl"
	replace 'snes9x_' 'bsnes-jg_' "$RA/playlists_consoles/content_favorites.lpl"
	makelink "Flycast.pi5" "$RA/config/Flycast/Flycast.opt"
	makelink "Sega Dreamcast.pi5" "$RA/config/Flycast/Sega Dreamcast.cfg"
	makelink "../zfast-composite.glslp" "$RA/config/MAME/MAME.glslp"
	makelink "../zfast-composite.slangp" "$RA/config/MAME/MAME.slangp"
	makelink "../zfast-composite.glslp" "$RA/config/Mupen64Plus-Next/Nintendo 64.glslp"
	makelink "../zfast-composite.slangp" "$RA/config/Mupen64Plus-Next/Nintendo 64.slangp"
	makelink "Nintendo 64.pi5" "$RA/config/Mupen64Plus-Next/Nintendo 64.opt"
	#drc=$( grep _drc "$RA/config/PCSX-ReARMed/PCSX-ReARMed.opt" | awk -F= '{ print $2 }' | tr -d [:punct:][:space:] )
	#[ "$drc" = "disabled" ] || sed -i 's/_drc = ".*"/_drc = "disabled"/' "$RA/config/PCSX-ReARMed/PCSX-ReARMed.opt"
	makelink "../zfast-composite.glslp" "$RA/config/PCSX-ReARMed/PCSX-ReARMed.glslp"
	makelink "../zfast-composite.slangp" "$RA/config/PCSX-ReARMed/PCSX-ReARMed.slangp"
	makelink "../zfast-composite.glslp" "$RA/config/PPSSPP/PPSSPP.glslp"
	makelink "../zfast-composite.slangp" "$RA/config/PPSSPP/PPSSPP.slangp"
	makelink "../zfast-composite.glslp" "$RA/config/VICE x128/C128-VDC.glslp"
	makelink "../zfast-composite.slangp" "$RA/config/VICE x128/C128-VDC.slangp"
	makelink "../zfast-composite.glslp" "$RA/config/Yabause/Yabause.glslp"
	makelink "../zfast-composite.slangp" "$RA/config/Yabause/Yabause.slangp"
	;;
esac
