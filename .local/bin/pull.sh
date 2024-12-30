#!/bin/sh

alias rsync='rsync -a --delete --exclude=build --exclude=Bookshelf --info=BACKUP,COPY,DEL,NAME1'

# server
src="rhurst@beelink:BIG/rpi"
# home
rsync "$src/pi/.local/bin" ~/.local/
rsync "$src/pi/bin" ~/
# extensive check
[ "$1" = "all" ] && rsync -crl "$src/pi/[A-Z]*" ~/
# RetroArch
rsync --exclude=logs/* --exclude=content_history.lpl \
	--exclude=*PlayStation\ 2 \
	"$src/retroarch/" /retroarch/
