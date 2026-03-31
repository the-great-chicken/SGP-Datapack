title @a[tag=sgp.in_game] title {"translate":"sgp.mineurs:reflexes_title", "fallback":"REFLEXES!", "color":"dark_red", "bold":true}
tellraw @a[tag=sgp.in_game] [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"translate":"sgp.mineurs:reflexes_start", "fallback":"%sLe Canarchimage a lancé un sort ! Vous avez 5 secondes pour cliquer %ssinon vous mourrez !", "color":"red", "with":[{"translate":"sgp.mineurs:reflexes_title", "fallback":"REFLEXES ! ", "bold":true, "color":"dark_red"}, {"translate":"sgp.mineurs:reflexes_click_here", "fallback":"> ICI < ", "bold":true, "color":"dark_red", "clickEvent":{"action":"run_command", "value":"/trigger sgp.reflexes_joueur"}, "hoverEvent":{"action":"show_text", "contents":{"translate":"sgp.mineurs:reflexes_click_hover", "fallback":"CLIQUE !"}}}]}]

scoreboard players enable @a[tag=sgp.in_game] sgp.reflexes_joueur
scoreboard players set #reflexes_ticks sgp.timer 0

function sgp.mineurs:reflexes/running