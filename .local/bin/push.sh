#!/bin/sh

rm -fv /retroarch/.emulationstation/*.log
rm -fv /retroarch/.emulationstation/es_log*

alias rsync='rsync -ai --delete --exclude=build --exclude=Bookshelf --info=BACKUP,COPY,DEL,NAME1'

# server
src="rhurst@beelink:BIG/rpi"
rsync --exclude=.cache --exclude=.dbus --exclude=.npm --exclude=.vscode \
	--exclude=Music --exclude=Videos \
	~/ $src/pi/

rsync --exclude=logs/* --exclude=content_history.lpl \
	--exclude=roms \
	/retroarch/ $src/retroarch/

for es in gamelist.xml media mixart snap wheel ; do
	for rom in /retroarch/roms/**/$es ; do
		dest=$(dirname "$rom")
		rsync "$rom" "$src$dest/"
 	done
done

if [ "$1" = "all" ]; then
	rsync -cirl ~/[A-Z]* $src/pi/
fi
