# Space Invaders
out 
c=$(( $RANDOM % 4 ))
case $c in
  0)
	out "\e[31m"
	out "\e[85C          ahahahahah"
	out "\e[85C      ahahahahahahahahah"
	out "\e[85C    ahahahahahahahahahahah"
	out "\e[85C  ahah  ah  ah  ah  ah  ahah"
	out "\e[85Cahahahahahahahahahahahahahahah"
	out "\e[85C    ahahah  ahahah  ahahah"
	out "\e[85C      ah              ah"
	;;
  1)
	out "\e[33m"
	out "\e[88C          ahah          "
	out "\e[88C        ahahahah        "
	out "\e[88C      ahahahahahah      "
	out "\e[88C    ahah  ahah  ahah    "
	out "\e[88C    ahahahahahahahah    "
	out "\e[88C      ah  ahah  ah      "
	out "\e[88C    ah            ah    "
	out "\e[88C      ah        ah      "
	;;
  2)
	out "\e[35m"
	out "\e[88C    ah            ah    "
	out "\e[88Cah    ah        ah    ah"
	out "\e[88Cah  ahahahahahahahah  ah"
	out "\e[88Cahahah  ahahahah  ahahah"
	out "\e[88Cahahahahahahahahahahahah"
	out "\e[88C  ahahahahahahahahahah  "
	out "\e[88C    ah            ah    "
	out "\e[88C  ah                ah  "
	;;
  3)
	out "\e[32m"
	out "\e[88C        ahahahah"
	out "\e[88C  ahahahahahahahahahah"
	out "\e[88Cahahahahahahahahahahahah"
	out "\e[88Cahahah    ahah    ahahah"
	out "\e[88Cahahahahahahahahahahahah"
	out "\e[88C      ahah    ahah  "
	out "\e[88C    ahah  ahah  ahah"
	out "\e[88Cahah                ahah"
	;;
esac

