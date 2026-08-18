#!/bin/sh

ROMS="`dirname $0`"
DISC="`basename $1`"
NAME="${DISC%.*}"
CMD="$ROM/$DISK/$NAME.commands"

[ -f "$CMD" ] && params=$(< "$CMD" )

cd /retroarch/system/hypseus

echo hypseus "$NAME" vldp -framefile "$ROMS/$DISC/$NAME.txt" -fullscreen -vulkan \
	-bezel default.png -fastboot $params > /run/user/1000/rerun.sh

hypseus "$NAME" vldp -framefile "$ROMS/$DISC/$NAME.txt" -fullscreen -vulkan \
	-bezel default.png -fastboot $params
