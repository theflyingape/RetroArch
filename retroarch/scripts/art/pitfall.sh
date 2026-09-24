# Pitfall! 
c=$(( $RANDOM % 3 ))
case $c in
0)	# gator
	out "\n\n"
	out "\e[88C\e[33mah\e[32mah\e[33mahahahahahahahahahahah"
	out "\e[88C\e[33mah\e[32mahahahah\e[33mahahahahahahahah"
	out "\e[88C\e[33mah\e[32mah\e[33mahah\e[32mahahahah\e[34mahah\e[32mah\e[34mahah"
	out "\e[88C\e[34mahahahah\e[32mah\e[34mahah\e[32mahahahahah\e[34mah"
	out "\e[88C\e[34mah\e[32m\e[34mahahahahahah\e[32mah\e[34mahah\e[32mahah\e[34mah"
	out "\e[88C\e[34mah\e[34mahahahahahahahahah\e[32mahah\e[34mah"
	out "\e[88C\e[34mah\e[32mah\e[34mahah\e[32mah\e[34mahah\e[32mah\e[34mahah\e[32mahah\e[34mah"
	out "\e[88C\e[34mah\e[32mahahahahahahahahahahah\e[34mah"
	out "\e[88C\e[34mahahahahahahahahahahahahah"
	;;
1)	# scorpion
	out
	out "\e[1;37m"
	out "\e[93C  ahahah"
	out "\e[93Cahah  ahah"
	out "\e[93Cah      ah"
	out "\e[93Cah    ah    ah"
	out "\e[93Cahah      ah"
	out "\e[93Cahahahahah  ah"
	out "\e[93C  ahahahah"
	out "\e[93C    ahahahah"
	out "\e[93C    ahah    ahah"
	out "\e[93C  ah    ah    ah"
	;;
2)	# Harry
	out "\e[93C\e[33m      ahah"
	out "\e[93C\e[1m      ahah"
	out "\e[93C      ahah"
	out "\e[93C\e[32m      ah"
	out "\e[93C      ahah  ah"
	out "\e[93C    ahahahahah"
	out "\e[93C  ahahahahah"
	out "\e[93C  ah  ahah"
	out "\e[93C  ah  ahah"
	out "\e[93C\e[22m      ahahah"
	out "\e[93C      ahahahah"
	out "\e[93Cahah  ahah  ah"
	out "\e[93C  ahahah    ah"
	out "\e[93C    ahah    ahah"
	;;
esac
