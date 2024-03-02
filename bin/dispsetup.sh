#!/bin/bash
#
# check Raspbian display config for a 2K setting,
# else setup with no more than 60hz refresh rate
#
LOG=/run/user/$UID/dispsetup.log
echo "$0 $@" > $LOG
echo "DISPLAY=${DISPLAY}" >> $LOG
xrandr -q | head -3 >> $LOG

declare -i res=`xrandr -q | grep -c 'current 1920 x 1080'`
[ $res -gt 0 ] && exit

port=`xrandr -q | grep ' connected ' | awk '{ print $1 }'`
list=( `xrandr -q | grep ' 1920x1080 '` )
rate=60

for i in `seq 1 ${#list[@]}`; do
	[ "${list[$i]}" = "+" ] && continue
	declare -i n=`printf '%d' ${list[$i]} 2> /dev/null`
	[ $n -le $rate ] && break
done

rate="`echo ${list[$i]} | tr -d '*+'`"

# KDE Plasma 5
kscreen-doctor output.HDMI-A-1.mode.1920x1080@60
kscreen-doctor output.HDMI-A-1.scale.1.2

#echo "xrandr --output ${port} --primary --mode 1920x1080 --rate ${rate} --pos 0x0 --rotate normal" >> $LOG
#if xrandr --output ${port} --primary --mode 1920x1080 --rate ${rate} --pos 0x0 --rotate normal --dryrun; then
#	xrandr --verbose --output ${port} --primary --mode 1920x1080 --rate ${rate} --pos 0x0 --rotate normal &>> $LOG
#fi

#res=`grep -c 1920x1080 /usr/share/dispsetup.sh`
#[ $res -eq 0 ] && sudo arandr &
