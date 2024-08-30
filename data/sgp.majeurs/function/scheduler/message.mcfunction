#> sgp.majeurs:scheduler/message
#`{event}`
# 
# send a message to all players to announce the next major event
tellraw @a {"color":"gold", "bold":true, "text":"========================================="}
$tellraw @a [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"⚠ Le prochain événement majeur commence dans 2 minutes : ", "color":"gold"},{"text": "$(text)", "color":"yellow"}, {"text": " ⚠\n", "color":"gold"},{"text":"Allez voir les règles dans le salon #events-majeurs sur le discord !", "color":"aqua"}]
tellraw @a {"color":"gold", "bold":true, "text":"========================================="}
scoreboard players set #rounds sgp.dummy 0