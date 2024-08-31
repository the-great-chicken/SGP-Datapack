#> sgp.majeurs:protect/king_dies
# `{team, color}`
#
# Announces the death of a king and registers it

$tellraw @a[tag=sgp.in_game] [{"text":"Le roi de l'Equipe ", "color":"gold"},{"text":"$(name) ", "color":"$(color)", "bold":true}, "est mort, les membres de son équipe ne peuvent plus réapparaitre!"]
$title @a[tag=sgp.in_game] title [{"text":"Roi ", "color":"gold"}, {"text":"$(name)", "color":"$(color)", "bold":true}, {"text":" décédé", "color":"gold"}]

execute at @e[type=marker,tag=sgp.marker,name=pvp_arena,limit=1] run \
    playsound entity.blaze.death master @a[tag=sgp.in_game] ~ ~ ~ 100

$scoreboard players set #mort_roi_$(team)_annoncee sgp.dummy 1