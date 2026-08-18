#!/bin/bash
#
# switch session to virtual console #1 and activate its 'pi' autologin
#
# prompt player
#	-icon-name "input-gaming" \
if [ -n "$DISPLAY" ]; then
	MESA="using MESA Vulkan `sudo apt info mesa-vulkan-drivers 2> /dev/null | grep ^Version`"
	zenity --question --no-wrap --timeout=300 --width=512 \
	--icon "$HOME/.local/share/icons/retroarch-96x96.png" \
	--title="Console Playlists Menu" \
	--text="<big>Linux KMS console mode <i>without the overhead</i>\n</big><tt> </tt>${MESA}\n\n<tt>    </tt><i>Read the</i> <tt>HELP</tt> <i>document for full details.</i>\n<big>\n<tt>   </tt>&#127482;&#127480;<tt> </tt><span foreground='red'><b>M</b>y <b>A</b>wesome <b>G</b>ames <b>A</b>rchive</span></big>\n<tt>       </tt>&#169;2021-2026<tt> </tt><span foreground='midnight blue' underline='none'><a href='https://github.com/theflyingape' title='GitHub'>The Flying Ape &#128279; </a></span>" \
	 --cancel-label="🚫 Exit back to Desktop" --ok-label="🎮 Switch to Linux shell"
	declare -i PLAY=$?
	[ $PLAY -eq 0 ] || exit
fi

sudo chvt 5
killall labwc &> /dev/null
sudo systemctl restart getty@tty1 &
sudo systemctl stop lightdm
#sudo killall -qw -TERM sddm kwin_wayland_wrapper
# simplify audio services in console mode
#systemctl --user stop pipewire.socket pipewire &> /dev/null
#systemctl --user stop wireplumber &> /dev/null
#systemctl --user restart pulseaudio.socket pulseaudio &> /dev/null
source /retroarch/scripts/MASTER || MASTER="48%"
wpctl set-volume @DEFAULT_AUDIO_SINK@ "$MASTER"
exit
