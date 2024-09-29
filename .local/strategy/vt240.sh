# source from menu
oneshot() {
	pick "VT240${OFF} (c) 01/19${ON}84 DIGITAL EQUIPMENT CORP."
	frame "Configured as a 9600 baud video terminal and can" 2
	frame "telnet into a remote host via your Internet." 2
	frame "No modem nor land line required." 2
	if anykey ; then
		qstart -L mame "$RA/roms/MAME/vt240/vt240.cmd" &
		sleep 18
		TTY=`ps -hq $$ -o tty`
		DEV=$( ls -lh /dev/pts/ | grep `whoami` | grep -ve .*${TTY#*/}$ )
		PTS=${DEV##*' '}
		socat /dev/pts/$PTS exec:"printf \\\"\\r\\n\\nVT240 using /dev/pts/$PTS\\r\\n\\n\\\""
		sleep 1
		socat /dev/pts/$PTS exec:"telnet play.ddgame.us"
		killall -TERM retroarch
		gameover
	fi
}
