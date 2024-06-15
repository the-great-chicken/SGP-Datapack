tellraw @a[tag=in_game] [{"text":"", "color":"red"},{"text":"REFLEXES ! ", "bold":true, "color":"dark_red"},"Le Canarchimage a lancé un sort ! Vous avez 5 secondes pour cliquer ",{"text":"> ICI < ", "bold":true, "color":"red", "clickEvent":{"action":"run_command", "value":"/trigger sgp.reflexes_joueur"}, "hoverEvent":{"action":"show_text", "value":"CLIQUE !"}},"sinon vous mourrez !"]
scoreboard players enable @a[tag=in_game] sgp.reflexes_joueur
title @a[tag=in_game] title {"text":"REFLEXES!", "color":"dark_red", "bold":true}
scoreboard players set #reflexes_ticks sgp.timer 0
function sgp.mineurs:reflexes/running