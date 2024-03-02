#!/bin/sh
#
# switch session to virtual console #1 and activate its 'pi' autologin
#
sudo chvt 1
sudo systemctl restart getty@tty1 &
sudo killall -qw -TERM sddm kwin_wayland_wrapper
exit
