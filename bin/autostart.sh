#!/bin/sh
#
# helpers for starting up into console or desktop session
#

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

pidof -q rclone || rclone mount Bookshelf: Bookshelf --daemon
#pidof -q btop || sudo openvt -f -c 7 btop &

RA=/retroarch
[ -n "$XDG_RUNTIME_DIR" ] && RT="$XDG_RUNTIME_DIR" || RT=/run/user/$UID
ln -sf $RA $HOME/.config/
ln -sf $RA/content_favorites.lpl $RT/

cp $RA/template.cfg $RT/retroarch.cfg

# if using an official Pi keyboard, replace missing hotkeys with these alternatives
if lsusb | grep 'Raspberry Pi' | grep -qc 'Keyboard' ; then
	sed -i 's/input_game_focus_toggle = ".*"/input_game_focus_toggle = "'numlock'"/' \
		$RT/retroarch.cfg
	sed -i 's/input_pause_toggle = ".*"/input_pause_toggle = "'num0'"/' \
		$RT/retroarch.cfg
fi
