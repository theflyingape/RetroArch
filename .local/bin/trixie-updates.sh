#!/bin/sh

RT=/run/user/$UID
GD=$RT/GDrive
DEST="$GD/Retro/updates"
[ -d $GD ] || mkdir -v $GD
pidof rclone || rclone mount GDrive: $GD --daemon
df -Th $GD

AGE=9M
START=`date +'%I:%M%P'`
echo "$START :: Purge any FILE older than $AGE = $(date --date='9 months ago')"
find $DEST -type f -mtime +273 -exec rm -fv {} \;
echo "`date +'%I:%M%P'` :: Purge any FOLDER older than $AGE = $(date --date='9 months ago')"
find $DEST -type d -ctime +273 -exec rmdir {} &> /dev/null \;
rclone cleanup GDrive:

cd ~/BIG/trixie
touch asof --date='9 months ago'

# fuse complicates rclone
GD="GDrive:"
DEST="$GD/Retro/updates"

# trixie system
echo "`date +'%I:%M%P'` :: etc"
rclone copy --update --max-age $AGE addons.deb $DEST
rclone sync --update --max-age $AGE etc $DEST/etc

# home
echo "`date +'%I:%M%P'` :: pi home"
rclone copy --update --max-age $AGE pi/.bashrc $DEST/pi --links
for file in .local/bin bin Documents ; do
	rclone sync --update --max-age $AGE ":local,links:pi/$file" $DEST/pi/$file #--links
done

# application
echo "`date +'%I:%M%P'` :: emulation cores & playlists"
rclone sync --update --progress --max-age $AGE retroarch/cores $DEST/retroarch/cores
rclone sync --update --progress --max-age $AGE retroarch/playlists $DEST/retroarch/playlists
rm -fv "${DEST}/retroarch/playlists/builtin/*"

# emulationstation :: retroarch
echo "`date +'%I:%M%P'` :: retroarch "
rclone copy --update --max-age $AGE --max-depth 0 retroarch/.emulationstation $DEST/retroarch/.emulationstation --links
rclone copy --update --max-age $AGE retroarch/.emulationstation/themesettings $DEST/retroarch/.emulationstation/themesettings
rclone sync --update --max-age $AGE retroarch/bin $DEST/retroarch/bin
rclone sync --update --max-age $AGE ":local,links:retroarch/scripts" $DEST/retroarch/scripts
for file in retroarch/*.cfg ; do
	[ "$file" = "retroarch/cheevos.cfg" ] && continue
	[ "$file" = "retroarch/retroarch.cfg" ] && continue
	[ "$file" -nt asof ] && rclone copy --inplace --max-age $AGE $file $DEST/retroarch
done

# config & overlays
echo "`date +'%I:%M%P'` :: config & overlays "
for folder in retroarch/config retroarch/overlays ; do
	rclone sync --update --progress --max-age $AGE ":local,links:$folder" "$DEST/$folder" #--links #--create-empty-src-dirs
done

echo "`date +'%I:%M%P'` :: es game lists"
oifs=$IFS
IFS=$'\n'; gamelists=(`find retroarch/roms/ -name gamelist.xml -printf '%p\n'`)
IFS=$oifs
for i in `seq 0 $(( ${#gamelists[@]} - 1 ))`; do
	file="${gamelists[$i]}"
	folder="$( dirname "${gamelists[$i]}" )"
	[ "$file" -nt asof ] && rclone copy --inplace --max-age $AGE "$file" "$DEST/$folder" --links #--create-empty-src-dirs
done

echo "`date +'%I:%M%P'` :: es game assets"
for media in docs media mixart snap wheel ; do
	oifs=$IFS
	IFS=$'\n'; assets=(`find retroarch/roms/ -name $media -type d -printf '%p\n' | sort`)
	IFS=$oifs
	echo "$media folders (${#assets[@]})"
	for i in `seq 0 $(( ${#assets[@]} - 1 ))`; do
		folder="${assets[$i]}"
		echo "[$i] $folder"
		rclone sync --update --progress --max-age $AGE ":local,links:$folder" "$DEST/$folder" #--create-empty-src-dirs
	done
done

cd -

# fini
echo
echo "Started $START thru `date +'%I:%M%P'`"
echo
exit
