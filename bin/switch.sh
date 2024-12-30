#!/bin/sh
#
# switch session to virtual console #1 and activate its 'pi' autologin
#
sudo chvt 5
sudo systemctl restart getty@tty1 &
sudo systemctl stop lightdm
#sudo killall -qw -TERM sddm kwin_wayland_wrapper
exit
