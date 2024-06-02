tellraw @a[tag=in_game] [{"text":"","color":"white"},{"text":"CONFINEMENT ! ", "color":"gray", "bold":true},"Le Canarchimage a répandu la Grippe Aviaire dans l'arène ! Vous avez ",{"text":"15 secondes", "color":"red", "bold":true}," pour rentrer en intérieur, ou vous mourrez !"]
title @a[tag=in_game] title {"text":"CONFINEMENT!","color":"gray","bold":true}
execute at @e[type=marker,tag=sgp.marker,name="pvp_arena",limit=1] run playsound minecraft:music_disc.strad master @a[tag=in_game] ~ ~ ~ 100
experience set @a[tag=in_game] 181 levels
function sgp.mineurs:confinement/running