title @a[tag=sgp.in_game] title {text:"REFLEXES!", color:dark_red, bold:true}
tellraw @a[tag=sgp.in_game] [{storage:"sgp.text", nbt:"prefix", interpret:true}, {text:"REFLEXES ! ", bold:true, color:dark_red}, {text:"Le Canarchimage a lancé un sort ! Vous avez 5 secondes pour cliquer ", color:red}, {text:"> ICI < ", bold:true, color:dark_red, click_event:{action:"run_command", command:"/trigger sgp.reflexes_joueur"}, hover_event:{action:show_text, value:"CLIQUE !"}}, {text:"sinon vous mourrez !", color:red}]

scoreboard players enable @a[tag=sgp.in_game] sgp.reflexes_joueur
scoreboard players set #reflexes_ticks sgp.timer 0

function sgp.mineurs:reflexes/running