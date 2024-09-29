#!/bin/bash
#
# console playlist menu written by Robert Hurst
#
sudo lastlog --clear --user $USER
clear
shopt -s expand_aliases
alias out='echo -e'
MODEL=`grep Model /proc/cpuinfo | awk -F': ' '{ print $2 }' | awk '{ print $2$3 }'`

# set RETROFE_PATH
export ROOTDIR=$HOME
export RETROFE_PATH=$ROOTDIR/ARCADE

DOC="$HOME/Bookshelf/"
RA=/retroarch
RT=/run/user/$UID

# rebuild login banner
offset=6
BANNER="`out '\e[0;2mFree entertainment brought to you by \e[0;33mThe Flying Ape\e[2m™\e[m'`"
OS=`grep PRETTY /etc/os-release | awk -F= '{print $2}' | tr -d '"'`
linux_logo -L raspi -o$offset -s -F "#E\n${OS} #V\n#N #M #X #T Processor#S, #R RAM" -t "${BANNER}" > $RT/issue
sudo mv $RT/issue /etc/issue
for i in `seq 2 1 6`; do sudo systemctl restart getty\@tty${i} ; done

# let's buffer next splash screen to keep it fresh
if ! pidof -q fbi ; then
	SPLASH="`ls -t $HOME/Pictures/Splash/* | tail -1`"
	touch "${SPLASH}"
	sudo fbi --noverbose -a -vt 8 "${SPLASH}" &> /dev/null &
	sleep 1.5
	CLICK="Startup/$(( RANDOM % 5 )).wav"
fi

which retroarch 2> /dev/null || export PATH=$HOME/.local/bin:$PATH

trap "sudo chvt 8; sleep 2; exit" 1 3 15

[ -f $RA/assets/sounds/BGM.wav ] && rm $RA/assets/sounds/BGM.wav
rm -f $RT/packages 2> /dev/null
YT="$HOME/Videos"
SAT="$YT/Saturday/"

BG=( yellow black blue black red magenta )
FG=( black green white white black white )
OFF='\e[0m'
ON='\e[0;1m'
DIM='\e[0;2m'
RED='\e[31m'
RVS='\e[0;7m'
KEY='\e[0;47;30;1m'
DOT='\x0e~\x0f'
DOWN='\x0e.\x0f'
LEFT='\x0e,\x0f'
RIGHT='\x0e+\x0f'
UP='\x0e-\x0f'
CROSS='\x0en\x0f'
HBAR='\x0eq\x0f'
VBAR='\x0ex\x0f'
FOCUS=`grep 'input_game_focus_toggle = ' $RT/retroarch.cfg | awk -F= '{ print $2 }' | tr -d ' "_'`
FOCUS="${KEY} ${FOCUS} ${OFF}"

# render favorite games idle playlist
EXTRACT="$RT/favorites.cmd"
rm -f "$EXTRACT"; touch "$EXTRACT"
let n=0
core=( bluemsx bsnes fbneo freeintv mame2003_plus nestopia prosystem stella vice_x64sc vice_xplus4 vice_xvic )
for lpl in 'ColecoVision' 'Super Nintendo' 'FBNeo' 'Intellivision' 'MAME' 'Nintendo Entertainment System' \
	'Atari 7800' 'Atari 2600' 'C64' 'C16' 'VIC20'; do
	while read content ; do
		lib="${core[$n]}"
		[[ "${content}" =~ "/MAME/" ]] && lib=mame
		echo "-L ${lib} ${content}" >> "$EXTRACT"
	done < <( grep '"path":' "$RA/content_favorites.lpl" | grep "/$lpl" | awk -F'"path": ' '{print $2}' | sed 's/.$//' )
	let n=$n+1
done

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

# cook input events
input() {
	let timer=$1+6
	main="$2"
	mt

	events=
	for event in /dev/input/event* ; do
		udevadm info $event | grep -q ID_INPUT_KEYBOARD=1 && events="$events $event"
		udevadm info $event | grep -q ID_INPUT_JOYSTICK=1 && events="$events $event"
		udevadm info $event | grep -q ID_INPUT_MOUSE=1 && events="$events $event"
	done

	got=
	status=1
	while read ev sym sel cmd; do
		[ $ev = "#" ] || continue
		let sel=$sel+0
		#out -n "\e[${WIDTH}C\e[20D${KEY} $sym ${OFF}\e[u"
		[ $sel -eq 1 -o $sel -eq -1 ] || continue
		[[ $sym =~ ^BTN_[A|B|X|Y]$ || $sym =~ ^BTN_LEFT ]] && sym="BTN_GAMEPAD"
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
		[ $got = "LEFTMETA" ] && got="Pi"
		[[ ${#got} -eq 1 && $got =~ ^[A-Z]$ ]] && got=`echo ${got:(-1)} | tr [:upper:] [:lower:]`
		if [[ $got =~ .*SHIFT[+]KEY_? ]]; then
			key=${got:(-1)}
			[ $key = "1" ] && key="!"
			[ $key = "2" ] && key="@"
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
				volume "6%-"
				MASTER="$VOLUME"
				CLICK="Click/0$(( RANDOM % 10 ))2.mp3"
				click
				echo "MASTER=\"$MASTER\"" > $HOME/.local/etc/MASTER
				info="««${DOT}${DIM}${MASTER}${OFF}${DOT}»»"
				;;
			DPAD_RIGHT|RIGHT|VOLUMEUP)
				volume "6%+"
				MASTER="$VOLUME"
				CLICK="Click/0$(( RANDOM % 10 ))2.mp3"
				click
				echo "MASTER=\"$MASTER\"" > $HOME/.local/etc/MASTER
				info="««${DOT}${DIM}${MASTER}${OFF}${DOT}»»"
				;;
			"!")
				[ "$FOLDER" = "main" ] && let ${sub}=8
				info=
				;;
			"@")
				[ "$FOLDER" = "main" ] && let ${sub}=9
				info=
				;;
			*)
				status=
				;;
			esac
			if [ $status ]; then
				[ $main -eq 1 ] \
				 	&& frame "\e[u${DIM}${CHOICE[${!sub}]} ${OFF}${RIGHT}${ON} ${MENU[${!sub}]} ${OFF}$info" 1 \
					|| frame "\e[u ${OFF}$info" 1
				continue
			fi
		fi
		status=0
		break
	done < <( timeout -s SIGALRM $timer thd --dump --normalize $events 2> /dev/null )
	[ "$got" = "PAUSE" ] && $HOME/bin/screenshot.sh
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
		frame "${lm}${PAD}${DIM}${DOT}${OFF} ${ON}${shelf%/*}${OFF}\e[$(( 24 - ${#shelf} - ${#PAD} ))C${RIGHT} ${count}\e[s" $i
	done
	frame "" 2
	frame "${ON}Shelf ${OFF}[Favorites]? \e[s" 1
	read -t 35 shelf

	shelf=`echo $shelf | tr -dc '[:alnum:][:space:]' | tr -s ' '`
	[ -z "$shelf" ] && shelf="Favorites"
	SHELF=`ls --file-type ${DOC} | grep '.*/' | grep -i ^$shelf | head -1`
	[ -z "$SHELF" ] && return

	VOLS=( `ls ${DOC}${SHELF}*.pdf | awk '{print $1}' | uniq` )
	for now in once ; do
	mt; stty echo
	frame
	frame "\e[A${ON}Search ${DIM}${SHELF%/*}${OFF} shelf: \e[s" 1
	read -t 35 PDF
	PDF=`echo $PDF | tr -dc '[:alnum:][:space:]' | tr -s ' '`
	if [ -z "${PDF}" ]; then
	       PDF=`basename ${VOLS[$((RANDOM%${#VOLS[@]}))]}`
	       PDF="`echo ${PDF:0:4} | tr [:upper:] [:lower:] | tr -s ' '`"
	       frame "\e[u${PDF}"
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
	frame "${ON}View ${OFF}which (1-$i): \e[s" 1
	mt
	read -n 1 -t 15 choice || out
	case $choice in
	[1-9])
		let i=$choice-1
		if [ -n "${PDF[$i]}" ]; then
			frame "\e[u${choice} - ${PDF[$i]}"
			view "${DOC}${SHELF}${PDF[$i]}"
		fi
		;;
	esac
	done
}

show() {
	reset
	SHOW=( `ls --file-type $SAT | grep '.*/'` )
	for show in ${SHOW[@]}; do
		count=`find ${SAT}${show} -name '*.mp4' | wc -l`
		frame "${PAD}${DIM}${DOT}${ON} ${show%/*}\e[$(( 24 - ${#show} - ${#PAD} ))C${OFF}${RIGHT} $count"
	done
	frame "\n\n\e[3A"
	frame "${ON}Show ${OFF}? \e[s" 1
	read -t 26 show

	show=`echo $show | tr -dc '[:alnum:][:space:]' | tr -s ' '`
	[ -z "$show" ] && return
	SHOW=`ls --file-type $SAT | grep '.*/' | grep -i ^$show | head -1`
	[ -z "$SHOW" ] && return
	frame "\e[u${SHOW%/*}"

	setterm --background blue --foreground white --hbcolor bright yellow --store --clear=rest
	frame 
	frame "Use ${UP}${DOWN} and ${KEY} RETURN ${OFF} to SELECT a show"
	frame "... then ${KEY} SPACE ${OFF} to PLAY"
	frame "Use ${LEFT}${RIGHT} to back/forward within show" 
	frame "Use ${KEY} RETURN ${OFF} to go back to playlist"
	frame "Use ${KEY} A ${OFF} ${KEY} Z ${OFF} ${KEY} M ${OFF} for Volume Up/Down/Mute"
	frame "Press ${KEY} Q ${OFF} anytime to quit"
	pip "${SAT}Trailers/${SHOW%/*}.mp4" 1200
	anykey 180 || return
	volume "18%+"
	#--loop
	nvlc --no-color --no-metadata-network-access --start-paused "${SAT}${SHOW}"
	gameover
}

frame() {
	declare -i eol=$(( $2 - 1 ))
	[ $eol -eq 1 ] && cll=1 || cll=
	out -n "${OFF}\e[${cll}K\r${LPAD}\e[${WIDTH}C${RPAD}\r\e[${#PAD}C$1"
	[ $eol -eq 0 ] && out -n "\e[u" || out ""
}

gameover() {
	clear
	reset
	sudo chvt 8
	sleep 0.5
	kill -HUP $PPID `pidof bash`
}

hype() {
	HYPE="`find $YT/Hype/ -mmin -50`"
	if [ -z "$HYPE" ]; then
		HYPE="Hype/`ls -t $YT/Hype | tail -1`"
		touch "$YT/$HYPE"
		frame "\e[uenjoy video $HYPE"
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
	frame "\e[s\e[74C${KEY} ${LEFT} ${OFF} ${KEY} ${RIGHT} ${OFF} test volume ${DOWN}${UP} control now" 1
	[ -f "${PDF}" ] && frame "Press ${KEY}${RED} Pi ${OFF} to open its Bookshelf manual." 2 || frame "" 2
	frame
	frame
	out -n "\r\e[2A"
	frame "Press any button/key ${any}: \e[s\r\e[81C${KEY} ESC ${OFF} or Left ${KEY} Bumper ${OFF} to go back" 1
	any="to continue"
	input $sec 2
	status=$?
	killall -qw mplayer &> /dev/null &
	#while ps -C mplayer &> /dev/null ; do kill -QUIT `ps -C mplayer -o pid=` &> /dev/null ; sleep 0.1 ; done
	if [ $got = "Pi" ]; then
		frame "\e[u${KEY}${RED} Pi ${OFF} ${RIGHT}${ON} \e[s" 1
		if [ -f "$PDF" ]; then
			frame "\e[u`basename "$PDF"`" 1
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
	out -n "\e[uboot ${ON}$2${OFF} on $model\n\e[J"
	lines=
	frame "\e[74C${FOCUS} toggles keyboard focus"
	frame "\e[74C${KEY} Delete ${OFF} or ${KEY} Select ${OFF}+${KEY} Start ${OFF} to quit"
	lines=2
	if [ "$model" = "VIC" -o "$model" = "C16" -o "$model" = "C64" -o "$model" = "AMIGA" ]; then
		frame "\e[74C${KEY}${RED} Pi ${OFF} logo key to toggle ${model} ${ON}STATUS${OFF}"
		let lines=$lines+1
	fi
	if [ "$model" = "VIC" -o "$model" = "C16" -o "$model" = "C64" ]; then
		frame "\e[78C Left ${KEY} Ctrl ${OFF} is ${KEY}\e[34mC${RED}=${OFF} logo key"
		let lines=$lines+1
	fi
	if [ "$model" = "C64" ]; then
	       	frame "\e[77C Right ${KEY} Ctrl ${OFF} swaps Joysticks 1/2"
		let lines=$lines+1
	fi
	out "\e[${lines}A"
	if [ "$model" = "A800" ]; then
		frame "Press ${KEY} RETURN ${OFF} or ${KEY} FIRE ${OFF} to accept cartridge," 2
		frame "${PAD} after the $model core starts." 2
	fi
}

compete() {
	out -n "\e[ucompete ${OFF}or${DIM} play ${ON}$1${OFF}\n\e[J"
	frame "\e[74C${KEY} Shift ${OFF} or ${KEY} Select ${OFF} to deposit coin"
	frame "\e[74C${KEY} Enter ${OFF} or ${KEY} Start ${OFF} for Player start"
	frame "\e[73C${KEY} Delete ${OFF} or ${KEY} Select ${OFF}+${KEY} Start ${OFF} to quit"
	frame "\e[70C${KEY} Backspace ${OFF} ${DIM}${RIGHT}${ON}${RIGHT}${OFF} to review ${DIM}Achievements"
	out "\e[4A"
	any="for Cheevos ${DIM}challenge${OFF} or ${KEY}n${OFF}o to just play"
}

driver() {
	driver=`grep ^video_driver $1.cfg | awk -F' = ' '{ print $2 }'  | tr -d '"'`
	out "\e[0;37m${DOT}\e[7m${driver}\e[27m${DOT}"
}

lrtl() {
	log="$RA/logs/$roms/$content.lrtl"
	roms=
	content=
	if [ -f "$log" ]; then
		last=`grep played "$log" | awk -F': ' '{print $2}' | awk '{print $1}' | tr -d '"'`
		time=`grep time "$log" | awk -F': ' '{print $2}' | awk -F, '{print $1}' | tr -d '"'`
		frame "Last played on ${ON}`date -d $last +'%a %b %d %Y'`${OFF} with a total running time of ${DIM}$time"
	fi
}

pick() {
	play="play"
	[ -n "$2" ] && play="$2"
	out -n "\e[u$play ${ON}$1${OFF}\n\e[J"
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
	xy=640
	[ -n "$2" ] && xy=$2
	[ -f "$1" ] && mplayer -nofs -nogui -noconsolecontrols -vo fbdev2 -vf scale,crop=${CROP} -zoom -xy $xy -geometry 96%:0% -quiet "$1" &> /dev/null &
}

src() {
	rom=$( basename "${1%.*}" )
	script="$HOME/.local/${FOLDER}/${rom}.sh"
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

	[ ${#GUN[@]} -eq 0 ] && GUN=( `shuf -e 0 1 2 3 4 5` )
	declare -i i=${GUN[(-1)]}
	unset 'GUN[(-1)]'
	out -n "${OFF}\r"
	setterm --background ${BG[$i]} --foreground ${FG[$i]} --hbcolor bright yellow --store --clear=rest
	frame "" 2
}

volume() {
	VOLUME="`amixer set Master $1 | grep 'Front Left:' | awk '{print $5}' | tr -d '[]'`"
	declare -i v=`echo $VOLUME | tr -d '%'`*255/100
	for i in `seq ${#PS5[@]}`; do
		declare -i j=i-1
		dualsensectl -d ${PS5[$j]} speaker both
		dualsensectl -d ${PS5[$j]} volume $v
	done
}

floppy() {
	setterm --background green --foreground black --hbcolor bright yellow --store --clear=rest
	frame 
	frame "${DIM}COMMODORE${OFF}: press ${KEY}${RED} Pi ${OFF} logo key to toggle ${ON}STATUS BAR${OFF}"
	frame "Use Left ${KEY} Ctrl ${OFF} as ${KEY}\e[34mC${RED}=${OFF} logo key and Right ${KEY} Ctrl ${OFF} to swap Joysticks 1/2"
	frame 
	frame "${DIM}C64 HOME${OFF} playlist uses multiple floppy diskettes to play."
	frame 
	frame "Use ${FOCUS} to toggle ${ON}GAME FOCUS\e[35m OFF${OFF} for floppy ${ON}DRIVE${OFF} controls:"
	frame "${PAD}${PAD}${KEY} \ ${OFF} to toggle ${ON}EJECT${OFF}/${ON}INSERT${OFF} current disk"
	frame "${PAD}${PAD}${KEY} [ ${OFF} swap to ${ON}PREVIOUS${OFF} disk"
	frame "${PAD}${PAD}${KEY} ] ${OFF} swap to ${ON}NEXT${OFF} disk"
	frame "Toggle ${ON}GAME FOCUS\e[32m ON${OFF} when needed for ${DIM}COMPUTER${OFF} keyboard control"
	anykey "$1" 64
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
		"The idea for this game comes from the stories about Don Quixote, the legendary Spanish knight.\n${LPAD}In this game, the character looks very young and does not have a mustache. Also, he has a\t\t\t   ${RPAD}\n${LPAD}sword for a weapon and his faithful sidekick Sancho Panza follows him around although\t\t\t   ${RPAD}\n${LPAD}he does nothing (like ${ON}Jon${OFF}) to assist the hero (${ON}Randy${OFF}).\e[53C   ${RPAD}\n${LPAD}An assortment of mythical creatures including demons, dragons, skeletons and so on\t\t\t\t   ${RPAD}\n${LPAD}are encountered throughout the game.\e[71C   ${RPAD}\n${LPAD}The game ends when Don Quixote kills the evil witch and rescues Isabella.\t\t\t\t\t   ${RPAD}")
	i=0
	disc=

	setterm --background black --foreground cyan --hbcolor bright yellow --store --clear=rest
	frame 
	frame "${DOT}${DIM}1${OFF}  Astron Belt"
	frame "${DOT}${DIM}2${OFF}  Cliff Hanger"
	frame "${DOT}${DIM}3${OFF}  Dragon's Lair (extended)"
	frame "${DOT}${DIM}4${OFF}  Dragon's Lair II: Time Warp"
	frame "${DOT}${DIM}5${OFF}  Space Ace"
	frame "${DOT}${DIM}6${OFF}  Super Don Quixote"
	frame
	frame
	out -n "\e[A\e[5C${ON}Disc ${OFF}${DOWN}${UP}: \e[s${DIM}"

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
		[ $i -gt 0 ] && out -n "\e[u${i} ${OFF}${RIGHT}${ON} ${LABEL[$i]}"
		frame "\e[u" 1
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
		anykey && $HOME/Daphne/daphne.sh "${RA}/roms/Daphne/${disc}.daphne" &> /dev/null
	fi
	n=15
}

main() {
	crt
	frame "»${DIM}0${OFF}  Big Menu  10,304   •${DIM}5${OFF}  Party Games         14   ${DOT}${DIM}a${OFF}  Asteroids        ${DOT}${DIM}n${OFF}  Donkey Kong     ${DOT}${DIM}A${OFF}  Astro Blaster"
	frame "»${DIM}1${OFF}  Arcade     2,479   •${DIM}6${OFF}  Pinball Simulators   6   ${DOT}${DIM}b${OFF}  Bubble Bobble    ${DOT}${DIM}o${OFF}  Jungle King     ${DOT}${DIM}C${OFF}  Cyberball    "
	frame "»${DIM}2${OFF}  Computers  2,947   •${DIM}7${OFF}  RTS and Turn-based   9   ${DOT}${DIM}c${OFF}  Carnival         ${DOT}${DIM}p${OFF}  Moon Patrol     ${DOT}${DIM}D${OFF}  Defender     "
	frame "»${DIM}3${OFF}  Consoles   4,284   •${DIM}8${OFF}  Niche Controls      26   ${DOT}${DIM}d${OFF}  Mr. Do!          ${DOT}${DIM}q${OFF}  Ripoff          ${DOT}${DIM}G${OFF}  GORF         "
	frame "»${DIM}4${OFF}  Handhelds  2,752   •${DIM}9${OFF}  Homebrews            5   ${DOT}${DIM}f${OFF}  Frogger          ${DOT}${DIM}r${OFF}  Robotron 2084   ${DOT}${DIM}H${OFF}  Hat Trick    "
	frame "»${DIM}N${OFF}  Netplay    3,664   •${DIM}L${OFF}  Laserdiscs           6   ${DOT}${DIM}g${OFF}  Galaga           ${DOT}${DIM}s${OFF}  Spiders         ${DOT}${DIM}K${OFF}  Karate Champ "
	frame "                                                    ${DOT}${DIM}j${OFF}  Joust            ${DOT}${DIM}t${OFF}  Time Pilot      ${DOT}${DIM}Q${OFF}  Q*bert        "
	frame "${DOT}${DIM}!${OFF}  Power off          ${DOT}${DIM}U${OFF}  Upgrade Linux (reboot)   ${DOT}${DIM}k${OFF}  Kung-Fu Master   ${DOT}${DIM}x${OFF}  Xevious         ${DOT}${DIM}S${OFF}  Space Duel   "
	frame "${DOT}${DIM}@${OFF}  Reboot             ${DOT}${DIM}Z${OFF}  Toggle boot: ${ON}${STARTUP}${OFF}   ${DOT}${DIM}l${OFF}  Lady Bug         ${DOT}${DIM}y${OFF}  10-Yard Fight   ${DOT}${DIM}T${OFF}  Tapper        "
	frame "                                                    ${DOT}${DIM}m${OFF}  Ms. Pac-Man      ${DOT}${DIM}z${OFF}  Berzerk         ${DOT}${DIM}W${OFF}  Wizard of Wor "
	FOLDER=main
}

party() {
	crt
	frame "${DOT}${DIM}g${OFF}  Gauntlet       (~4P)   ${DOT}${DIM}G${OFF}  Gauntlet II             (~4P)"
	frame "${DOT}${DIM}h${OFF}  Hoyle Casino   (~4P)   ${DOT}${DIM}H${OFF}  Gauntlet Legends        (~4P)"
	frame "${DOT}${DIM}j${OFF}  Jumpman        (~4P)   ${DOT}${DIM}L${OFF}  Game of Life            (~6P)"
	frame "${DOT}${DIM}k${OFF}  Mario Kart 64  (~4P)   ${DOT}${DIM}N${OFF}  Ninja Baseball Batman   (~4P)"
	frame "${DOT}${DIM}m${OFF}  Monopoly       (~8P)   ${DOT}${DIM}R${OFF}  Rampage                 (~3P)"
	frame "${DOT}${DIM}t${OFF}  Trog           (~4P)   ${DOT}${DIM}S${OFF}  Super Smash Bros        (~4P)"
	frame "${DOT}${DIM}w${OFF}  Wizard         (~6P)   ${DOT}${DIM}T${OFF}  Tecmo Bowl              (~4P)"
	frame
	n=1

	FOLDER=party
	CHOICE=( "" "g" "h" "j" "k" "m" "t" "w" "G" "H" "L" "N" "R" "S" "T" )
	MENU=( "" "Gauntlet" "Hoyle Casino" "Jumpman" "Mario Kart 64" "Monopoly" "Trog" "Wizard" \
		"Gauntlet II" "Gauntlet Legends" "Game of Life" "Ninja Baseball Batman" "Rampage" \
		"Super Smash Bros" "Tecmo Bowl" )

	frame 
	frame "${OFF}\e[$(( $WIDTH - 17 ))C${KEY}\x0eah\x0f `date +'%a %I:%M%P'` \x0eha\x0f${OFF}\e[2A"
	prompt "Party ${ON}${DOWN}${UP}${OFF}: ${DIM}" n choice

	dualsense
	volume "$MASTER"
	[ "$choice" = "attract" ] && choice=${CHOICE[$((RANDOM%${#MENU[@]}+1))]}

	case $choice in
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
	G)
		src gaunt2
		;;
	H)
		src glegends
		;;
	L)
		src golife
		;;
	N)
		src nbbatman
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
	n=10
}

pinball() {
	crt
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
	frame "${OFF}\e[$(( $WIDTH - 17 ))C${KEY}\x0eah\x0f `date +'%a %I:%M%P'` \x0eha\x0f${OFF}\e[2A"
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
	n=11
}

strategy() {
	crt
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
	frame "${OFF}\e[$(( $WIDTH - 17 ))C${KEY}\x0eah\x0f `date +'%a %I:%M%P'` \x0eha\x0f${OFF}\e[2A"
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
	n=12
}

niche() {
	crt
	frame "${ON}    Advanced              Dial/Spinner               Mouse/Trackball                     Lightgun"
	frame "${DOT}${DIM}1${OFF}  Lunar Lander      ${DOT}${DIM}a${OFF}  Kick         (~2P)     ${DOT}${DIM}A${OFF}  Centipede             (~2P)     ${DOT}${DIM}X${OFF}  Crossbow         (1P)"
	frame "${DOT}${DIM}2${OFF}  NBA 2K2           ${DOT}${DIM}b${OFF}  Megaball      (1P)     ${DOT}${DIM}B${OFF}  City Defense          (~2P)     ${DOT}${DIM}Y${OFF}  Duck Hunt       (~2P)"
	frame "${DOT}${DIM}3${OFF}  NFL 2K2           ${DOT}${DIM}c${OFF}  Omega Race   (~2P)     ${DOT}${DIM}C${OFF}  Coors Light Bowling   (~2P)     ${DOT}${DIM}Z${OFF}  Enable Lightgun"
	frame "${DOT}${DIM}4${OFF}  Night Driver      ${DOT}${DIM}d${OFF}  Seawolf       (1P)     ${DOT}${DIM}D${OFF}  Empire Strikes Back   (~2P)"
	frame "${DOT}${DIM}5${OFF}  Pole Position     ${DOT}${DIM}e${OFF}  Seawolf II   (~2P)     ${DOT}${DIM}E${OFF}  Gridiron!             (~2P)"
	frame "${DOT}${DIM}6${OFF}  Spy Hunter        ${DOT}${DIM}f${OFF}  Tempest      (~2P)     ${DOT}${DIM}F${OFF}  Mini Golf             (~2P)"
	frame "${DOT}${DIM}7${OFF}  Star Trek                                    ${DOT}${DIM}G${OFF}  Missile Command       (~2P)"
	frame "${DOT}${DIM}8${OFF}  Toobin'                                      ${DOT}${DIM}H${OFF}  Star Wars             (~2P)"
	frame "${DOT}${DIM}9${OFF}  Tron                                         ${DOT}${DIM}I${OFF}  Tail Gunner            (1P)"
	frame 
	n=1

	FOLDER=niche
	CHOICE=( "" "1" "2" "3" "4" "5" "6" "7" "8" "9" \
			"a" "b" "c" "d" "e" "f" \
			"A" "B" "C" "D" "E" "F" "G" "H" "I" \
			"X" "Y" "Z" )
	MENU=( "" "Lunar Lander" "NBA 2K2" "NFL 2K2" "Night Driver" "Pole Position" "Spy Hunter" "Star Trek" "Toobin'" \
			"Tron" "Kick" "Megaball" "Omega Race" "Seawolf" "Seawolf II" "Tempest" \
			"Centipede" "City Defense" "Coors Light Bowling" "Empire Strikes Back" "Gridiron!" "Mini Golf" \
			"Missile Command" "Star Wars" "Tail Gunner" \
			"Crossbow" "Duck Hunt" "Sinden Lightgun" )

	frame 
	frame "${OFF}\e[$(( $WIDTH - 17 ))C${KEY}\x0eah\x0f `date +'%a %I:%M%P'` \x0eha\x0f${OFF}\e[2A"
	prompt "Niche ${ON}${DOWN}${UP}${OFF}: ${DIM}" n choice

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
	X)
		src crossbow
		;;
	Y)
		src duckhunt
		;;
	Z)
		frame "Calibrate a lightgun? \e[s" 1
		input 6
		while [ "$got" = "y" ]; do
			cd $HOME/src/Lightgun/Application > /dev/null
			timeout -s SIGALRM 100 mono LightgunMono.exe sdl 30
			cd - > /dev/null
			frame "Retry lightgun calibration? \e[s" 1
			input 6
		done
		cd $HOME/src/Lightgun/Application > /dev/null
		mono-service LightgunMono.exe
		cd - > /dev/null
	#	play --appendconfig="$PLAY|$RA/lightgun.cfg"
		niche
		;;
	esac
	pkill mono &> /dev/null
	rm -f /tmp/LightgunMono*
	n=13
}

homebrew() {
	crt
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
	frame "${OFF}\e[$(( $WIDTH - 17 ))C${KEY}\x0eah\x0f `date +'%a %I:%M%P'` \x0eha\x0f${OFF}\e[2A"
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
	n=14
}

mt() {
	while read -n 255 -t 0.02 mt &> /dev/null ; do
		sleep 0
	done
}

prompt() {
	[ $HDMI -gt 0 ] && sec=20 || sec=-2
	label=$1
	sub=$2
	val=$3
	export ${val}="${CHOICE[${!sub}]}"

	frame "$label\e[s${DIM}${!val} ${OFF}${RIGHT}${ON} ${MENU[${!sub}]}" 1
	click
	[ -z "${NETWORK}" ] && out -n "\r\e[${NETSTAT}C${OFF} «${ON}«${KEY}${RED} network ${ON}»${OFF}»\e[u" || out -n "\r\e[${NETSTAT}C${DIM}«${OFF} ${NETWORK%/*} ${DIM}»\e[u"
	[ -f $RT/packages ] && packages=`tail -1 $RT/packages | awk '{ print $1 }'`
	[ "$packages" = "All" ] || out -n "\r\e[$(( $WIDTH - 12 ))C${LEFT} ${KEY}\x0eah\x0f upgrade \x0eha\x0f${OFF} ${DIM}${RIGHT}\e[u"

	input $sec 1
	[ $status -eq 0 ] || got="attract"

	case $got in
	GAMEPAD|START|ENTER)
		export ${val}="${CHOICE[${!sub}]}"
		frame "\e[u" 1
		;;
	ESC|TL)
		export ${val}="ESC"
		;;
	F1)
		frame "\e[u${KEY} \e[34mC${RED}= ${OFF} VIC-20 (19${ON}81${OFF}-${ON}85${OFF})"
		pip "$YT/Preview/vic20.mp4" 896
		floppy "VIC20 - Friendly Guide.pdf" && qstart -L vice_xvic
		gameover
		;;
	F2)
		frame "\e[u${KEY} \e[34mC${RED}= ${OFF} 16 (19${ON}84${OFF}-${ON}85${OFF})"
		pip "$YT/Preview/c16.mp4" 896
		floppy && qstart -L vice_xplus4
		gameover
		;;
	F3)
		frame "\e[u${KEY} \e[34mC${RED}= ${OFF} 128 (19${ON}85${OFF}-${ON}89${OFF})"
		pip "$YT/Preview/c128.mp4" 896
		floppy "C128 - System Guide.pdf" && qstart -L vice_x128 "$RA/roms/Commodore/C128.m3u"
		gameover
		;;
	F4)
		frame "\e[u${KEY} \e[34mC${RED}= ${OFF} 128D (19${ON}86${OFF}-${ON}89${OFF})"
		pip "$YT/Preview/c128d.mp4" 1084
		if floppy "C128D - System Guide.pdf" ; then
			reset
			qstart -L vice_x128 "$RA/roms/Commodore/C128-VDC.m3u"
		fi
		gameover
		;;
	F5)
		frame "\e[u${KEY} \e[34mC${RED}= ${OFF} Amiga 2000 (19${ON}87${OFF}-${ON}92${OFF})"
		pip "$YT/Preview/a2000.mp4" 896
		floppy 60 && qstart -L puae "$RA/roms/Commodore/A500 (MD).m3u"
		gameover
		;;
	F6)
		frame "\e[u${KEY} \e[34mC${RED}= ${OFF} Amiga 3000T (19${ON}90${OFF}-${ON}92${OFF})"
		pip "$YT/Preview/a3000.mp4" 896
		floppy && qstart -L puae "$RA/roms/Commodore/A3030.m3u"
		gameover
		;;
	F7)
		frame "\e[uWireless settings"
		frame
		reset
		iwconfig wlan0 | head -6
		ip -f inet addr list dev wlan0 | head -2
		out "Inspect \e[1m/etc/wpa_supplicant/wpa_supplicant.conf\e[m for any SSID(s):"
		grep -e ssid -e psk /etc/wpa_supplicant/wpa_supplicant.conf
		anykey
		gameover
		;;
	F8)
		frame "\e[uGame controllers"
		frame
		reset
		neofetch --ascii_distro macos
		out "List of any \e[1;36mUSB${OFF} devices connected:"
		lsusb | grep -iv ' hub' # | grep -iv ' keyboard'
		out
		out "List of any \e[1;34mBluetooth${OFF} devices connected:"
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
		count=`ls $HOME/.local/${FOLDER}/*.sh | wc -l`
		frame "\e[uquick-pick from my $FOLDER $count shortcuts"
		reset
		audio "pick.mp3" &
		cd $HOME/.local/$FOLDER
		ls -1 *.sh | sed 's/\.sh$//g' | awk '{ printf("     %-15s",$1) }'
		cd - &> /dev/null
		out
		setterm --background cyan --foreground black --hbcolor bright white --store --clear=rest
		frame "You pick: ${DIM}\e[s" 1
		read -t 63 pick && killall -qw ffplay &> /dev/null
		frame "\r\e[A\e[11C${DIM}\e[s" 1
		pick="${pick%.*}"
		src "${pick}"
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
		frame "\e[u" 1
		frame "\e[11C${DIM}JOSHUA"
		frame "Can you explain the removal of your user account on June 23, 19${ON}73${OFF}?"
		reset
		exit
		;;
	?)
		export ${val}=${sym:(-1)}
		[[ $sym =~ [+]KEY_? ]] || export ${val}=`echo ${sym:(-1)} | tr [:upper:] [:lower:]`
		frame "\e[u${DIM}${!val} ${OFF}${RIGHT}${ON} \e[s" 1
		;;
	*)
		export ${val}="$got"
		;;
	esac
}

reset() {
	out -n "\e[s\e[1;${LINES}r\e[u${OFF}\r"
	mt
	setleds -L < /dev/tty1 &> /dev/null
	setleds -F -caps -num -scroll < /dev/tty1
	stty echo ixon ixoff
	setterm --background black --foreground white --hbcolor grey --store --clear=rest
	for led in /dev/led? ; do echo 0 > $led/brightness ; done
}

play() {
	# set Pi mixer higher as RA template is configured @ 89% (-1 dB)
	volume "18%+"
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
	frame "Running play time: ${DIM}`grep 'Content ran' $RT/runtime.log | head -1 | awk -F': ' '{print $3}'`"
	dualsense
	volume "$MASTER"
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
	frame "Achievements require Internet and a login account."
	if [ -n "$username" ]; then
		frame "Change this account ${ON}$username${OFF} for ${ON}\e[33mRetroAchievements.org${OFF} badges? \e[s" 1
		input 6
		[ "$got" = "y" ] && username= || frame "\e[uNo"
	fi
	if [ -z "$username" ]; then
		crt
		frame "Visit ${ON}\e[33mRetroAchievements.org${OFF} to create a free account, then"
		frame "answer ${ON}y${OFF}es here to fill-in this account name & password."
		frame "Fill-in now? ${ON}\e[s" 1
		input 6
		if [ "$got" = "y" ]; then
			frame "\e[uYes${OFF}"
			mt ; stty echo
			frame "Username: ${ON}\e[s" 1
			read -t 24 username
			if [ -n "$username" ]; then
 				sed -i 's/_username = ".*"/_username = "'$username'"/' $RA/cheevos.cfg
				frame "${OFF}Password: ${ON}\e[s" 1
				read -t 24 password
				[ -n "$password" ] && sed -i 's/_password = ".*"/_password = "'$password'"/' $RA/cheevos.cfg
			fi
		else
			frame "\e[uNo"
		fi
	fi
	roms="`echo $@ | awk -F/ '{print $4}'`"
	[ "$roms" = "Atari 2600" ] && roms='Stella'
	[ "$roms" = "Tournament" ] && roms='FinalBurn Neo'
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
	WIDTH=110
	NETSTAT=$(( $WIDTH - 11 ))
	PAD='     '
	LPAD='\x0eah\x0f   '
	RPAD='   \x0eha\x0f'
	MODE=`fbset -s | grep ^mode | awk '{ print $2 }' | tr -d '"'`
	CROP=`echo ${MODE} | tr x :`
	PLAY="$RA/play.cfg|$RA/HD.cfg"
}

nofocus() {
	sleep 1
	#while pidof -q sddm ; do
	#	sleep 6
	#done
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
	frame "\e[2A ... rendering the manual ${DIM}${RIGHT} ${ON}${RIGHT} ${OFF}${RIGHT} \e[s[ - ]${PAD}"

	cp "$1" $RT/ &> /dev/null
	PDF=`basename "$1"`
	pdftoppm -q -r 400 -jpeg "$RT/$PDF" $RT/manual &> /dev/null & 
	while pidof -q pdftoppm ; do
		PAGES=`ls -t $RT/manual-* 2> /dev/null | head -1 | awk -F- '{print $2}'`
		frame "\e[u[ ${ON}${PAGES%%.*}${OFF} ]${PAD}" 1
		sleep 0.1
	done

	out
	frame "Press ${KEY} SPACE ${OFF} for next page"
	frame "Press ${KEY} Q ${OFF} to quit"
	anykey && fbi -a $RT/manual* &> /dev/null
	rm $RT/manual* &> /dev/null
}

nofocus

# reset startup services
#systemctl --user restart pulseaudio.socket pulsaudio &> /dev/null
#systemctl --user stop pipewire.socket pipewire &> /dev/null
declare -i HDMI
hdmi
bluetoothctl power on

out -n '\e[H\e[0;36m'
setterm --background black --foreground cyan --hbcolor grey --store --clear=rest
for i in `seq 15`; do frame ; done
out "\e[15;${LINES}r"
tail +3 /etc/issue | head -11

declare -i js=$(( `udevadm info /dev/input/event* | grep -c ID_INPUT_JOYSTICK=1` ))
declare -i mouse=$(( `udevadm info /dev/input/event* | grep -c -e ID_INPUT_MOUSE=1 -e ID_INPUT_TOUCHPAD=1 -e ID_INPUT_TOUCHSCREEN=1` ))
# ignore my media volume 'wheel' as a mouse device
bluetoothctl devices Connected | grep -qc '8BitDo Retro Keyboard' && let mouse=$mouse-1
lsusb | grep -qc '8BitDo Retro Keyboard' && let mouse=$mouse-1
out "\e[2A\e[28C${DIM}${js} joystick and ${mouse} mouse/touch detected${OFF}"
out

# stars & stripes forever
out -n "\e[$(( ${#PAD} + 2 ))C"
[ $HDMI -eq 1 ] && out -n "${DIM}HDMI ${HDMI}: ${MODE}" || out -n "${DIM}HDMI${OFF} ${RED}${HDMI}${OFF}: ${ON}${MODE}${OFF}"
STAR="`out -n '\e[1;37m*'`"
STRIPE="`out -n '\e[0;31m='`"
out "\x0f\e[3C$STAR$STRIPE$STAR$STRIPE$STAR$STRIPE$STAR$STRIPE$STAR$STRIPE$STAR$STRIPE$STAR\e[34m[\e[36m Retrogaming 1976 - 2014 \e[34m]$STAR$STRIPE$STAR$STRIPE$STAR$STRIPE$STAR$STRIPE$STAR$STRIPE$STAR$STRIPE$STAR\e[m"

# fetch next ANSI art
out -n '\n\e[s\e[H\x0e'
ART=`ls -t $HOME/.local/art/*.sh | tail -1`
source "${ART}"
touch "${ART}"
out -n "\x0f\e[u"

systemctl is-enabled sddm > /dev/null \
 && STARTUP="Playlists" \
 || STARTUP="Desktop  "
main

# compatibility hack fixes between Raspberry models
case $MODEL in
Pi4)
	shader=$( grep shader_enable "$RA/config/Beetle PCE/Beetle PCE.cfg" | awk -F= '{ print $2 }' | tr -d [:punct:][:space:] )
	[ "$shader" = "false" ] || sed -i 's/shader_enable = ".*"/shader_enable = "false"/' "$RA/config/Beetle PCE/Beetle PCE.cfg"
	ln -sf "Nintendo 64.pi4" "$RA/config/Mupen64Plus-Next/Nintendo 64.opt"
	drc=$( grep _drc $RA/config/PCSX-ReARMed/PCSX-ReARMed.opt | awk -F= '{ print $2 }' | tr -d [:punct:][:space:] )
	[ "$drc" = "disabled" ] || sed -i 's/_drc = ".*"/_drc = "disabled"/' $RA/config/PCSX-ReARMed/PCSX-ReARMed.opt
	;;
Pi5)
	shader=$( grep shader_enable "$RA/config/Beetle PCE/Beetle PCE.cfg" | awk -F= '{ print $2 }' | tr -d [:punct:][:space:] )
	[ "$shader" = "true" ] || sed -i 's/shader_enable = ".*"/shader_enable = "true"/' "$RA/config/Beetle PCE/Beetle PCE.cfg"
	ln -sf "Nintendo 64.pi5" "$RA/config/Mupen64Plus-Next/Nintendo 64.opt"
	drc=$( grep _drc "$RA/config/PCSX-ReARMed/PCSX-ReARMed.opt" | awk -F= '{ print $2 }' | tr -d [:punct:][:space:] )
	[ "$drc" = "disabled" ] || sed -i 's/_drc = ".*"/_drc = "disabled"/' "$RA/config/PCSX-ReARMed/PCSX-ReARMed.opt"
	;;
esac

any="to continue"
got=
choice=
content=
roms=
username="`grep _username $RA/cheevos.cfg | awk -F= '{print $2}' | tr -d [:punct:][:space:]`"
let n=1
let L=0
packages="All"
NETWORK=`curl --connect-timeout 3.14 ifconfig.me 2> /dev/null || curl --connect-timeout 3.14 ipecho.net/plain 2> /dev/null`
PS5=
dualsense

source $HOME/.local/etc/MASTER
volume "$MASTER"

while [ true ]; do

CHOICE=( "" "R" 0 1 2 3 4 "N" "!" "@" 5 6 7 8 9 "L" "F10" "KEYLOCK" "Pi" "HELP" "ESC" )
MENU=( "" "Rob's quick-pick" "BIG `driver $RA/big`" "Arcade emporium `driver $RA/myarcade`" \
	"Computer craze `driver $RA/computers`" "Console mania `driver $RA/consoles`" \
	"Handheld hero `driver $RA/handhelds`" "Netplay friends (~3P remote) `driver $RA/netplay`" \
	"Power off" "Re-boot" \
	"Let's party!" "Pinball wizard"	"Strategum" "Plug it in" "Homebrew magic" "Interactive animations" \
	"next cartoon" "Saturday TV or cinema matinee shows" "Bookshelf manuals" "Read me!" \
	"KDE Plasma desktop")

sudo chvt 1
frame 
frame "${OFF}\e[$(( $WIDTH - 17 ))C${KEY}\x0eah\x0f `date +'%a %I:%M%P'` \x0eha\x0f${OFF}\e[2A"
prompt "Choose ${ON}${DOWN}${UP}${OFF}: ${DIM}" n choice

# wait, no head detected on startup?
[ $HDMI -lt 1 ] && gameover
dualsense
volume "$MASTER"

case $choice in
0)
	out "\e[1;31mRed Bull${OFF} and ${DIM}Doritos${OFF} -- time to play!"
	click wait
	play --appendconfig="$PLAY|$RA/big.cfg|$RA/cheevos.cfg"
	gameover
	;;
1)
	out "Off to the arcade - got quarters?"
	click wait
	play --appendconfig="$PLAY|$RA/myarcade.cfg"
	gameover
	;;
2)
	out "Happy keyboard hacking!${OFF}!"
	if [ ! -f "$RT/once" ]; then
		touch "$RT/once"
		pip "$YT/Preview/Computers$((RANDOM%5+1)).mp4" 1200
	fi
	if floppy ; then
		play --appendconfig="$PLAY|$RA/computers.cfg"
		gameover
	fi
	;;
3)
	out "Pull something good off the shelf"
	click wait
	play --appendconfig="$PLAY|$RA/consoles.cfg|$RA/cheevos.cfg"
	gameover
	;;
4)
	out "Into the magic screen"
	click wait
	play --appendconfig="$PLAY|$RA/handhelds.cfg|$RA/cheevos.cfg"
	gameover
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
	niche
	;;
9)
	out "a homebrew is a new game made for an old system"
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
	FLIX="`ls -t $SAT/Retro/*.mp4 | tail -1`"
	touch "$FLIX"
	frame "\e[uenjoy video `basename "$FLIX"`"
	volume "12%+"
	video "$FLIX"
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
	out "NetPlay friends${OFF} - ${DIM}re-boot${OFF} after exit"
	frame 
	click wait
	pip "$YT/Preview/netplay.mp4" 1176
	frame "Runs in Standard 4:3 mode - you may want to switch your display to match"
	frame "if it stretches to fill HD. Look for an Aspect, Fill, or Scaling setting."
	setterm --background black --foreground cyan --hbcolor bright white --store --clear=rest
	frame
	[ -z "$username" ] && frame "${DOT}${ON} Settings ${OFF}${RIGHT}${ON} User${OFF}:         setup ${DIM}Username${OFF} for Player(s) to find in list"
	frame "${DOT}${ON} NetPlay ${OFF}${RIGHT}${ON} Host ${OFF}${RIGHT}${ON} Start${OFF}:  Player One hosts the game after launching it"
	frame "\e[19C- ${DIM}or${OFF} -  Player One presses ${KEY} TAB ${OFF} hotkey to host"
	[ -n "$username" ] && nickname="$username" || nickname="TheFlyingApe"
	frame "${DOT}${ON} NetPlay ${OFF}${RIGHT}${ON} Host refresh${OFF}:  remote Player(s) find ${DIM}$nickname${OFF} in the listing"
	frame "\e[19C${ON}list${OFF}    which is waiting for remote player(s) to connect"
	if anykey ; then
		clear
		play --appendconfig="$PLAY|$RA/netplay.cfg" --nick="$nickname"
		audio "sounds/hone.mp3"
		sudo reboot
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
	GAME=`ls -t $HOME/.local/main/*.sh | tail -1`
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
	reset
	systemctl is-enabled sddm > /dev/null \
	 && sudo systemctl disable sddm \
	 || sudo systemctl enable sddm
	audio "sounds/level.mp3"
	gameover
	;;
attract)
	hdmi detect
	[ $HDMI -lt 1 ] && continue
	pidof -q sddm && continue

	out -n "\e[u\e[J"
	if hype ; then
		volume "18%+"
		CLICK="WOPR.mp3"
	elif [ $(( $L % 2 )) -eq 0 ]; then
		volume "3%-"
		FILE="Attract/`ls -t $YT/Attract | tail -1`"
		frame "\e[upreview:${OFF} `basename "${FILE%.*}"`"
		touch "$YT/$FILE"
		mplayer -nogui -vo fbdev2 -nofs -vf scale -zoom -quiet -xy 1200 -geometry 42%:48% "$YT/$FILE" &> /dev/null
		volume "${MASTER}"
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
		WHAT=`echo ${ARGS} | awk -F/ '{print $4}'`
		[[ "${WHAT}" =~ "MAME" ]] && WHAT="the Arcade"
		volume "3%-"
		FILE=$( basename "`echo ${ARGS} | awk -F'\x22' '{print $2}'`" )
	       	frame "\e[uplay ${WHAT}:${OFF} ${FILE%.*}"
		( sleep 4 && echo -n "SHOW_MSG now playing $WHAT: ${FILE%.*}" | nc -u -w1 127.0.0.1 55355 )&
		echo ${ARGS} | xargs -t timeout -k 3 -s SIGTERM 36 \
			retroarch --config=$RT/retroarch.cfg --appendconfig="$PLAY|$RA/attract.cfg" \
			--max-frames=$(( 30 * 60 )) \
			--set-shader="$RA/shaders/shaders_slang/film/technicolor.slangp" &> /dev/null
		[ $? -eq 125 ] && reboot
		unset 'CART[(-1)]'
		volume "${MASTER}"
	fi
	let L=$L+1
	[ -z "$NETWORK" ] && NETWORK=`curl --connect-timeout 3.14 ifconfig.me 2> /dev/null || curl --connect-timeout 3.14 ipecho.net/plain 2> /dev/null`
	;;
!)
	out "powering off"
	click wait
	for i in `seq ${#PS5[@]}`; do
		declare -i j=i-1
		dualsensectl -d ${PS5[$j]} lightbar 255 0 0
		dualsensectl -d ${PS5[$j]} microphone-led on
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
		# freshen off my GDrive
		mkdir $RT/Retro
		rclone mount Retro: $RT/Retro --daemon
		SRC=$RT/Retro/aarch64
		rclone copy --progress --update --links $SRC/pi $HOME
		rclone copy --progress --update --links $SRC/retroarch $RA
		cat $SRC/addons.deb | xargs sudo apt -y install
		# Linux
		sudo apt update &> /dev/null || continue
		reset
		sudo apt list --upgradable && sudo apt -y upgrade
		# Raspberry Pi
		sudo rm -fv /boot/firmware/.bootloader_revision &> /dev/null
		sudo rpi-eeprom-update -a
		#RPi engineering has finally caught up releases with 6.6 tree
		#sudo rpi-update
	fi
	out "reboot"
	click
	reset
	audio "sounds/hone.mp3"
	sudo reboot
	;;
F10)
	frame "\e[uplay next cartoon"
	frame "" 2
	frame "Use ${KEY} A ${OFF} ${KEY} Z ${OFF} ${KEY} M ${OFF} for Volume Up/Down/Mute"
	frame "Press ${KEY} Q ${OFF} anytime to quit"
	if anykey ; then
		volume "18%+"
		FILE="${SAT}LooneyTunes/`ls -t ${SAT}LooneyTunes | tail -1`"
		frame "\e[uplay `basename "${FILE%.*}"`"
		touch "${FILE}"
		nvlc "${FILE}"
		gameover
	fi
	;;
Pi)
	out "${KEY}${RED} Pi ${OFF} ${RIGHT}${ON} search ${OFF}cloud${ON} for a manual off my Bookshelf:"
	bookshelf
	frame 
	;;
*LOCK)
	out "\q"
	frame "\e[uplay Saturday TV or Cinema matinee shows ${PAD}"
	frame "" 2
	show
	frame
	;;
HELP|SYSRQ)
	frame "\e[uHELP"
	frame 
	frame "Press \e[A${KEY} Delete \e[B\e[8D${RED} Ins    ${OFF} off menu for Instructional Video."
	#rsync -a Bookshelf/*.pdf Documents/ &> /dev/null
	view "$HOME/Documents/HELP.pdf"
	frame
	;;
DELETE)
	frame "\e[uInstructional Video${OFF}"
	frame "An overview on how to use these Playlists & Desktop."
	frame "Mouse & Keyboard controls are in effect."
	frame 
	frame "Press \e[A${KEY} PrtScn \e[B\e[8D${RED} SysRq  ${OFF} off menu for quick reference guide."
	if anykey ; then
		volume "12%+"
		ffplay -autoexit -loop 1 "$HOME/Bookshelf/HELP.mp4" &> /dev/null
	fi
	;;
ESC)
	frame "\e[ustarting ${ON}KDE Plasma Display${OFF}"
	sudo systemctl start sddm
	nofocus
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
