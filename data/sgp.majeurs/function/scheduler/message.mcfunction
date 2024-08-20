#> sgp.majeurs:scheduler/message
#`{event}`
# 
# send a message to all players to announce the next major event
tellraw @a {"color":"gold","bold":true,"text":"========================================="}
$tellraw @a [{"text":"[","color":"gray"},{"text":"SGP","color":"gold"},{"text":"] ","color":"gray"},{"color":"gold","text":"⚠ Le prochain événement majeur commence dans 2 minutes :"},{"text": " $(text)","color":"yellow"},{"color":"gold", "text": " ⚠"}]
tellraw @a {"color":"gold","bold":true,"text":"========================================="}