#!/bin/sh

# stick
if [ "$1" = "usb" ]; then

MP=/media/pi/rootfs
df $MP || exit

rsync -av --delete --exclude=.cache --exclude=.dbus --exclude=.npm --exclude=.vscode \
	--exclude=build \
	--exclude=Bookshelf --exclude=Music --exclude=Videos \
	. $MP/home/pi/
rsync -av --delete --exclude=logs/* --exclude=content_history.lpl \
	/retroarch/ $MP/retroarch/

exit

fi

# server
src="BIG/Bookworm"
rsync -av --delete --exclude=.cache --exclude=.dbus --exclude=.npm --exclude=.vscode \
	--exclude=build \
	--exclude=Bookshelf --exclude=Music --exclude=Videos \
	~/ $1:$src/pi/

rsync -av --delete --exclude=logs/* --exclude=content_history.lpl \
	--exclude=roms \
	/retroarch/ $1:$src/retroarch/

if [ "$2" = "all" ]; then
	rsync -crlv --delete ~/[A-Z]* $1:$src/pi/
fi
