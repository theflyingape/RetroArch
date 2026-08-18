#!/bin/bash
#
# --=:)) HISTORY ((:=--
# My journey started on a Commodore VIC 20 in February 1982
# then came emulators: first on Amiga 1992, then DOS/Win 1997 and Linux 1999
# modded a Gauntlet II cab using my C using SDL frontend: Time2Play kiosk 2006
# replaced with my C++ using ClanLib frontend: My Arcade on CD-ROM 2008
# perfected a number of VIC 20 homebrew games: 2008-2014
# 
# console Playlists menu authored by Robert Hurst: 2022-2026
# these console scripts are for running EmulationStation kiosks
# to launch RetroArch content
#  - uses mainstream Linux distro tweaked for work & play
#  - runs ideally on Raspberry Pi 500+ for its keyboard & performance
#  - with Sony PS5 DualSense controllers for versatility & built-in features
#  - and the X-Arcade Tankstick Max integration is coming soon
#
shopt -s expand_aliases extglob
alias out='echo -e'
sudo lastlog2 --clear --user $USER

DOC="$HOME/Bookshelf/"
RA=/retroarch
RT=/run/user/$UID

ARCADES=(
	"AMC Bowl ${OFF}(Warwick, 19${ON}79${OFF})"
	"Dream Machine ${OFF}(Lincoln Mall, 19${ON}79${OFF})"
	"Aladdin's Castle ${OFF}(Midland Mall, 19${ON}80${OFF})"
	"Star Castle ${OFF}(Apple Valley, 19${ON}80${OFF})"
	"Saturn's Rings ${OFF}(Downtown, 19${ON}81${OFF})"
	"Excellent Pizza ${OFF}(Cranston, 19${ON}82${OFF})"
	"DG's Arcade ${OFF}(Airport Road, 19${ON}83${OFF})"
	"Cranston Bowl ${OFF}(Elmwood, 19${ON}84${OFF})"
)
BG=( yellow black blue black magenta red )
FG=( black green white white white white )
SC='\e[s'
RC='\e[u'
OFF='\e[m'
ON='\e[0;1m'
DIM='\e[0;2m'
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
MAGENTA='\e[35m'
CYAN='\e[36m'
WHITE='\e[37m'
RVS='\e[7m'
KEY='\e[0;47;30;1m'
DOT='\x0e~\x0f'
DOWN='\x0e.\x0f'
LEFT='\x0e,\x0f'
RIGHT='\x0e+\x0f'
UP='\x0e-\x0f'
CROSS='\x0en\x0f'
HBAR='\x0eq\x0f'
VBAR='\x0ex\x0f'
FOCUS=$( grep 'input_game_focus_toggle = ' $RT/retroarch.cfg | awk -F= '{ print $2 }' | tr -d ' "_' )
FOCUS="${KEY} ${FOCUS} ${OFF}"

# rebuild login banner
BANNER=$( out '\e[0;2mFree entertainment brought to you by \e[0;33mThe Flying Ape\e[2m™\e[m' )
OS=$( grep PRETTY /etc/os-release | awk -F= '{print $2}' | tr -d '"' )
linux_logo -L raspi -o6 -s -F "#E\n${OS} #V\n#N #M #X #T Processor#S, #R RAM" -t "${BANNER}" > $RT/issue
sudo mv $RT/issue /etc/issue

# let's buffer next splash screen to keep it fresh
if ! pidof -q lightdm ; then
	chvt 5
	if ! pidof -q fbi ; then
		SPLASH=$( ls -t $HOME/Pictures/Splash/* | tail -1 )
		touch "${SPLASH}"
		sudo openvt -f -c 5 -- fbi --noverbose -a "${SPLASH}" &> /dev/null &
		CLICK="Startup/$(( RANDOM % 5 )).wav"
		PHRASE=
	else
		PHRASE=$( shuf -n1 $RA/scripts/phrases.txt )
	fi
	sleep 2
fi

which retroarch 2> /dev/null || export PATH=$RA/bin:$PATH

trap "chvt 5; sleep 1.5; exit" 1 3 15
#un-comment to mount an SD CARD imaged from the SSD
#grep -qc /media/pi/bootfs /proc/mounts || sudo mount /dev/mmcblk0p1 -m /media/pi/bootfs
#grep -qc /media/pi/rootfs /proc/mounts || sudo mount /dev/mmcblk0p2 -m /media/pi/rootfs

[ -f $RA/assets/sounds/BGM.wav ] && rm $RA/assets/sounds/BGM.wav
rm -f $RT/packages 2> /dev/null
YT="$HOME/Videos"

# render favorite games idle playlist
IDLE=53
EXTRACT="$RT/favorites.cmd"
rm -f "$EXTRACT"; touch "$EXTRACT"
n=$(( 0 ))
core=( bluemsx snes fbneo freeintv mame2003_plus mesen prosystem stella vecx vice_x64sc vice_xplus4 )
for lpl in 'ColecoVision' 'Super Nintendo' 'FBNeo' 'Intellivision' 'MAME' 'NES' \
	'Atari 7800' 'Atari 2600' 'Vectrex' 'C64' 'C16'; do
	while read content ; do
		lib="${core[$n]}"
		if [ "$lib" = "snes" ]; then
			[[ "$MODEL" =~ "Pi4" ]] && lib="snes9x" || lib="bsnes-jg"
		fi
		[[ "${content}" =~ "/MAME/" ]] && lib=mame
		echo "-L ${lib} ${content}" >> "$EXTRACT"
	done < <( grep '"path":' "$RA/playlists/builtin/content_favorites.lpl" | grep "/$lpl" | awk -F'"path": ' '{print $2}' | sed 's/.$//' )
	n=$(( n + 1 ))
done

about() {
	frame "${ON}${RED}powered${OFF} by ${ON}${CYAN}Emulation${BLUE}Station ${GREEN}kiosk${OFF}"
	frame "${DIM}${DOT}${OFF} Press \e[47m${RED}F4${OFF} to QUIT kiosk and return to these playlists"
	frame "${DIM}${DOT}${OFF} Book icon - see Game Options to view its manual"
}

dualsense() {
	PS5=( `dualsensectl -l | tail +2 | awk '{ print $1 }'` )
	# reset player controller(s) for menu
	if [ ${#PS5[@]} -gt 0 ]; then
		RGB=( "8 48 96" "96 48 8" "48 96 8" "8 96 48" "96 8 48" "48 8 96" )
		for i in `seq ${#PS5[@]}`; do
			declare -i j=i-1
			dualsensectl -d ${PS5[$j]} lightbar ${RGB[$j]} 80
			dualsensectl -d ${PS5[$j]} microphone-led off
			dualsensectl -d ${PS5[$j]} trigger both off
		done
	fi
}

pi500() {
	if [ "$MODEL" = "Pi500" ]; then
		case "$1" in
		attract)
		(
			effects=(6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 30 43 44)
			rpi-keyboard-config brightness $(( 64 * (RANDOM % 3) + 127 )) &> /dev/null
			rpi-keyboard-config effect "${effects[$(( RANDOM % ${#effects[@]} ))]}" &> /dev/null
		) &
			;;
		clear)
			$RA/scripts/pi500+.py clear
			;;
		comp)
			$RA/scripts/pi500+.py reset comp $2 $3
			;;
		game)
			$RA/scripts/pi500+.py clear game $2 $3
			;;
		mame)
			$RA/scripts/pi500+.py clear mame $2 $3
			;;
		*)
			$RA/scripts/pi500+.py reset
			;;
		esac
	fi
}

# cook input events
input() {
	let timer=$1+6
	main="$2"
	mt

	events=
	for event in /dev/input/by-id/*-event-@(joystick|kbd|mouse) ; do
		events="$events `realpath $event`"
	done
	IFS=$'\n' events=(`sort -V <<<"${events[*]}"`)
	unset IFS
	for event in /dev/input/event* ; do
		[[ " ${events[*]} " =~ " ${event} " ]] && continue
		udevadm info $event | grep -iq ID_INPUT_JOYSTICK=1 && events+=("$event")
		udevadm info $event | grep -iq ID_INPUT_KEYBOARD=1 && events+=("$event")
		#udevadm info $event | grep .*_MODEL= | grep -iq keyb && events+=("$event")
		udevadm info $event | grep -iq ID_INPUT_MOUSE=1 && events+=("$event")
	done

	got=
	status=1
	while read ev sym sel cmd; do
		# allow only key down + repeat events thru ...
		[ $ev = "#" ] || continue
		let sel=$sel+0
		[ $sel -eq 1 -o $sel -eq -1 ] || continue
		#out -n "\e[${WIDTH}C\e[21D ${KEY}$ev:${RED}$sym${OFF}:$sel ${RC}" ; sleep 0.25
		# ok, now start cooking ...
		[[ $sym =~ ^BTN_[A|B|X|Y]$ || $sym =~ ^BTN_LEFT ]] && sym="BTN_GAMEPAD"
		[[ $sym =~ ^BTN_MODE ]] && sym="KEY_TAB"
		[[ $sym =~ ^BTN_RIGHT ]] && sym="KEY_ESC"
		got="${sym:4}"
		[ -n "$got" ] || continue
		[[ $got =~ .*SHIFT$ ]] && continue
		if [[ $got =~ HAT0X ]]; then
			[ $sel -eq 1 ] && got="RIGHT" || got="LEFT"
		elif [[ $got =~ HAT0Y ]]; then 
			[ $sel -eq 1 ] && got="DOWN" || got="UP"
		elif [ "$got" = "WHEEL" ]; then
			[ $sel -eq 1 ] && got="UP" || got="DOWN"
		elif [[ $sym =~ ABS || $sym =~ REL ]]; then
			got=
			continue
		fi
		if [ $got = "ESC" -o $got = "F12" -o $got = "TL" -o $got = "WEST" ]; then
			out -n "${OFF}"
			let status=${main}-1
			break
		fi
		if [ $got = "COMPOSE" ]; then
			sed -i 's/input_player1_select = ".*"/input_player1_select = "'compose'"/' $RT/retroarch.cfg
			info="» ${DIM}Player 1 SELECT key is now COMPOSE${OFF} «"
			[ $main -eq 1 ] \
			 	&& frame "${RC}${DIM}${CHOICE[${!sub}]} ${OFF}${RIGHT}${ON} ${MENU[${!sub}]} ${OFF}$info" 1 \
				|| frame "${RC} ${OFF}$info" 1
			continue
		fi
		if [ $got = "HOMEPAGE" ]; then
			sed -i 's/input_game_focus_toggle = ".*"/input_game_focus_toggle = "'homepage'"/' $RT/retroarch.cfg
			FOCUS="${KEY} HOMEPAGE ${OFF}"
			info="» ${DIM}FOCUS key is now HOMEPAGE${OFF} «"
			[ $main -eq 1 ] \
			 	&& frame "${RC}${DIM}${CHOICE[${!sub}]} ${OFF}${RIGHT}${ON} ${MENU[${!sub}]} ${OFF}$info" 1 \
				|| frame "${RC} ${OFF}$info" 1
			continue
		fi
		[ $got = "NEXTSONG" ] && break
		[ $got = "LEFTALT" ] && got="LALT"
		[ $got = "LEFTCTRL" ] && got="LCTRL"
		[ $got = "LEFTMETA" ] && got="Pi"
		[ $got = "RIGHTALT" ] && got="RALT"
		[ $got = "RIGHTCTRL" ] && got="RCTRL"
		[ $got = "SYSRQ" ] && got="PrtScn"
		[[ ${#got} -eq 1 && $got =~ ^[A-Z]$ ]] && got=`echo ${got:(-1)} | tr [:upper:] [:lower:]`
		if [[ $got =~ .*SHIFT[+]KEY_? ]]; then
			key=${got:(-1)}
			[ $key = "1" ] && key="!"
			[ $key = "2" ] && key="@"
			[ $key = "3" ] && key="#"
			[ $key = "4" ] && key="\$"
			got=$key
		fi
		if [ $main ]; then
			case $got in
			DPAD_DOWN|SELECT|TR|DOWN)
				let ${sub}=${!sub}+1
				[ ${!sub} -ge ${#CHOICE[@]} ] && let ${sub}=1
				info=
				;;
			DPAD_UP|TL|UP|WEST)
				[ ${!sub} -gt 1 ] || let ${sub}=${#CHOICE[@]}
				let ${sub}=${!sub}-1
				info=
				;;
			DPAD_LEFT|LEFT|VOLUMEDOWN)
				volume "$MASTER"
				volume "6%-"
				MASTER="$VOLUME"
				CLICK="Click/0$(( RANDOM % 10 ))2.mp3"
				click
				echo "MASTER=\"$MASTER\"" > $RA/scripts/MASTER
				info="««${DOT}${DIM}${MASTER}${OFF}${DOT}»»"
				;;
			DPAD_RIGHT|RIGHT|VOLUMEUP)
				volume "$MASTER"
				volume "6%+"
				MASTER="$VOLUME"
				CLICK="Click/0$(( RANDOM % 10 ))2.mp3"
				click
				echo "MASTER=\"$MASTER\"" > $RA/scripts/MASTER
				info="««${DOT}${DIM}${MASTER}${OFF}${DOT}»»"
				;;
			"!")
				[ "$FOLDER" = "main" ] && let ${sub}=9
				info=
				;;
			"@")
				[ "$FOLDER" = "main" ] && let ${sub}=10
				info=
				;;
			"#"|HOME)
				[ "$FOLDER" = "main" ] && let ${sub}=20
				info=
				;;
			"\$")
				[ "$FOLDER" = "main" ] && let ${sub}=1
				info=
				;;
			*)
				status=
				;;
			esac
			if [ $status ]; then
				[ $main -eq 1 ] \
				 	&& frame "${RC}${DIM}${CHOICE[${!sub}]} ${OFF}${RIGHT}${ON} ${MENU[${!sub}]} ${OFF}$info" 1 \
					|| frame "${RC} ${OFF}$info" 1
				continue
			fi
		fi
		status=0
		break
	done < <( timeout -s SIGALRM $timer thd --dump --normalize ${events[*]} 2> /dev/null )
	mt
	return $status
}

# search for PDF manuals on a bookshelf
bookshelf() {
	mt ; stty echo
	frame "" 2
	SHELF=( `ls --file-type ${DOC} | grep '^[0-Z].*/'` )
	let i=0
	for shelf in ${SHELF[@]}; do
		count=`ls ${DOC}${shelf}*.pdf | wc -l`
		let i=i^1
		[ $i -eq 0 ] && lm="\e[51C" || lm=
		frame "${lm}${PAD}${DIM}${DOT}${OFF} ${ON}${shelf%/*}${OFF}\e[$(( 24 - ${#shelf} - ${#PAD} ))C${RIGHT} ${count}${SC}" $i
	done
	frame "" 2
	frame "${ON}Shelf ${OFF}[Favorites]? ${SC}" 1
	read -t 35 shelf

	shelf=`echo $shelf | tr -dc '[:alnum:][:space:]' | tr -s ' '`
	[ -z "$shelf" ] && shelf="Favorites"
	SHELF=`ls --file-type ${DOC} | grep '.*/' | grep -i ^$shelf | head -1`
	[ -z "$SHELF" ] && return

	VOLS=( `ls ${DOC}${SHELF}*.pdf | awk '{print $1}' | uniq` )
	for now in once ; do
	mt; stty echo
	frame
	frame "\e[A${ON}Search ${DIM}${SHELF%/*}${OFF} shelf: ${SC}" 1
	read -t 35 PDF
	PDF=`echo $PDF | tr -dc '[:alnum:][:space:]' | tr -s ' '`
	if [ -z "${PDF}" ]; then
	       PDF=`basename ${VOLS[$((RANDOM%${#VOLS[@]}))]}`
	       PDF="`echo ${PDF:0:4} | tr [:upper:] [:lower:] | tr -s ' '`"
	       frame "${RC}${PDF}"
	fi
	crt

	i=0
	while read doc ; do
		PDF[$i]="$doc"
		let i=$i+1
		frame "${DOT}${DIM}$i${OFF}  `basename \"$doc\"`"
		[ $i -ge 9 ] && break
	done < <( ls ${DOC}${SHELF} | grep '.pdf' | grep -i "${PDF}" 2> /dev/null )
	if [ $i -eq 0 ]; then
		out -n "\e[A"
		break
	fi
	frame 
	frame "${ON}View ${OFF}which (1-$i): ${SC}" 1
	mt
	read -n 1 -t 15 choice || out
	case $choice in
	[1-9])
		let i=$choice-1
		if [ -n "${PDF[$i]}" ]; then
			frame "${RC}${choice} - ${PDF[$i]}"
			view "${DOC}${SHELF}${PDF[$i]}"
		fi
		;;
	esac
	done
}

frame() {
	declare -i eol=$(( $2 - 1 ))
	[ $eol -eq 1 ] && cll=1 || cll=
	out -n "${OFF}\e[${cll}K\r${LPAD}\e[${WIDTH}C${RPAD}\r\e[${#PAD}C$1"
	[ $eol -eq 0 ] && out -n "${RC}" || out ""
}

gameover() {
	reset
	chvt 5
	sudo systemctl restart getty@tty1 &
	exit
}

hype() {
	HYPE="`find $YT/Hype/ -mmin -50`"
	if [ -z "$HYPE" ]; then
		HYPE="Hype/`ls -t $YT/Hype | tail -1`"
		touch "$YT/$HYPE"
		frame "${RC}enjoy video $HYPE"
		volume "12%+"
		video "$YT/$HYPE"
		upgradeable &
		return 0
	fi
	return 1
}

upgradeable() {
	sudo apt update > $RT/packages.tmp 2> /dev/null
	mv $RT/packages.tmp $RT/packages
}

# wait for any button/key down event
anykey() {
	declare -i sec=0
	PDF="${DOC}/Favorites/$1"
	[ -f "${PDF}" ] && sec=$2 || sec=$1
	[ $sec -le 0 ] && sec=36
	[ -f "${PDF}" ] && frame "" 2
	frame "${SC}\e[74C${KEY} ${LEFT} ${OFF} ${KEY} ${RIGHT} ${OFF} test volume ${DOWN}${UP} control now" 1
	[ -f "${PDF}" ] && frame "Press ${KEY}${RED} Pi ${OFF} to open its Bookshelf manual." 2 || frame "" 2
	frame
	frame
	out -n "\r\e[2A"
	frame "Press any button/key ${any}: ${SC}\r\e[83C${KEY}ESC${OFF} or Left ${KEY}Shoulder${OFF} to go back" 1
	any="to continue"
	info=
	input $sec 2
	status=$?
	killall -qw mplayer &> /dev/null &
	#while ps -C mplayer &> /dev/null ; do kill -QUIT `ps -C mplayer -o pid=` &> /dev/null ; sleep 0.1 ; done
	if [ $got = "Pi" ]; then
		out
		if [ -f "$PDF" ]; then
			frame "${PAD}${KEY}${RED} Pi ${OFF} ${RIGHT}${ON} `basename "$PDF"`" 2
			view "$PDF"
		fi
	fi
	out -n "\r\e[A\e[J"
	frame
	[ $status -eq 0 ] && click wait
	return $status
}

comp() {
	model=$1
	out -n "${RC}boot ${ON}$2${OFF} on $model\n\e[J"
	lines=
	frame "\e[74C${FOCUS} toggles keyboard focus"
	frame "\e[74C${KEY} K ${OFF} keep this game for later"
	frame "\e[74C${KEY} L ${OFF} load game kept from slot#"
	frame "\e[74C${KEY} N ${OFF}ext or ${KEY} P ${OFF}revious slot#"
	frame "\e[74C${KEY} Delete ${OFF} or ${KEY} Select ${OFF}+${KEY} Start ${OFF} to quit"
	lines=5
	if [ "$model" = "VIC" -o "$model" = "C16" -o "$model" = "C64" -o "$model" = "AMIGA" ]; then
		frame "\e[74C${KEY}${RED} Pi ${OFF} logo key to toggle ${model} ${ON}STATUS${OFF}"
		let lines=$lines+1
	fi
	if [ "$model" = "VIC" -o "$model" = "C16" -o "$model" = "C64" ]; then
		frame "\e[78C Left ${KEY} Ctrl ${OFF} is ${KEY}${BLUE}C${RED}=${OFF} logo key"
		let lines=$lines+1
	fi
	if [ "$model" = "C64" ]; then
	       	frame "\e[77C Right ${KEY} Ctrl ${OFF} swaps Joysticks 1/2"
		let lines=$lines+1
	fi
	out "\e[${lines}A"
}

compete() {
	out -n "${RC}compete ${OFF}or${DIM} play ${ON}$1${OFF}\n\e[J"
	frame "\e[74C${KEY} Shift ${OFF} or ${KEY} Select ${OFF} to deposit coin"
	frame "\e[74C${KEY} Enter ${OFF} or ${KEY} Start ${OFF} for Player start"
	frame "\e[73C${KEY} Delete ${OFF} or ${KEY} Select ${OFF}+${KEY} Start ${OFF} to quit"
	frame "\e[70C${KEY} Backspace ${OFF} ${DIM}${RIGHT}${ON}${RIGHT}${OFF} to review ${DIM}Achievements"
	out "\e[4A"
	any="for Cheevos ${DIM}challenge${OFF} or ${KEY}${WHITE}N${OFF}o for arcade"
}

lrtl() {
	log="$RA/logs/$roms/$content.lrtl"
	if [ -f "$log" ]; then
		last=`grep played "$log" | awk -F': ' '{print $2}' | awk '{print $1}' | tr -d '"'`
		time=`grep time "$log" | awk -F': ' '{print $2}' | awk -F, '{print $1}' | tr -d '"'`
		frame "$content last played ${ON}`date -d $last +'%a %b %d %Y'`${OFF} for a total of ${DIM}$time"
	fi
	roms=
	content=
}

pick() {
	play="play"
	[ -n "$2" ] && play="$2"
	out -n "${RC}$play ${ON}$1${OFF}\n\e[J"
	lines=3
	[ -z "$2" ] \
		&& frame "\e[74C${KEY} Shift ${OFF} or ${KEY} Select ${OFF} to deposit coin" \
		|| frame "\e[74C${KEY} Shift ${OFF} or ${KEY} Select ${OFF} any game options"
	if [ "$2" = "VCS" ]; then
		frame "\e[77C${KEY} L1 ${OFF} ${LEFT}${RIGHT} ${KEY} R1 ${OFF} Difficulty ${ON}A${OFF} P1/P2"
		frame "\e[77C${KEY} L2 ${OFF} ${LEFT}${RIGHT} ${KEY} R2 ${OFF} Difficulty ${ON}B${OFF} P1/P2"
		lines=5
	fi
	frame "\e[74C${KEY} Enter ${OFF} or ${KEY} Start ${OFF} for Player start"
	frame "\e[73C${KEY} Delete ${OFF} or ${KEY} Select ${OFF}+${KEY} Start ${OFF} to quit"
	out "\e[${lines}A"
}

pip() {
	volume "9%+"
	xy=640
	[ -n "$2" ] && xy=$2
	[ -f "$1" ] && mplayer -nofs -nogui -noconsolecontrols -vo fbdev2 -vf scale,crop=${CROP} \
		-zoom -xy $xy -geometry 96%:0% -quiet "$1" &> /dev/null &
}

src() {
	rom=$( basename "${1%.*}" )
	script="$RA/scripts/${FOLDER}/${rom}.sh"
	[ -f "$script" ] || return
	touch "$script"
	source "$script"
	pip "$YT/Preview/${rom}.mp4" $xy
	oneshot
}

crt() {
	setleds -L < /dev/tty1 &> /dev/null
	setleds -L -caps -num -scroll < /dev/tty1
	stty -echo -ixon -ixoff

	frame "" 2
	[ ${#GUN[@]} -eq 0 ] && GUN=( `shuf -e 0 1 2 3 4 5` )
	declare -i i=${GUN[(-1)]}
	unset 'GUN[(-1)]'
	out -n "${OFF}\e[?17;137c\r\e[50C"
	setterm --background ${BG[$i]} --foreground ${FG[$i]} --hbcolor bright yellow --store --clear=rest
}

volume() {
	wpctl set-volume @DEFAULT_AUDIO_SINK@ "$1" 2> /dev/null
	VOLUME=$( wpctl get-volume @DEFAULT_AUDIO_SINK@ 2> /dev/null | grep ^Volume | awk '{ print $2 }' )
	declare -i v=$( echo "${VOLUME} * 100 / 1" | bc )
	VOLUME="${v}%"
	v=$(( $v * 255 / 100 ))
	for i in `seq ${#PS5[@]}`; do
		declare -i j=i-1
		dualsensectl -d ${PS5[$j]} speaker both
		dualsensectl -d ${PS5[$j]} volume $v
	done
}

floppy() {
	setterm --background green --foreground black --hbcolor bright yellow --store --clear=rest
	frame 
	frame "${FOCUS} ${ON}key${OFF}: keyboard's ${ON}GAME FOCUS${OFF} toggle between Computer and Kiosk control"
	frame "${ON}Save Game slot${OFF}: ${KEY} K ${OFF}eep ${KEY} L ${OFF}oad ${KEY} N ${OFF}ext ${KEY} P ${OFF}revious"
	frame "${ON}Floppy control${OFF}: ${KEY} \ ${OFF} ${RED}EJECT${OFF}/${BLUE}INSERT${OFF} selected disk in tray"
	frame "${ON}Swap diskettes${OFF}: ${KEY} [ ${OFF} previous or ${KEY} ] ${OFF} next in tray"
	frame "${DIM}Commodore${OFF} note: ${KEY}${RED} Pi ${OFF} logo key toggles a ${ON}STATUS BAR${OFF} and"
	frame "Left ${KEY} Ctrl ${OFF} for ${KEY}${BLUE}C${RED}=${OFF} logo key with Right ${KEY} Ctrl ${OFF} for Joystick 1+2 swapping"
	anykey 83
}

laserdiscs() {
	DISCS=( "" 1 2 3 4 5 6 )
	LABEL=( "" "Astron Belt" "Cliff Hanger" "Dragon's Lair" "Dragon's Lair II: Time Warp" "Space Ace" "Super Don Quixote" )
	ROM=( "" "astron" "cliff" "dle21" "lair2" "sae" "sdq" )
	INFO=( "" \
		"You fly through the universe battling alien ships to make your way to fight the main\n${LPAD}Alien Battle Cruiser. Along the way, you fly across alien planets, through tunnels,\t\t\t   ${RPAD}\n${LPAD}through trenches, and get involved in a few astro-dogfights with enemy space fighters.\t\t\t   ${RPAD}" \
		"Cliff is on a mission to save Clarissa from being forced to marry the evil Count Draco.\n${LPAD}The game consists of animated scenes, during which the player has to press direction buttons\t\t   ${RPAD}\n${LPAD}or the sword button in the right moment to trigger the next segment of the movie.\t\t\t\t   ${RPAD}\n${LPAD}The anime video used in the game are scenes from the Lupin III anime movies, mainly scenes\t\t\t   ${RPAD}\n${LPAD}from The Castle of Cagliostro and the Mystery of Mamo animated movies.\t\t\t\t\t   ${RPAD}" \
		"Originally released in the arcades as a laserdisc game, Dragon's Lair is an interactive\n${LPAD}cartoon movie. Players control Dirk the Daring as he struggles his way through a dungeon\t\t\t   ${RPAD}\n${LPAD}to fight Singe, the Dragon, and rescue the beautiful Princess Daphne.\t\t\t\t\t   ${RPAD}\n${LPAD}The game consists of animated scenes, during which the player has to press direction buttons\t\t   ${RPAD}\n${LPAD}or the sword button in the right moment to trigger the next segment of the movie.\t\t\t\t   ${RPAD}" \
		"Princess Daphne has been spirited away to a wrinkle in time by the Evil Wizard Mordroc\n${LPAD}who plans to force her into marriage. Only you, Dirk the Daring, can save her.\t\t\t\t   ${RPAD}\n${LPAD}Transported by a bumbling old time machine, you begin the rescue mission.\t\t\t\t\t   ${RPAD}\n${LPAD}But you must hurry, for once the Casket of Doom has opened, Mordroc will place the\t\t\t\t   ${RPAD}\n${LPAD}Death Ring upon Daphne's finger in marriage and she will be lost forever in the\t\t\t\t   ${RPAD}\n${LPAD}Time Warp!\e[97C   ${RPAD}" \
		"Space Ace was unveiled in October 19${ON}83${OFF}, just four months after the Dragon's Lair game,\n${LPAD}then released in Spring 19${ON}84${OFF}, and like its predecessor featured film-quality\t\t\t\t   ${RPAD}\n${LPAD}animation played back from a laserdisc.\e[68C   ${RPAD}" \
		"The idea for this game comes from the stories about Don Quixote, the legendary Spanish knight.\n${LPAD}In this game, the character looks very young and does not have a mustache. Also, he has a\t\t\t   ${RPAD}\n${LPAD}sword for a weapon and his faithful sidekick Sancho Panza follows him around although\t\t\t   ${RPAD}\n${LPAD}he does nothing (like ${ON}Jon${OFF}) to assist the hero (${ON}Randy${OFF}). An assortment of mythical creatures\t\t\t   ${RPAD}\n${LPAD}including demons, dragons, skeletons and so on are encountered throughout the game.\t\t\t   ${RPAD}\n${LPAD}The game ends when Don Quixote kills the evil witch and rescues Isabella.\t\t\t\t\t   ${RPAD}")
	i=0
	disc=

	setterm --background black --foreground cyan --hbcolor bright yellow --store --clear=rest
	frame 
	frame "${DOT}${DIM}1${OFF}  Astron Belt"
	frame "${DOT}${DIM}2${OFF}  Cliff Hanger"
	frame "${DOT}${DIM}3${OFF}  Dragon's Lair"
	frame "${DOT}${DIM}4${OFF}  Dragon's Lair II: Time Warp"
	frame "${DOT}${DIM}5${OFF}  Space Ace"
	frame "${DOT}${DIM}6${OFF}  Super Don Quixote"
	frame
	frame
	out -n "\e[A\e[5C${ON}Disc ${OFF}${DOWN}${UP}: ${SC}${DIM}"

	while input 6 ; do
		case $got in
		DPAD_DOWN|SELECT|DOWN)
			let i=$i+1
			[ $i -ge ${#DISCS[@]} ] && let i=0
			;;
		GAMEPAD|START|ENTER)
			break
			;;
		DPAD_UP|UP)
			[ $i -gt 0 ] || let i=${#DISCS[@]}
			let i=$i-1
			;;
		[1-6])
			let i=${sym:(-1)}
			;;
		*)
			let i=0
			;;
		esac
		disc="${ROM[$i]}"
		[ $i -gt 0 ] && out -n "${RC}${i} ${OFF}${RIGHT}${ON} ${LABEL[$i]}"
		frame "${RC}" 1
	done
	[ "$got" == "ESC" ] && disc=

	out 
	if [ -n "${disc}" ]; then 
		pip "$YT/Preview/${disc}.mp4" 800
		setterm --background cyan --foreground black --hbcolor bright white --store --clear=rest
		frame 
		frame "${INFO[$i]}"
		frame 
		frame "${KEY} 5 ${OFF} / ${KEY} 6 ${OFF} insert enough COIN(s) to START"
		frame "${KEY} 1 ${OFF} / ${KEY} 2 ${OFF} for player(s) START respectively"
		frame "${KEY} ESC ${OFF} to QUIT the game"
		anykey 48 && $RA/roms/Daphne/boot.sh "${disc}.daphne" &> /dev/null
	fi
	n=16
}

main() {
	crt
	frame "\e[A\e[50C ${ON}\x0elqqqqqqqqqqqqqqqqqqqqqqu${KEY}\x0eah\x0f \e[1mMy \e[0;47m${RED}A${YELLOW}r${GREEN}c${CYAN}a${BLUE}d${MAGENTA}e ${KEY}\x0eha${ON}tqqqqqqqqqqqqqqqqqqqqqq "
	frame "                                                   ${ON}${VBAR}${OFF}  ${DOT}${DIM}a${OFF}  Asteroids        ${DOT}${DIM}n${OFF}  Donkey Kong     ${DOT}${DIM}A${OFF}  Astro Blaster"
	frame " »${DIM}0${OFF}  COIN-OP       137   •${DIM}5${OFF}  Party Games       16  ${ON}${VBAR}${OFF}  ${DOT}${DIM}b${OFF}  Bubble Bobble    ${DOT}${DIM}o${OFF}  Jungle King     ${DOT}${DIM}B${OFF}  Black Tiger"
	frame " »${DIM}1${OFF}  CART          390   •${DIM}6${OFF}  Pinball Sims       6  ${ON}${VBAR}${OFF}  ${DOT}${DIM}c${OFF}  Carnival         ${DOT}${DIM}p${OFF}  Moon Patrol     ${DOT}${DIM}C${OFF}  Cyberball"
	frame " »${DIM}2${OFF}  FLOPPY        114   •${DIM}7${OFF}  RTS / Turn-based   9  ${ON}${VBAR}${OFF}  ${DOT}${DIM}d${OFF}  Mr. Do!          ${DOT}${DIM}q${OFF}  Ripoff          ${DOT}${DIM}D${OFF}  Defender"
	frame " »${DIM}3${OFF}  CD-ROM        103   •${DIM}8${OFF}  Analog Controls   30  ${ON}${VBAR}${OFF}  ${DOT}${DIM}e${OFF}  Elevator Action  ${DOT}${DIM}r${OFF}  Robotron: 2084  ${DOT}${DIM}F${OFF}  Phoenix"
	frame " »${DIM}4${OFF}  HANDHELD       95   •${DIM}9${OFF}  Homebrews          5  ${ON}${VBAR}${OFF}  ${DOT}${DIM}f${OFF}  Frogger          ${DOT}${DIM}s${OFF}  Spiders         ${DOT}${DIM}G${OFF}  G.O.R.F."
	frame " »${DIM}N${OFF}  Nostalgia     698   •${DIM}L${OFF}  Laserdiscs         6  ${ON}${VBAR}${OFF}  ${DOT}${DIM}g${OFF}  Galaga           ${DOT}${DIM}t${OFF}  Time Pilot      ${DOT}${DIM}H${OFF}  Hat Trick"
	frame "${KEY}${BLUE}TAB${OFF}  Archives   12,965   \e[47m${RED}F9${OFF}  Rob's Picks       96  ${ON}${VBAR}${OFF}  ${DOT}${DIM}h${OFF}  Satan's Hollow   ${DOT}${DIM}u${OFF}  Gyruss          ${DOT}${DIM}J${OFF}  Bomb Jack"
	frame "\e[51C${ON}${VBAR}${OFF}  ${DOT}${DIM}i${OFF}  Space Invaders   ${DOT}${DIM}v${OFF}  Vanguard        ${DOT}${DIM}K${OFF}  Karate Champ"
	frame "\x08${ON}\x0eqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqu\x0f${OFF}  ${DOT}${DIM}j${OFF}  Joust            ${DOT}${DIM}w${OFF}  Galaxian        ${DOT}${DIM}Q${OFF}  Q*bert"
	frame " ${DOT}${DIM}U${OFF}  Upgrade Linux       ${DOT}${DIM}Z${OFF}  Toggle boot: ${ON}${STARTUP}${OFF}  ${ON}${VBAR}${OFF}  ${DOT}${DIM}k${OFF}  Kung-Fu Master   ${DOT}${DIM}x${OFF}  Xevious         ${DOT}${DIM}S${OFF}  Space Duel"
	frame " ${DOT}${DIM}!${OFF}  Power off          \e[47m${RED}F10${OFF}  Help document         ${ON}${VBAR}${OFF}  ${DOT}${DIM}l${OFF}  Lady Bug         ${DOT}${DIM}y${OFF}  10-yard Fight   ${DOT}${DIM}T${OFF}  Tapper"
	frame " ${DOT}${DIM}@${OFF}  Reboot             \e[1;37;41mESC${OFF}  Exit to Desktop mode  ${ON}${VBAR}${OFF}  ${DOT}${DIM}m${OFF}  Ms. Pac-Man      ${DOT}${DIM}z${OFF}  Berzerk         ${DOT}${DIM}W${OFF}  Wizard of Wor"
	frame "\e[51C${ON}\x0emqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqu${KEY}\x0eah\x0f $(date +'%a %I:%M%P') \x0eha${OFF}${ON}"
	FOLDER=main
}

party() {
	crt
	frame "" 2
	frame "${DOT}${DIM}b${OFF}  Bowling        (~4P)   ${DOT}${DIM}B${OFF}  Ninja Baseball Batman   (~4P)"
	frame "${DOT}${DIM}g${OFF}  Gauntlet       (~4P)   ${DOT}${DIM}G${OFF}  Gauntlet II             (~4P)"
	frame "${DOT}${DIM}h${OFF}  Hoyle Casino   (~4P)   ${DOT}${DIM}H${OFF}  Gauntlet Legends        (~4P)"
	frame "${DOT}${DIM}j${OFF}  Jumpman        (~4P)   ${DOT}${DIM}L${OFF}  Game of Life            (~6P)"
	frame "${DOT}${DIM}k${OFF}  Mario Kart 64  (~4P)   ${DOT}${DIM}P${OFF}  Mario Party 2           (~4P)"
	frame "${DOT}${DIM}m${OFF}  Monopoly       (~8P)   ${DOT}${DIM}R${OFF}  Rampage                 (~3P)"
	frame "${DOT}${DIM}t${OFF}  Trog           (~4P)   ${DOT}${DIM}S${OFF}  Super Smash Bros        (~4P)"
	frame "${DOT}${DIM}w${OFF}  Wizard         (~6P)   ${DOT}${DIM}T${OFF}  Tecmo Bowl              (~4P)"
	frame
	n=1

	FOLDER=party
	CHOICE=( "" "b" "g" "h" "j" "k" "m" "t" "w" "B" "G" "H" "L" "P" "R" "S" "T" )
	MENU=( "" "Bowling" "Gauntlet" "Hoyle Casino" "Jumpman" "Mario Kart 64" "Monopoly" "Trog" "Wizard" \
		"Ninja Baseball Batman" "Gauntlet II" "Gauntlet Legends" "Game of Life" "Mario Party 2" \
		"Rampage" "Super Smash Bros" "Tecmo Bowl" )

	frame 
	frame "${OFF}\e[$(( $WIDTH - 16 ))C${KEY}\x0eah\x0f `date +'%a %I:%M%P'` \x0eha\x0f${OFF}\e[2A"
	prompt "Party ${ON}${DOWN}${UP}${OFF}: ${DIM}" n choice

	dualsense
	volume "$MASTER"
	[ "$choice" = "attract" ] && choice=${CHOICE[$((RANDOM%${#MENU[@]}+1))]}

	case $choice in
	b)
		src bowling
		;;
	g)
		src gauntlet
		;;
	h)
		src casino
		;;
	j)
		src jumpman
		;;
	k)
		src mario-kart64
		;;
	m)
		src monopoly
		;;
	t)
		src trog
		;;
	w)
		src wizard
		;;
	B)
		src nbbatman
		;;
	G)
		src gaunt2
		;;
	H)
		src glegends
		;;
	L)
		src golife
		;;
	P)
		src mario-party2
		;;
	R)
		src rampage
		;;
	S)
		src gamecube
		;;
	T)
		src tbowl
		;;
	esac

	frame "" 1
	n=11
}

pinball() {
	crt
	frame "" 2
	frame "${DOT}${DIM}a${OFF}  Pinball Action   (~2P)"
	frame "${DOT}${DIM}d${OFF}  Devil's Crush    (~2P)"
	frame "${DOT}${DIM}e${OFF}  Extreme Pinball  (~4P)"
	frame "${DOT}${DIM}f${OFF}  Fantasies        (~8P)"
	frame "${DOT}${DIM}t${OFF}  True Pinball     (~2P)"
	frame "${DOT}${DIM}v${OFF}  Video Pinball    (~2P)"
	frame 
	n=1

	FOLDER=pinball
	CHOICE=( "" "a" "d" "e" "f" "t" "v" )
	MENU=( "" "Pinball Action" "Devil's Crush" "Extreme Pinball" "Pinball Fantasies" "True Pinball" "Video Pinball" )

	frame 
	frame "${OFF}\e[$(( $WIDTH - 16 ))C${KEY}\x0eah\x0f `date +'%a %I:%M%P'` \x0eha\x0f${OFF}\e[2A"
	prompt "Pinball ${ON}${DOWN}${UP}${OFF}: ${DIM}" n choice

	dualsense
	volume "$MASTER"
	[ "$choice" = "attract" ] && choice=${CHOICE[$((RANDOM%${#MENU[@]}+1))]}

	case $choice in
	a)
		src pbaction
		;;
	d)
		src devilscr
		;;
	e)
		src extreme
		;;
	f)
		src pballf
		;;
	t)
		src truepball
		;;
	v)
		src vpinball
		;;
	esac

	frame "" 1
	n=12
}

strategy() {
	crt
	frame "" 2
	frame "${DOT}${DIM}0${OFF}  0 A.D."
	frame "${DOT}${DIM}a${OFF}  Angband             ${DOT}${DIM}E${OFF}  Empire"
	frame "${DOT}${DIM}d${OFF}  Dank Domain         ${DOT}${DIM}R${OFF}  Risk (~6P) or Ultimate (~8P)"
	frame "${DOT}${DIM}s${OFF}  Stratego    (~2P)   ${DOT}${DIM}S${OFF}  Super Trek"
	frame "${DOT}${DIM}w${OFF}  Warcraft            ${DOT}${DIM}W${OFF}  Warcraft II"
	frame 
	n=1

	FOLDER=strategy
	CHOICE=( "" "0" "a" "d" "s" "w" "E" "R" "S" "W" )
	MENU=( "" "0 A.D." "Angband" "Dank Domain" "Stratego" "Warcraft" "Empire" "Risk / Ultimate" "Super Trek" "Warcraft II" )

	frame 
	frame "${OFF}\e[$(( $WIDTH - 16 ))C${KEY}\x0eah\x0f `date +'%a %I:%M%P'` \x0eha\x0f${OFF}\e[2A"
	prompt "Strategy ${ON}${DOWN}${UP}${OFF}: ${DIM}" n choice

	dualsense
	volume "$MASTER"
	[ "$choice" = "attract" ] && choice=${CHOICE[$((RANDOM%${#MENU[@]}+1))]}

	case $choice in
	0)
		src 0ad
		;;
	a)
		src angband
		;;
	d)
		src vt240
		;;
	s)
		src stratego
		;;
	w)
		src warcraft
		;;
	E)
		src empire
		;;
	R)
		src risk
		;;
	S)
		src supertrek
		;;
	W)
		src warcraft2
		;;
	esac

	frame "" 1
	n=13
}

analog() {
	crt
	frame "" 2
	frame "${ON}    Advanced              Dial/Spinner               Mouse/Trackball                     Lightgun"
	frame "${DOT}${DIM}1${OFF}  Lunar Lander      ${DOT}${DIM}a${OFF}  Kick         (~2P)     ${DOT}${DIM}A${OFF}  Centipede             (~2P)     ${DOT}${DIM}M${OFF}  Crossbow         (1P)"
	frame "${DOT}${DIM}2${OFF}  NBA 2K2           ${DOT}${DIM}b${OFF}  Megaball      (1P)     ${DOT}${DIM}B${OFF}  City Defense          (~2P)     ${DOT}${DIM}N${OFF}  Duck Hunt       (~2P)"
	frame "${DOT}${DIM}3${OFF}  NFL 2K2           ${DOT}${DIM}c${OFF}  Omega Race   (~2P)     ${DOT}${DIM}C${OFF}  Coors Light Bowling   (~2P)     ${DOT}${DIM}O${OFF}  Operation Wolf   (1P)"
	frame "${DOT}${DIM}4${OFF}  Night Driver      ${DOT}${DIM}d${OFF}  Seawolf       (1P)     ${DOT}${DIM}D${OFF}  Empire Strikes Back   (~2P)     ${DOT}${DIM}U${OFF}  Under Fire      (~2P)"
	frame "${DOT}${DIM}5${OFF}  Pole Position     ${DOT}${DIM}e${OFF}  Seawolf II   (~2P)     ${DOT}${DIM}E${OFF}  Gridiron!             (~2P)     ${DOT}${DIM}X${OFF}  Beast Busters   (~3P)"
	frame "${DOT}${DIM}6${OFF}  Spy Hunter        ${DOT}${DIM}f${OFF}  Tempest      (~2P)     ${DOT}${DIM}F${OFF}  Mini Golf             (~2P)     ${DOT}${DIM}Z${OFF}  Enable Lightgun"
	frame "${DOT}${DIM}7${OFF}  Star Trek                                    ${DOT}${DIM}G${OFF}  Missile Command       (~2P)"
	frame "${DOT}${DIM}8${OFF}  Toobin'                                      ${DOT}${DIM}H${OFF}  Star Wars             (~2P)"
	frame "${DOT}${DIM}9${OFF}  Tron                                         ${DOT}${DIM}I${OFF}  Tail Gunner            (1P)"
	frame "${DOT}${DIM}0${OFF}  3DO Road Rash"
	frame 
	n=1

	FOLDER=analog
	CHOICE=( "" "1" "2" "3" "4" "5" "6" "7" "8" "9" "0" \
			"a" "b" "c" "d" "e" "f" \
			"A" "B" "C" "D" "E" "F" "G" "H" "I" \
			"M" "N" "O" "U" "X" "Z" )
	MENU=( "" "Lunar Lander" "NBA 2K2" "NFL 2K2" "Night Driver" "Pole Position" "Spy Hunter" "Star Trek" "Toobin'" \
			"Tron" "3DO Road Rash" "Kick" "Megaball" "Omega Race" "Seawolf" "Seawolf II" "Tempest" \
			"Centipede" "City Defense" "Coors Light Bowling" "Empire Strikes Back" "Gridiron!" "Mini Golf" \
			"Missile Command" "Star Wars" "Tail Gunner" \
			"Crossbow" "Duck Hunt" "Operation Wolf" "Under Fire" "Beast Busters" "Sinden Lightgun" )

	frame 
	pidof -q mono && message="• ${OFF}${KEY}${RED}Lightgun${OFF}${KEY} •" || message=`date +'%a %I:%M%P'`
	frame "${OFF}\e[$(( $WIDTH - 16 ))C${KEY}\x0eah\x0f ${message} \x0eha\x0f${OFF}\e[2A"
	prompt "Analog ${ON}${DOWN}${UP}${OFF}: ${DIM}" n choice

	dualsense
	volume "$MASTER"
	[ "$choice" = "attract" ] && choice=${CHOICE[$((RANDOM%${#MENU[@]}+1))]}

	case $choice in
	1)
		src llander
		;;
	2)
		src nba2k2
		;;
	3)
		src nfl2k2
		;;
	4)
		src nitedrvr
		;;
	5)
		src polepos
		;;
	6)
		src spyhunt
		;;
	7)
		src startrek
		;;
	8)
		src toobin
		;;
	9)
		src tron
		;;
	0)
		src 3do
		;;
	a)
		src kick
		;;
	b)
		src megaball
		;;
	c)
		src omegrace
		;;
	d)
		src seawolf
		;;
	e)
		src seawolf2
		;;
	f)
		src tempest
		;;
	A)
		src centiped
		;;
	B)
		src citydef
		;;
	C)
		src clbowl
		;;
	D)
		src esb
		;;
	E)
		src gridiron
		;;
	F)
		src minigolf
		;;
	G)
		src missile
		;;
	H)
		src starwars
		;;
	I)
		src tailg
		;;
	M)
		src crossbow
		;;
	N)
		src duckhunt
		;;
	O)
		src opwolf
		;;
	U)
		src undrfireu
		;;
	X)
		src bbustersu
		;;
	Z)
		if ! pidof -q mono ; then
			cd $RA/scripts/Lightgun/Application > /dev/null
			mono-service LightgunMono.exe
			sleep 1.5
			cd - > /dev/null
		fi
		if pidof -q mono ; then
			frame "Calibrate a lightgun? ${SC}" 1
			input 6
			while [ "$got" = "y" ]; do
				cd $RA/scripts/Lightgun/Application > /dev/null
				timeout -s SIGALRM 60 mono LightgunMono.exe sdl 30
				cd - > /dev/null
				frame "Retry lightgun calibration? ${SC}" 1
				input 6
			done
			analog
		else
			out "${RED}failed${OFF}"
			sleep 1
		fi
		;;
	esac
	pkill mono &> /dev/null
	rm -f /tmp/LightgunMono*

	frame "" 1
	n=14
}

homebrew() {
	crt
	frame "" 2
	frame "${DOT}${DIM}1${OFF}  Berzerk MMX        (1P)"
	frame "${DOT}${DIM}2${OFF}  Break-out!        (~2P)"
	frame "${DOT}${DIM}3${OFF}  Omega Fury         (1P)"
	frame "${DOT}${DIM}4${OFF}  Quikman+          (~2P)"
	frame "${DOT}${DIM}5${OFF}  Sprite Invaders   (~2P)"
	frame 
	n=1

	FOLDER=homebrew
	CHOICE=( "" "1" "2" "3" "4" "5" )
	MENU=( "" "Berzerk MMX" "Break-out!" "Omega Fury" "Quikman+" "Sprite Invaders" )

	frame 
	frame "${OFF}\e[$(( $WIDTH - 16 ))C${KEY}\x0eah\x0f `date +'%a %I:%M%P'` \x0eha\x0f${OFF}\e[2A"
	prompt "Homebrew ${ON}${DOWN}${UP}${OFF}: ${DIM}" n choice

	dualsense
	volume "$MASTER"
	[ "$choice" = "attract" ] && choice=${CHOICE[$((RANDOM%${#MENU[@]}+1))]}

	case $choice in
	1)
		src berzerk-mmx
		;;
	2)
		src break-out
		;;
	3)
		src omega-fury
		;;
	4)
		src quikman+
		;;
	5)
		src vic-sss
		;;
	esac

	frame "" 1
	n=15
}

mt() {
	while read -n 255 -t 0.02 mt &> /dev/null ; do
		sleep 0
	done
}

prompt() {
	[ $HDMI -gt 0 ] && sec=$IDLE || sec=-2
	label=$1
	sub=$2
	val=$3
	[ -n "$4" ] && sec=$4
	export ${val}="${CHOICE[${!sub}]}"

	frame "$label${SC}${DIM}${!val} ${OFF}${RIGHT}${ON} ${MENU[${!sub}]}" 1
	click
	if [ -z "${NETWORK}" ]; then
		out -n "\r\e[${NETSTAT}C${OFF}   «${ON}«${KEY}${RED} network ${ON}»${OFF}»"
	else
		out -n "\r\e[${NETSTAT}C${OFF}"
		printf '%20s' "« ${NETWORK%/*} »"
	fi
	out -n "${RC}"
	[ -f $RT/packages ] && packages=`tail -1 $RT/packages | awk '{ print $1 }'`
	[ "$packages" = "All" ] || out -n "\r\e[$(( $WIDTH - 13 ))C ${LEFT} ${KEY}\x0eah\x0f upgrade \x0eha\x0f${OFF} ${DIM}${RIGHT} ${RC}"

	input $sec 1
	[ $status -eq 0 ] || got="attract" && IDLE=53

	case $got in
	GAMEPAD|START|ENTER)
		export ${val}="${CHOICE[${!sub}]}"
		frame "${RC}" 1
		;;
	ESC|TL)
		export ${val}="ESC"
		;;
	F1)
		frame "${RC}${KEY} ${BLUE}C${RED}= ${OFF} VIC-20 owned: 02/19${ON}81${OFF}-11/19${ON}84${OFF}"
		frame
		pip "$YT/Preview/vic20.mp4" 896
		frame "While taking HS Computer Math, I got hooked on BASIC."
		frame "Mom helped me buy VIC-20 for \$300 and the rest is history."
		if floppy "VIC20 - Friendly Guide.pdf" ; then
			reset
			pi500 comp
			qstart -L vice_xvic
			gameover
		fi
		out -n "\e[2A"
		export ${val}=loop
		;;
	F2)
		frame "${RC}${KEY} ${BLUE}C${RED}= ${OFF} 16 owned: 12/19${ON}84${OFF}-05/19${ON}85${OFF}"
		frame
		pip "$YT/Preview/c16.mp4" 896
		frame "I was completing NEIT that month and decided it was"
		frame "time to ditch VIC-20 and get serious with BASIC 3.5."
		frame "My first floppy drive followed."
		if floppy ; then
			reset
			pi500 comp
			qstart -L vice_xplus4 $RA/roms/Commodore/C16.m3u
			gameover
		fi
		out -n "\e[2A"
		export ${val}=loop
		;;
	F3)
		frame "${RC}${KEY} ${BLUE}C${RED}= ${OFF} 128 owned: 06/19${ON}85${OFF}-10/19${ON}87${OFF}"
		frame
		pip "$YT/Preview/c128.mp4" 896
		frame "After 2-months on the first job, I had enough money"
		frame "saved for an engagement ring and this home computer."
		if floppy "C128 - System Guide.pdf" ; then
			reset
			pi500 comp
			qstart -L vice_x128 "$RA/roms/Commodore/C128.m3u"
			gameover
		fi
		out -n "\e[2A"
		export ${val}=loop
		;;
	F4)
		frame "${RC}${KEY} ${BLUE}C${RED}= ${OFF} 128D owned: 11/19${ON}87${OFF}-06/19${ON}88${OFF}"
		frame
		pip "$YT/Preview/c128d.mp4" 1084
		frame "Left my job earlier that year to become a consultant."
		frame "I bought this professional model as motivation to up"
		frame "my game with CP/M, BASIC 128, Merlin 128, and Power C."
		if floppy "C128D - System Guide.pdf" ; then
			reset
			pi500 comp
			qstart -L vice_x128 "$RA/roms/Commodore/C128-VDC.m3u"
			gameover
		fi
		out -n "\e[2A"
		export ${val}=loop
		;;
	F5)
		frame "${RC}${KEY} ${BLUE}C${RED}= ${OFF} Amiga 2000 owned: 06/19${ON}88${OFF}-12/19${ON}91${OFF}"
		frame
		pip "$YT/Preview/a2000.mp4" 896
		frame "A new job meant a new car, then the decision to"
		frame "go PC DOS or stick with Commodore. Good choice!"
		frame "My first laser printer followed."
		if floppy ; then
			reset
			pi500 comp
			qstart -L puae "$RA/roms/Commodore/A500 (MD).m3u"
			gameover
		fi
		out -n "\e[2A"
		export ${val}=loop
		;;
	F6)
		frame "${RC}${KEY} ${BLUE}C${RED}= ${OFF} Amiga 3000+T owned: 01/19${ON}92${OFF}-10/19${ON}97${OFF}"
		frame
		pip "$YT/Preview/a3000.mp4" 896
		frame "Lois helped me secure this awesome upgrade to"
		frame "full 32-bit personal computing."
		frame "My first SupraModem arrived in the new home."
		if floppy ; then
			reset
			pi500 comp
			qstart -L puae "$RA/roms/Commodore/A3030.m3u"
			gameover
		fi
		out -n "\e[2A"
		export ${val}=loop
		;;
	F7)
		frame "${RC}Networking status"
		frame
		reset
		pi500 attract
		nmcli device status
		ip -f inet addr list dev wlan0 | head -2
		out "Inspect \e[1m/etc/wpa_supplicant/wpa_supplicant.conf\e[m for any SSID(s):"
		grep -e ssid -e psk /etc/wpa_supplicant/wpa_supplicant.conf
		anykey
		gameover
		;;
	F8)
		frame "${RC}Game controllers"
		frame
		reset
		fastfetch
		pi500 attract
		out "List of any ${ON}${CYAN}USB${OFF} devices connected:"
		lsusb | grep -iv ' hub' # | grep -iv ' keyboard'
		out
		out "List of any ${ON}${BLUE}Bluetooth${OFF} devices connected:"
		bluetoothctl devices Connected
		if [ ${#PS5[@]} -gt 0 ]; then
			RGB=( "16 96 192" "192 96 16" "96 192 16" "96 192 64" "192 16 96" "96 16 192" )
			out "[${DIM}P#${OFF}]${DIM}  PS5 Controller ID -  %  life${OFF}"
			for j in `seq ${#PS5[@]}`; do
				let i=j-1
				out -n "[${ON}P$j${OFF}]  ${PS5[$i]} - ${DIM}"
				dualsensectl -d ${PS5[$i]} lightbar ${RGB[$i]} 160
				dualsensectl -d ${PS5[$i]} player-leds $j
				dualsensectl -d ${PS5[$i]} battery
			done
		fi
		out
		anykey
		gameover
		;;
	F9)
		FOLDER=main
		count=`ls $RA/scripts/${FOLDER}/*.sh | wc -l`
		frame "${RC}quick-pick from my $FOLDER $count shortcuts"
		reset
		pi500 attract
		audio "pick.mp3" &
		cd $RA/scripts/$FOLDER
		ls -1 *.sh | sed 's/\.sh$//g' | awk '{ printf("     %-15s",$1) }'
		cd - &> /dev/null
		out
		setterm --background cyan --foreground black --hbcolor bright white --store --clear=rest
		frame "You pick: ${DIM}${SC}" 1
		read -t 63 pick
		killall -qw ffplay &> /dev/null
		if [ -n "$pick" ]; then
			frame "\r\e[A\e[5C${SC}" 1
			pick="${pick%.*}"
			src "${pick}"
		fi
		gameover
		;;
	F11)
		reset
		fbtest
		sleep 2
		btop
		gameover
		;;
	F12)
		frame "${RC}" 1
		frame "\e[11C${DIM}JOSHUA"
		frame "Can you explain the removal of your user account on June 23, 19${ON}73${OFF}?"
		reset
		exit
		;;
	?)
		export ${val}=${sym:(-1)}
		[[ $sym =~ [+]KEY_? ]] || export ${val}=`echo ${sym:(-1)} | tr [:upper:] [:lower:]`
		frame "${RC}${DIM}${!val} ${OFF}${RIGHT}${ON} ${SC}" 1
		;;
	*)
		export ${val}="$got"
		;;
	esac
}

reset() {
	out -n "${SC}\e[1;${LINES}r${RC}\e[?c${OFF}\r"
	mt
	setleds -L < /dev/tty1 &> /dev/null
	setleds -F -caps -num -scroll < /dev/tty1
	stty echo ixon ixoff
	setterm --background black --foreground white --hbcolor grey --store --clear=rest
	for led in /dev/led? ; do echo 0 > $led/brightness ; done
	#killall -qw ffplay &> /dev/null
	pi500
}

kiosk()
{
	killall -qw mplayer &> /dev/null &
	volume "12%+"
	reset
	click

	[ -n "$1" ] && ln -sf "es_$1.cfg" .emulationstation/es_systems.cfg || ln -sf "es_systems.all" .emulationstation/es_systems.cfg

	case "$1" in
	arcade)
		pi500 mame es
		ln -sf "themesettings/es-theme-Animatics-DX.sys" .emulationstation/es_settings.cfg
		;;
	cart)
		pi500 game es
		ln -sf "themesettings/iconic-es.sys" .emulationstation/es_settings.cfg
		;;
	floppy)
		pi500 comp es
		ln -sf "themesettings/ES-THEME-RETRO_LUX.sys" .emulationstation/es_settings.cfg
		;;
	cdrom)
		pi500 game es
		ln -sf "themesettings/es-theme-PlayStation-X.sys" .emulationstation/es_settings.cfg
		;;
	handheld)
		pi500 game es
		ln -sf "themesettings/ES-THEME-ARCADEPLANET.sys" .emulationstation/es_settings.cfg
		;;
	nostalgia)
		pi500 game es
		ln -sf "themesettings/Hypermax-Plus-PixN.sys" .emulationstation/es_settings.cfg
		;;
	*)
		pi500 game es
		ln -sf "themesettings/es-theme-carbon-master.sys" .emulationstation/es_settings.cfg
		;;
	esac

	sleep 0.5
	cd $RA > /dev/null
	[ "`readlink $RA/ES.cfg`" = "$RA/console.cfg" ] || ln -sf "$RA/console.cfg" "$RA/ES.cfg"
	emulationstation --force-kiosk --home $RA
	cd - > /dev/null
	volume "${MASTER}"
	sleep 0.5
	gameover
}

play() {
	# set Pi mixer higher as RA template is configured @ 89% (-1 dB)
	volume "9%+"
	# preset player controller(s) for gaming
	if [ ${#PS5[@]} -gt 0 ]; then
		RGB=( "23 127 255" "255 127 23" "127 255 23" "23 255 127" "255 23 127" "127 23 255" )
		for i in `seq ${#PS5[@]}`; do
			declare -i j=i-1
			dualsensectl -d ${PS5[$j]} lightbar ${RGB[$j]} 255
			dualsensectl -d ${PS5[$j]} microphone-led off
			dualsensectl -d ${PS5[$j]} player-leds $i
			dualsensectl -d ${PS5[$j]} trigger both off
			# load any trigger mode(s)
			if [ "${#TRIGGER[@]}" -gt 0 ]; then
				for t in `seq ${#TRIGGER[@]}`; do
					declare -i m=t-1
					dualsensectl -d ${PS5[$j]} trigger ${TRIGGER[$m]}
				done
			fi
		done
	fi
	BGM="`ls -t $HOME/Music/Background/*.ogg | tail -1`"
	touch "$BGM"
	ln -sf "$BGM" $RA/assets/sounds/bgm.ogg 
	result=0
	gamemoderun retroarch --config=$RT/retroarch.cfg --log-file=$RT/runtime.log -v "$@" &> /dev/null || result=1
	frame "Your play time: ${DIM}`grep 'Content ran for' $RT/runtime.log | head -1 | awk -F': ' '{print $2}'`"
	dualsense
	volume "$MASTER"
	echo "gamemoderun $(which retroarch) --config=$RT/retroarch.cfg -v \"$1\" $2 $3 \"$4\" < /dev/null &> $RT/rerun.log" > $RT/rerun.sh
	chmod +x $RT/rerun.sh
	return $result
}

qstart() {
	lrtl
	play --appendconfig="$PLAY|$RA/one-shot.cfg" "$@"
}

arcade() {
	content="$1"
	roms="MAME 2003-Plus"
	core="mame2003_plus"
	if [ -n "$2" ]; then
		roms="MAME"
		core="$2"
	fi
	qstart -L $core "$RA/roms/$roms/$content.zip"
}

cheevos() {
	roms="`echo $@ | awk -F/ '{print $4}'`"
	[ "$roms" = "Atari 2600" ] && roms='Stella'
	content="`echo $@ | awk -F/ '{print $5}'`"
	content="${content%.*}"
	lrtl
	play --appendconfig="$PLAY|$RA/one-shot.cfg|$RA/cheevos.cfg" "$@"
}

audio() {
	#mpv --no-terminal --no-video "Music/$1"
	ffplay -autoexit -nodisp -loop 1 "Music/$1" &> /dev/null
}

click() {
	[ -z "$CLICK" ] && event="`ls -t $HOME/Music/Click/*.mp3 | tail -1`" || event="$HOME/Music/$CLICK"
	touch "${event}"
	CLICK=
	ffplay -autoexit -nodisp -loop 1 "${event}" &> /dev/null &
	if [ "$1" = "wait" ]; then
		wait -p ffplay
		volume "${MASTER}"
	fi
}

hdmi() {
	#head=`modetest -c | grep -v 0x0 | awk '{ print $3 $4 }' | grep ^connected | awk -F- '{ print $3 }' | head -1`
	head=`kmsprint | grep '(connected)' | awk -F- '{ print $3 }'`
	let HDMI=$head+0
	[ "$1" = "detect" ] && return
	[ -n "$1" ] && HDMI=$1
	[ $HDMI -lt 2 ] && HDMI=1
	[ $HDMI -eq 1 ] && fbset -a -g 1920 1080 1920 1080 16
	setfont Lat15-TerminusBold32x16
	WIDTH=112
	NETSTAT=$(( $WIDTH - 13 ))
	PAD='    '
	LPAD='\x0eah\x0f  '
	RPAD='  \x0eha\x0f'
	MODE=`fbset -s | grep ^mode | awk '{ print $2 }' | tr -d '"'`
	CROP=`echo ${MODE} | tr x :`
	PLAY="$RA/play.cfg|$RA/console.cfg"
}

myinet() {
	let tcp=$((`tail +2 /proc/net/arp | wc -l`+0))
	if [ $tcp -ge 1 ]; then
		NETWORK=`curl --connect-timeout 3.14 ipinfo.io/ip 2> /dev/null`
		[ -z "${NETWORK}" ] && NETWORK=`curl --connect-timeout 3.14 api.ipify.org 2> /dev/null`
		[ ${#NETWORK} -gt 15 ] && NETWORK="Internet ${ON}ON${OFF}"
	else
		NETWORK=""
		nmcli device disconnect wlan0 &> /dev/null
		nmcli device connect wlan0 &> /dev/null
	fi
}

nofocus() {
	while [ `fgconsole` -ne 1 ]; do
		sleep 1
		[ `fgconsole` -eq 5 ] && chvt 1
	done
	while pidof -q lightdm; do
		[ `fgconsole` -eq 1 ] && chvt 7
		sleep 6
	done
}

# thru the years ... 
video() {
	#systemctl --user restart pulseaudio.socket pulseaudio
	#vlc "$1" &> /dev/null
	#mplayer -ao sdl -vo fbdev2 -fs -xy 2 -zoom -quiet "$1" &> /dev/null
	#mplayer -vo fbdev2 -vf scale,crop=640:480 -zoom -quiet "$1" &> /dev/null
	#mpv --no-terminal "$1"
	ffplay -autoexit -exitonkeydown -loop 1 "$1" &> /dev/null
}

view() {
	frame
	frame
	frame "\e[2A ... rendering the manual ${DIM}${RIGHT} ${ON}${RIGHT} ${OFF}${RIGHT} ${SC}[ - ] ${PAD} ${PAD}"

	PDF=$RT/`basename "$1"`
	stat --cached=never "$1" &> $RT/view.log
	cp -v "$1" "$PDF" >> $RT/view.log 2>&1
	pdftoppm -q -r 200 -jpeg "$PDF" $RT/manual >> $RT/view.log 2>&1 &
	mt; sync
	stat --cached=never "$PDF" >> $RT/view.log 2>&1
	while pidof -q pdftoppm ; do
		sleep 0.1
		PAGES=`ls -t $RT/manual-* 2> /dev/null | head -1 | awk -F- '{print $2}'`
		frame "${RC}[ ${ON}${RED}${PAGES%%.*}${OFF} ] " 1
	done
	PAGES=`ls -t $RT/manual-* 2> /dev/null | head -1 | awk -F- '{print $2}'`
	frame "${RC}[ ${ON}${PAGES%%.*}${OFF} ] " 1
	rm -v "$PDF" >> $RT/view.log 2>&1

	out
	frame "Press ${KEY} SPACE ${OFF} for next page"
	frame "Press ${KEY} Q ${OFF} to quit"
	mt; sync

	any="to ${ON}view "`basename "$1"`"${OFF}"
	click wait
	if anykey 12 ; then
		killall -u $USER -qw fbi
		fbi --noverbose -a -m 1920x1080-60 $RT/manual* >> $RT/view.log 2>&1
	fi
	rm -v $RT/manual* >> $RT/view.log 2>&1
	gameover
}

nofocus

declare -i HDMI
hdmi
bluetoothctl power on

setterm --background black --foreground cyan --hbcolor grey --store
clear
out -n "\e[H${OFF}${CYAN}"
for i in `seq 15`; do frame ; done
out "\e[15;${LINES}r"
tail +3 /etc/issue | head -11

declare -i js=$(( `udevadm info /dev/input/event* | grep -c ID_INPUT_JOYSTICK=1` ))
declare -i mouse=$(( `udevadm info /dev/input/event* | grep -c -e ID_INPUT_MOUSE=1 -e ID_INPUT_TOUCHPAD=1 -e ID_INPUT_TOUCHSCREEN=1` ))
# ignore my media volume 'wheel' as a mouse device
#bluetoothctl devices Connected | grep -qc '8BitDo Retro Keyboard' && let mouse=$mouse-1
#lsusb | grep -qc '8BitDo Retro Keyboard' && let mouse=$mouse-1
out "\e[2A\e[28C${DIM}${js} joystick and ${mouse} mouse/touch detected${OFF}"
out

# stars & stripes forever
out -n "\e[$(( ${#PAD} + 2 ))C"
[ $HDMI -eq 1 ] && out -n "${DIM}HDMI ${HDMI}: ${MODE}" || out -n "${DIM}HDMI${OFF} ${RED}${HDMI}${OFF}: ${ON}${MODE}${OFF}"
STAR=`out -n "${ON}${WHITE}*"`
STRIPE=`out -n "${OFF}${RED}="`
out "\x0f\e[4C$STAR$STRIPE$STAR$STRIPE$STAR$STRIPE$STAR$STRIPE$STAR$STRIPE$STAR$STRIPE$STAR${BLUE}[${CYAN} RETRO \e[22mgaming 19\e[1m76\e[22m-20\e[1m16 ${BLUE}]$STAR$STRIPE$STAR$STRIPE$STAR$STRIPE$STAR$STRIPE$STAR$STRIPE$STAR$STRIPE$STAR\e[m"

# fetch next ANSI art
out -n '\n${SC}\e[H\x0e'
ART=`ls -t $RA/scripts/art/*.sh | tail -1`
source "${ART}"
touch "${ART}"
out -n "\x0f${RC}"
if [ -n "${PHRASE}" ]; then
	txt1=`echo ${PHRASE} | awk -F~ '{ print $1 }'`
	txt2=`echo ${PHRASE} | awk -F~ '{ print $2 }'`
	[ -z "${txt2}" ] && txt2="${txt1}"
	frame "\e[$(( 49 - (${#txt1} / 2) ))C${txt2}"
else
	frame "\e[37C${RED}M${DIM}y${OFF} ${RED}A${DIM}wesome${OFF} ${RED}G${DIM}ames${OFF} ${RED}A${DIM}rchive"
fi
frame

systemctl is-enabled lightdm > /dev/null \
 && STARTUP="Console" \
 || STARTUP="Desktop"
main

any="to continue"
got=
choice=
content=
roms=
username="`grep _username $RA/cheevos.cfg | awk -F= '{print $2}' | tr -d [:punct:][:space:]`"
password="`grep _password $RA/cheevos.cfg | awk -F= '{print $2}' | tr -d [:punct:][:space:]`"
let n=1
let L=0
packages="All"
PS5=
dualsense

source $RA/scripts/MASTER || MASTER="48%"
VOLUME=
volume "$MASTER"
myinet

while true ; do

CHOICE=( "" "R" 0 1 2 3 4 "N" "TAB" "!" "@" 5 6 7 8 9 "L" "Pi" "HELP" "ESC" "HOME" )
MENU=( "" "Rob's quick-pick" \
	"•${RED}A${YELLOW}r${GREEN}c${CYAN}a${BLUE}d${MAGENTA}e${WHITE}• ${OFF}emporium" \
	"Cartridge content" "Computer diskettes" "CD-ROM titles" "Handheld hero" "Nostalgic playlist" \
	"Archives" "Power off" "Re-boot" \
	"Let's party!" "Pinball wizard"	"Strategum" "Plug it in" "Homebrew magic" "Interactive animations" \
	"Bookshelf manuals" "Read me!" "LightDM desktop" "World-wide web" )

frame 
frame "\e[2A"

nofocus
pi500
prompt "Choose ${ON}${DOWN}${UP}${OFF}: ${DIM}" n choice

# wait, no head detected on startup?
[ $HDMI -lt 1 ] && gameover
dualsense
volume "$MASTER"

case $choice in
0)
	out "Coin-ops${OFF}: 19${ON}76${OFF} - 20${ON}01${OFF}"
	about
	pip "$YT/Preview/COIN-OP/`ls Videos/Preview/COIN-OP | shuf | head -1`" 1200
	if anykey 60 ; then
		arcade=${ARCADES[$(( RANDOM % ${#ARCADES[@]} ))]}
		frame "${RIGHT} ${ON}${RED}Transporting${OFF} to ${ON}${arcade} ${DIM}${LEFT}"
		kiosk arcade
	fi
	;;
1)
	out "Cartridges${OFF}: 19${ON}77${OFF} - 19${ON}98${OFF}"
	about
	pip "$YT/Preview/CART/`ls Videos/Preview/CART | shuf | head -1`" 1200
	if anykey 60 ; then
		retail=(
			"Zayre ${OFF}(Providence, 19${ON}80${OFF})"
			"Sears ${OFF}(RI Mall, 19${ON}81${OFF})"
			"KB Toy & Hobby ${OFF}(Garden City, 19${ON}82${OFF})"
			"The Arcade ${OFF}(Providence, 19${ON}83${OFF})"
			"Circuit City ${OFF}(Warwick, 19${ON}96${OFF})"
		)
		retail=${retail[$(( RANDOM % 5 ))]}
		frame "${RIGHT} ${ON}${RED}Transporting${OFF} to ${ON}${retail} ${DIM}${LEFT}"
		kiosk cart
	fi
	;;
2)
	out "Diskettes${OFF}: 19${ON}77${OFF} - 19${ON}99${OFF}"
	about
	pip "$YT/Preview/FLOPPY/`ls Videos/Preview/FLOPPY | shuf | head -1`" 1200
	if floppy ; then
		retail=(
			"Apex ${OFF}(Pawtucket, 19${ON}81${OFF})"
			"Ann & Hope ${OFF}(Warwick, 19${ON}82${OFF})"
			"Toys 'R Us ${OFF}(RI Mall, 19${ON}83${OFF})"
			"Micro Limits ${OFF}(Greenville, 19${ON}88${OFF})"
			"Software Connections ${OFF}(Warwick, 19${ON}90${OFF})"
			"CCRI Show ${OFF}(Warwick, 19${ON}95${OFF})"
			"CompUSA ${OFF}(Warwick, 19${ON}96${OFF})"
		)
		retail=${retail[$(( RANDOM % 7 ))]}
		frame "${RIGHT} ${ON}${RED}Transporting${OFF} to ${ON}${retail} ${DIM}${LEFT}"
		kiosk floppy
	fi
	;;
3)
	out "CD-ROMs${OFF}: 19${ON}89${OFF} - 20${ON}06${OFF}"
	about
	pip "$YT/Preview/CD-ROM/`ls Videos/Preview/CD-ROM | shuf | head -1`" 1200
	if anykey 60 ; then
		frame "${RIGHT} Poker night at ${ON}11 Patricia Court"
		kiosk cdrom
	fi
	;;
4)
	out "Handhelds${OFF}: 19${ON}89${OFF} - 20${ON}14${OFF}"
	about
	pip "$YT/Preview/HANDHELD/`ls Videos/Preview/HANDHELD | shuf | head -1`" 1200
	if anykey 60 ; then
		frame "${RIGHT} ${ON}${RED}Transporting${OFF} into the ${ON}magic screen ${DIM}${LEFT}"
		kiosk handheld
	fi
	;;
5)
	out "Party time!"
	party
	;;
6)
	out "Pinball wizard"
	pinball
	;;
7)
	out "Strategy games"
	strategy
	;;
8)
	out "Time to shoot?"
	analog
	;;
9)
	out "a homebrew is a free game made for an old system"
	pi500 comp
	homebrew
	;;
a)
	src asteroid
	;;
b)
	src bublbobl
	;;
c)
	src carnival
	;;
d)
	src mrdo
	;;
e)
	src elevator
	;;
f)
	src frogger
	;;
g)
	src galaga
	;;
h)
	src shollow
	;;
i)
	src invaders
	;;
j)
	src joust
	;;
k)
	src kungfum
	;;
l)
	src ladybug
	;;
m)
	src mspacman
	;;
n)
	src dkong
	;;
o)
	src junglek
	;;
p)
	src mpatrol
	;;
q)
	src ripoff
	;;
r)
	src robotron
	;;
s)
	src spiders
	;;
t)
	src timeplt
	;;
u)
	src gyruss
	;;
v)
	src vanguard
	;;
w)
	src galaxian
	;;
x)
	src xevious
	;;
y)
	src yard
	;;
z)
	src berzerk
	;;
A)
	src astrob
	;;
B)
	src blktiger
	;;
C)
	src cyberb2p
	;;
D)
	src defender
	;;
E)
	src megamania
	;;
F)
	src phoenix
	;;
G)
	src gorf
	;;
H)
	src hattrick
	;;
I)
	src gba
	;;
J)
	src bombjack
	;;
K)
	src kchampvs
	;;
L)
	out "play a Laserdisc by DAPHNE"
	laserdiscs
	;;
M)
	src mario-kart
	;;
N)
	out "Nostalgia playlist${OFF} - ${DIM}before my memory fails completely${OFF}"
	about
	pip "$YT/Preview/NOSTALGIA/`ls Videos/Preview/NOSTALGIA | shuf | head -1`" 1200
	setterm --background black --foreground cyan --hbcolor bright white --store --clear=rest
	frame
	[ -n "$username" ] && nickname="$username" || nickname="TheFlyingApe"
	if anykey ; then
		arcade=${ARCADES[$(( RANDOM % ${#ARCADES[@]} ))]}
		frame "${RIGHT} ${ON}${RED}Transporting${OFF} to ${ON}${arcade} ${DIM}${LEFT}"
		kiosk nostalgia
	fi
	;;
O)
	src hangon
	;;
P)
	src pitfall2
	;;
Q)
	src qbert
	;;
R)
	GAME=`ls -t $RA/scripts/main/*.sh | tail -1`
	src "${GAME}"
	n=1
	;;
S)
	src spacduel
	;;
T)
	src tapper
	;;
V)
	src vsyard-2p
	;;
W)
	src wow
	;;
X)
	src xtrainns
	;;
Y)
	src mswordu
	;;
Z)
	out "auto-boot into the ${DIM}${STARTUP}${OFF}"
	systemctl is-enabled lightdm > /dev/null \
	 && sudo systemctl disable lightdm \
	 || sudo systemctl enable lightdm
	systemctl is-enabled lightdm > /dev/null \
	 && STARTUP="Console" \
	 || STARTUP="Desktop"
	frame "is now enabled"
	audio "sounds/level.mp3"
	;;
TAB)
	out "\e[1;31mRed Bull${OFF} and ${DIM}Doritos${OFF} -- time to play!"
	frame "${ON}${RED}powered${OFF} by ${ON}${BLUE}Retro${CYAN}Arch ${GREEN}kiosk${OFF}"
	if floppy ; then
		FONT=$( ls -t $RA/fonts/*.ttf | tail -1 )
		touch "${FONT}"
 		sed -i 's/xmb_font = ".*"/xmb_font = "'${FONT//\//\\/}'"/' $RT/retroarch.cfg
		play --appendconfig="$PLAY|$RA/cheevos.cfg"
		gameover
	fi
	;;
attract)
	hdmi detect
	[ $HDMI -lt 1 ] && continue
	[ `fgconsole` -ne 1 ] && continue
	pidof -q lightdm && continue
	IDLE=23

	out -n "${RC}\e[J"
	if hype ; then
		volume "83%"
		CLICK="WOPR.mp3"
		myinet
	elif [ $(( $L % 2 )) -eq 0 ]; then
		volume "3%-"
		pi500 attract
		FILE="Attract/`ls -t $YT/Attract | tail -1`"
		frame "${RC}preview:${OFF} `basename "${FILE%.*}"`"
		touch -h "$YT/$FILE"
		mplayer -nogui -vo fbdev2 -nofs -vf scale -zoom -quiet -xy 1200 -geometry 42%:48% "$YT/$FILE" &> /dev/null
	else
		if [ ${#CART[@]} -eq 0 ]; then
			ATTRACT="${EXTRACT%.*}.lis"
			shuf "$EXTRACT" -o "$ATTRACT"
			L=0
			while read line ; do
				CART[$L]="$line"
				let L=$L+1
			done < "$ATTRACT"
		fi
		ARGS="${CART[(-1)]}"
		WHAT=$( echo "${ARGS}" | awk -F/ '{ print $4 }' )
		[[ "${WHAT}" =~ "MAME" ]] && WHAT="the Arcade"
		volume "3%-"
		pi500 attract
		FILE=$( basename "$( echo "${ARGS}" | awk -F'\x22' '{ print $2 }' )" )
	       	frame "${RC}play ${WHAT}:${OFF} ${FILE%.*}"
		( sleep 4 && echo -n "SHOW_MSG now playing $WHAT: ${FILE%.*}" | nc -u -w1 127.0.0.1 55355 )&
		echo "${ARGS}" | xargs -t timeout -k 3 -s SIGTERM 37 \
			retroarch --config=$RT/retroarch.cfg --appendconfig="$PLAY|$RA/attract.cfg" \
			--max-frames=$(( 30 * 60 )) \
			--set-shader="$RA/shaders/shaders_slang/film/technicolor.slangp" &> /dev/null
		if [ $? -eq 125 ]; then
			reset
		 	exit
		fi
		unset 'CART[(-1)]'
	fi
	L=$(( L + 1 ))
	frame
	;;
!)
	out "powering off"
	click wait
	for i in $( seq ${#PS5[@]} ); do
		declare -i j=i-1
		dualsensectl -d "${PS5[$j]}" lightbar 255 0 0
		dualsensectl -d "${PS5[$j]}" microphone-led on
	done
	volume "18%+"
	audio "sounds/hone.mp3"
	fbi --noverbose "$HOME/Pictures/Splash/splash.png" &> /dev/null &
	audio "Shutdown/`ls Music/Shutdown | shuf | head -1`"
	for i in `seq ${#PS5[@]}`; do
		declare -i j=i-1
		dualsensectl -d ${PS5[$j]} power-off
	done
	sudo poweroff
	;;
@|U)
	if [ "$choice" = "U" ]; then
		out "upgrading ${OFF}. . . possibly."
		retroarch --version
		volume "6%+"
		audio "Radio Edit Alpha Team.mp3" &
		# freshen stuff off my GDrive
		mkdir "$RT/Retro"
		rclone mount Retro: "$RT/Retro" --daemon
		SRC="$RT/Retro/updates"
		rclone copy --progress --update "$SRC/pi" ":local,links:$HOME"
		rclone copy --progress --update "$SRC/retroarch" ":local,links:$RA"
		cat "$SRC/addons.deb" | xargs sudo apt -y install
		# Linux
		sudo apt update &> /dev/null || continue
		reset
		sudo apt list --upgradable && sudo apt -y upgrade && sudo apt -y autoremove
		# Raspberry Pi
		sudo rm -fv /boot/firmware/.bootloader_revision &> /dev/null
		sudo rpi-eeprom-update -a
	fi
	out "reboot"
	reset
	click wait
	audio "sounds/hone.mp3"
	sudo reboot
	;;
"#"|HOME)
	FOLDER=
	src chromium
	;;
LALT)
	out "${KEY}${BLUE}ALT${OFF} change foreground virtual terminal"
	crt
	frame "\e[A"
	frame "${KEY} 1 ${OFF}  console ${ON}Playlists${OFF} menu"
	frame "${KEY} 2 ${OFF}  ${ON}${YELLOW}RetroArch${OFF} application folder"
	frame "${KEY} 3 ${OFF}  ${ON}${RED}Pi${OFF} login shell"
	frame "${KEY} 4 ${OFF}  ${ON}${BLUE}Bookshelf${OFF} PDF folder"
	n=1

	CHOICE=( "" "1" "2" "3" "4" )
	MENU=( "" "Playlists" "RetroArch" "Pi" "Bookshelf" )

	frame
	prompt "chvt ${ON}${DOWN}${UP}${OFF}: ${DIM}" n choice

	case $choice in
	[2-4])
		chvt $choice
		;;
	*)
		out "Stay & Play !!"
		click wait
		;;
	esac
	n=1
	;;
LCTRL)
	frame "Achievements require Internet and a login account."
	if [ -n "$username" ]; then
		frame "Change this account ${ON}$username${OFF} for ${ON}\e[33mRetroAchievements.org${OFF} badges? ${SC}" 1
		input 6
		[ "$got" = "y" ] && username= || frame "${RC}No"
	fi
	if [ -z "$username" ]; then
		crt
		frame "Visit ${ON}\e[33mRetroAchievements.org${OFF} to create a free account, then"
		frame "answer ${ON}y${OFF}es here to fill-in this account name & password."
		frame "Fill-in now? ${ON}${SC}" 1
		input 6
		if [ "$got" = "y" ]; then
			frame "${RC}Yes${OFF}"
			mt ; stty echo
			frame "Username: ${ON}${SC}" 1
			read -t 24 username
			if [ -n "$username" ]; then
 				sed -i 's/_username = ".*"/_username = "'$username'"/' $RA/cheevos.cfg
				sed -i 's/netplay.nickname" value=".*"/netplay.nickname" value="'$username'"/' $RA/.emulationstation/es_settings.cfg
				sed -i 's/ts.username" value=".*"/ts.username" value="'$username'"/' $RA/.emulationstation/es_settings.cfg
				frame "${OFF}Password: ${ON}${SC}" 1
				read -t 24 password
				if [ -n "$password" ] ; then
					token="`curl -s https://retroachievements.org/dorequest.php?r=login\&u=$username\&p=$password | jq -r '.Token'`"
					sed -i 's/_password = ".*"/_password = "'$password'"/' $RA/cheevos.cfg
					for cfg in $RA/.emulationstation/themesettings/*.sys ; do
						sed -i 's/netplay.nickname" value=".*"/netplay.nickname" value="'$username'"/' $cfg
						sed -i 's/ts.password" value=".*"/ts.password" value="'$password'"/' $cfg
						sed -i 's/ts.token" value=".*"/ts.token" value="'$token'"/' $cfg
						sed -i 's/ts.username" value=".*"/ts.username" value="'$username'"/' $cfg
					done
				fi
			fi
		else
			frame "${RC}No"
		fi
	else
		apiKey="n4OBTnalzxDECIVXNU8LS1mijqJpSqmj"
		curl -s https://retroachievements.org/API/API_GetUserProfile.php?y=$apiKey\&u=$username | jq -c '[.User, .MemberSince, .TotalTruePoints, .Motto]'
		curl -s https://retroachievements.org/API/API_GetUserRecentAchievements.php?y=$apiKey\&u=$username\&m=1440 | jq -c '.[] | [.GameTitle, .Title, .Description]'
		anykey
	fi
	;;
Pi)
	out "${KEY}${RED} Pi ${OFF} ${RIGHT}${ON} search ${OFF}cloud${ON} for a manual off my Bookshelf:"
	bookshelf
	frame 
	;;
PrtScn)
	if $HOME/bin/screenshot.sh ; then
		frame "${RC}console screenshot saved ${PAD}"
		audio "Click/002.mp3"
	else
		frame "${RC}console screenshot failed ${PAD}"
		audio "Click/000.mp3"
	fi
	frame
	;;
RALT)
	chvt 5
	sleep 4
	sudo killall -qw -HUP fbi
	#sudo openvt -f -c 5 -- clear
	gameover
	;;
"\$"|RCTRL)
	FOLDER=
	src basic
	;;
*LOCK)
	frame "${RC}${choice} pressed ${PAD}"
	frame
	;;
HELP|F10)
	frame "${RC}HELP"
	frame 
	frame "Press \e[A${KEY} Delete \e[B\e[8D${RED} Ins    ${OFF} off menu for Instructional Video."
	view "$HOME/Documents/HELP.pdf"
	frame
	;;
DELETE)
	frame "${RC}Instructional Video${OFF}"
	frame "An older overview on how to use these Playlists & Desktop."
	if anykey ; then
		volume "12%+"
		ffplay -autoexit -loop 1 "$HOME/Bookshelf/HELP.mp4" &> /dev/null
	fi
	;;
ESC)
	frame "${RC}starting ${ON}Light Display Manager${OFF}"
	click wait
	reset
	sudo systemctl start lightdm
	sudo systemctl restart getty@tty1 &
	exit
	;;
loop)
	;;
*)
	out -n "${ON}?${OFF}?${DIM}?"
	audio "Click/000.mp3"
	continue
	;;
esac

main

done

exit
