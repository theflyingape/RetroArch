# Pac-Man fruit bonus
c=$(( RANDOM % 8 ))
case $c in
0)	# Cherries
	out
	out "\e[89C                    \e[33mahah"
	out "\e[89C                \e[33mahahahah"
	out "\e[89C            \e[33mahah  ah"
	out "\e[89C          \e[33mah      ah"
	out "\e[89C  \e[31mahahah\e[33mah      ah"
	out "\e[89C\e[31mahahah\e[33mah\e[31mahah  \e[33mah"
	out "\e[89C\e[31mahahahahah  ah\e[33mah\e[31mahah"
	out "\e[89C\e[31mah\e[37mah\e[31mahah  ahahahahahah"
	out "\e[89C\e[31mahah\e[37mah\e[31mah  ahahahahahah"
	out "\e[89C  ahahah  ah\e[37mah\e[31mahahahah"
	out "\e[89C          ahah\e[37mah\e[31mahahah"
	out "\e[89C            ahahahah"
	;;
1)	# Strawberry
	out
	out "\e[90C          \e[37mah"
	out "\e[90C    \e[32mahahah\e[37mah\e[32mahahah"
	out "\e[90C  \e[31mahah\e[32mahahahahah\e[31mah\e[31mah"
	out "\e[90Cahahahahah\e[32mah\e[31mahahah\e[37mah\e[31mah"
	out "\e[90Cah\e[37mah\e[31mahahahahah\e[37mah\e[31mahahah"
	out "\e[90Cahahah\e[37mah\e[31mah\e[37mah\e[31mahahahahah"
	out "\e[90Cahahahahahahahah\e[37mah\e[31mahah"
	out "\e[90C  ah\e[37mah\e[31mahah\e[37mah\e[31mahahahahah"
	out "\e[90C  ahahahahahahahahah"
	out "\e[90C    ahah\e[37mah\e[31mahah\e[37mah\e[31m"
	out "\e[90C      ahahahahah"
	out "\e[90C          ah"
	;;
2)	# Peach
	out
	out "\e[89C              \e[32mahah"
	out "\e[89C          \e[33mah\e[32mahahahahah"
	out "\e[89C          \e[33mah  \e[32mahahah"
	out "\e[89C\e[1;33m    ahah\e[22mahahah\e[1mahahah"
	out "\e[89C  ahahahah\e[22mah\e[1mahahahahah"
	out "\e[89Cahahahahahahahahahahahah"
	out "\e[89Cahahahahahahahahahahahah"
	out "\e[89Cahahahahahahahahahahahah"
	out "\e[89Cahahahahahahahahahahahah"
	out "\e[89C  ahahahahahahahahahah"
	out "\e[89C  ahahahahahahahahahah"
	out "\e[89C      ahahahahahah"
	;;
3)	# Apple
	out
	out "\e[89C            \e[33mah"
	out "\e[89C  \e[31mahahah  \e[33mah  \e[31mahahah"
	out "\e[89Cahahahahah\e[33mah\e[31mahahahahah"
	out "\e[89Cahahahahahahahahahahahah"
	out "\e[89Cahahahahahahahahahahahah"
	out "\e[89Cahahahahahahahahahahahah"
	out "\e[89Cahahahahahahahahah\e[37mah\e[31mahah"
	out "\e[89Cahahahahahahahahah\e[37mah\e[31mahah"
	out "\e[89C  ahahahahahahah\e[37mah\e[31mahah"
	out "\e[89C  ahahahahahahahahahah"
	out "\e[89C    ahahahahahahahah"
	out "\e[89C      ahah  ahahah"
	;;
4)	# Melon
	out "\e[90C    \e[36mah"
	out "\e[90C      ahahahahah"
	out "\e[90C          ah"
	out "\e[90C        \e[32mah\e[37mah\e[32mah"
	out "\e[90C    ahahah\e[36mah\e[32mahahah"
	out "\e[90C  ah\e[36mah\e[37mah\e[36mah\e[32mahahah\e[36mah\e[32mah"
	out "\e[90C  ahah\e[36mah\e[32mahah\e[37mah\e[36mah\e[32mahah"
	out "\e[90Cah\e[37mah\e[36mah\e[32mahahah\e[36mah\e[32mah\e[36mah\e[32mahah"
	out "\e[90Cah\e[36mah\e[32mahah\e[37mah\e[36mah\e[32mahah\e[37mah\e[36mah\e[32mah"
	out "\e[90Cah\e[37mah\e[36mah\e[32mahahah\e[36mah\e[32mahahahah"
	out "\e[90C  ahah\e[36mah\e[37mah\e[36mah\e[37mah\e[36mah\e[32mahah"
	out "\e[90C  ahahah\e[36mah\e[32mahahah\e[36mah\e[32mah"
	out "\e[90C    ah\e[36mah\e[32mahahah\e[36mah\e[32mah"
	out "\e[90C        ahah\e[36mah    "
	;;
5)	# Galboss
	out
	out "\e[90C          \e[1;31mah"
	out "\e[90C\e[34mah      \e[31mahahah      \e[34mah"
	out "\e[90C\e[34mah    \e[31mahahahahah    \e[34mah"
	out "\e[90C\e[34mah\e[33mah\e[31mahah\e[33mah\e[31mah\e[33mah\e[31mahah\e[33mah\e[34mah"
	out "\e[90C\e[34mahah\e[33mahahah\e[31mah\e[33mahahah\e[34mahah"
	out "\e[90C  \e[34mahah\e[33mahah\e[33mah\e[33mahah\e[34mahah"
	out "\e[90C    \e[34mahah\e[33mahahah\e[34mahah"
	out "\e[90C      \e[34mahah\e[33mah\e[34mahah"
	out "\e[90C        \e[34mah\e[33mah\e[34mah"
	out "\e[90C          \e[33mah"
	out "\e[90C          \e[33mah"
	;;
6)	# Bell
	out "\e[89C          \e[1;33mahah"
	out "\e[89C      ahah    ahah"
	out "\e[89C    ahahahahahahahah"
	out "\e[89C    ahah  ahahahahah"
	out "\e[89C    ah  ahahahahahah"
	out "\e[89C  ahah  ahahahahahahah"
	out "\e[89C  ahah  ahahahahahahah"
	out "\e[89C  ahahahahahahahahahah"
	out "\e[89Cahah  ahahahahahahahahah"
	out "\e[89Cahah  ahahahahahahahahah"
	out "\e[89Cahahahahahahahahahahahah"
	out "\e[89Cah\e[0;36mahahahahah\e[37mahah\e[36mahahah\e[1;33mah"
	out "\e[89C  \e[0;36mahahahahah\e[37mahah\e[36mahahah  "
	;;
7)	# Key
	out "\e[94C    \e[36mahahah"
	out "\e[94Cahah      ahah"
	out "\e[94Cahahahahahahah"
	out "\e[94Cahahahahahahah"
	out "\e[94Cahahahahahahah\e[37m"
	out "\e[94C    ah  ah"
	out "\e[94C    ah  ahah"
	out "\e[94C    ah  ah"
	out "\e[94C    ah"
	out "\e[94C    ah  ah"
	out "\e[94C    ah  ahah"
	out "\e[94C    ah  ah"
	out "\e[94C      ah"
	;;
esac

