#!/bin/bash
#
# save an incremental update offline to the workstation
# 
rm -fv /retroarch/.emulationstation/.mypy_cache
rm -fv /retroarch/.emulationstation/*.log
rm -fv /retroarch/.emulationstation/es_log*

shopt -s expand_aliases extglob
alias rsync='rsync -ai --delete --exclude=build --exclude=Bookshelf --info=BACKUP,COPY,DEL,NAME1'

# server
target="theflyingape@beelink:BIG/rpi+"
rsync --exclude=.cache --exclude=.dbus --exclude=.npm --exclude=.vscode \
	--exclude=Music --exclude=Videos \
	~/ $target/pi/

rsync --exclude=logs/* --exclude=content_history.lpl \
	--exclude=roms --exclude=scripts/MASTER \
	/retroarch/ $target/retroarch/

echo "EmulationStation files ... "
while read es ; do
	rsync "$es" "$target$es"
	src=$(dirname "$es")
	for sub in media mixart snap wheel ; do
		rom="$src/$sub"
		[ -e "$rom" ] || continue
		dest=$(dirname "$rom")
		rsync "$rom" "$target$dest/"
	done
done < <( find /retroarch/roms -name gamelist.xml | sort )

if [ "$1" = "all" ]; then
	rsync -cirl ~/[A-Z]* $src/pi/
fi
