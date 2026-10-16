#!/bin/bash
#
# save an incremental update offline to the workstation
# 
rm -fv /retroarch/bin/older/*
rm -fv /retroarch/.emulationstation/.mypy_cache
rm -fv /retroarch/.emulationstation/*.log
rm -fv /retroarch/.emulationstation/es_log*
rm -fv /retroarch/playlists/builtin/content_history.lpl
rm -fv /retroarch/playlists/builtin/content_music_history.lpl
rm -fv /retroarch/playlists/builtin/content_video_history.lpl

# expunge my credentials just to be safe
rm -fv /retroarch/retroarch-keychain.*
sed -i 's/cheevos_username = ".*"/cheevos_username = "magapi"/' /retroarch/cheevos.cfg
sed -i 's/cheevos_password = ".*"/cheevos_password = "pimagatrial"/' /retroarch/cheevos.cfg
for cfg in /retroarch/.emulationstation/themesettings/*.sys ; do
	sed -i 's/ts.password" value=".*"/ts.password" value="pimagatrial"/' $cfg
	sed -i 's/ts.token" value=".*"/ts.token" value=""/' $cfg
	sed -i 's/ts.account" value=".*"/ts.account" value="magapi"/' $cfg
done

shopt -s expand_aliases extglob
alias rsync='rsync -ai --delete --exclude=build --exclude=Bookshelf --info=BACKUP,COPY,DEL,NAME1'
# server
target="theflyingape@beelink:BIG/trixie"
rsync --exclude=.cache --exclude=.dbus --exclude=.npm --exclude=.vscode \
	--exclude=Music --exclude=Videos \
	~/ $target/pi/

rsync --exclude=logs/* --exclude=roms --exclude=scripts/MASTER --exclude=system --exclude=thumbnails \
	/retroarch/ $target/retroarch/

echo "EmulationStation files ... "
while read es ; do
	rsync "$es" "$target$es"
done < <( find /retroarch/roms -name gamelist.xml | sort )
for sub in docs media mixart snap wheel ; do
	while read stuff ; do
		rsync "$stuff/" "$target$stuff/"
	done < <( find /retroarch/roms -name $sub -type d | sort )
done

if [ "$1" = "all" ]; then
	rsync -cirl ~/[A-Z]* $target/pi/
fi

if [ "$1" = "emu" ]; then
	rsync -cirl /retroarch/roms/ $target/retroarch/roms/
	rsync -cirl /retroarch/system/ $target/retroarch/system/
	rsync -cirl /retroarch/thumbnails/ $target/retroarch/thumbnails/
fi
