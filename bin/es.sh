#!/bin/bash
#
# override ES theme for desktop play
RA=/retroarch
ln -sf $RA/.emulationstation/themesettings/es-theme-carbon-master.sys $RA/.emulationstation/es_settings.cfg
ln -sf $RA/.emulationstation/es_systems.all $RA/.emulationstation/es_systems.cfg

# set Pi 500+ RGB keyboard for critical hotkeys
$RA/scripts/pi500+.py clear game es

# set ambience
BGM="`ls -t $HOME/Music/Background/*.ogg | tail -1`"
touch "$BGM"
ln -sf "$BGM" $RA/assets/sounds/bgm.ogg
ffplay -autoexit -nodisp -loop 1 "$BGM" &> /dev/null &

# prompt player
#	-icon-name "input-gaming" \
zenity --question --no-wrap --timeout=300 --width=512 \
	--window-icon "$HOME/.local/share/icons/retroarch-96x96.png" \
	--title="Batocera EmulationStation kiosk" \
	--text="<big>Press <tt><b>F4</b></tt> to quit the kiosk menu\n</big>\n&#8230; <i>running</i> <tt>RetroArch</tt> content <b>hotkeys</b>\n<tt><b>CAPS LOCK </b></tt>toggles keyboard focus\n<tt><b>      F10 </b></tt>restart content\n<tt><b>   PrtScn </b></tt>take a screenshot\n<tt><b>   Delete </b></tt>quit content\n\n<i>Read the</i> <tt>HELP</tt> <i>document for full details.</i>\n<big>\n&#127482;&#127480;<tt> </tt><span foreground='red'><b>M</b>y <b>A</b>wesome <b>G</b>ames <b>A</b>rchive</span>\n</big><tt>    </tt>&#169;2021-2026<tt> </tt><span foreground='midnight blue' underline='none'><a href='https://github.com/theflyingape' title='GitHub'>The Flying Ape &#128279; </a></span>" \
	 --cancel-label="🚫 Exit to Desktop" --ok-label="🎮 Shall we play a game?"
declare -i PLAY=$?

# do as directed
killall -qw ffplay
[ $PLAY -eq 0 ] && $RA/bin/emulationstation --home $RA
$RA/scripts/pi500+.py reset

# Goodbye! Please call again.
exit
