tellraw @a ["",{"text":"REFLEXES ! ", "bold":true, "color":"dark_red"},{"text":"Le Canarchimage a lancé un sort ! Vous avez 5 secondes pour cliquer ", "color":"red"},{"text":"> ICI < ", "bold":true, "color":"red", "clickEvent":{"action":"run_command", "value":"/trigger reflexes_joueur"}, "hoverEvent":{"action":"show_text", "value":"CLIQUE !"}},{"text":"sinon vous mourrez !", "color":"red"}]
scoreboard players enable @a reflexes_joueur
title @a title {"text":"REFLEXES!", "color":"dark_red", "bold":true}
scoreboard players set #reflexes_ticks timer 0
schedule function sgp.mineurs:reflexes_running 1