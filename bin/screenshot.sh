#!/bin/sh

SCREENSHOT=~/Pictures/console-`date +'%Y%m%d-%H%M%S'`.png
fbcat /dev/fb0 | convert - $SCREENSHOT
chmod 664 $SCREENSHOT
chown pi:games $SCREENSHOT
