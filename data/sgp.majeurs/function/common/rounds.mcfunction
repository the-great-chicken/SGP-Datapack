#> sgp.majeurs:common/rounds
#`{event, text}`
# 
# check if the number of rounds is less than the maximum number of rounds
# if true, schedule the next round in 30 seconds
$execute if score #rounds sgp.dummy >= #$(event)_max_rounds sgp.dummy run return 1
$schedule function sgp.majeurs:$(event)/_start 30s
scoreboard players add #rounds sgp.dummy 1
$tellraw @a [{"storage":"sgp.text", "nbt":"prefix", "interpret":true}, {"text":"Nouvelle partie de ", "color":"aqua"}, {"text":"$(text)", "color":"gold"}, {"text":" dans 30 secondes", "color":"aqua"}]