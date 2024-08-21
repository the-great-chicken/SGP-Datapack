#> sgp.majeurs:scheduler/message
#`{event}`
# 
# send a message to all players to announce the next major event
tellraw @a {"color":"gold", "bold":true, "text":"========================================="}
$tellraw @a [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"⚠ Le prochain événement majeur commence dans 2 minutes : ", "color":"gold"},{"text": "$(text)", "color":"yellow"}, {"text": " ⚠", "color":"gold"}]
tellraw @a {"color":"gold", "bold":true, "text":"========================================="}