#> sgp.majeurs:protect/devenir_roi_rouge
#
# This function is executed when a players wants to become the red king
# Gives him the kit and effects, tags him, announces it,...

execute as @p[scores={sgp.devenir_roi_rouge=1..}] run function sgp.kits:give {kit:roi}
effect give @p[scores={sgp.devenir_roi_rouge=1..}] minecraft:health_boost infinite 4 true
effect give @p[scores={sgp.devenir_roi_rouge=1..}] minecraft:regeneration 2 10 true

tag @p[scores={sgp.devenir_roi_rouge=1..}] add sgp.roi_rouge

execute at @e[type=marker,tag=sgp.marker,name="devenir_roi_rouge",limit=1] as @a[distance=..2] run team join sgp.rouge @s

execute as @p[scores={sgp.devenir_roi_rouge=1..}] run item replace entity @s hotbar.2 with minecraft:golden_apple[ \
    custom_name='{"text":"Pomme d\'or", "color":"yellow", "italic":false, "bold":true}', \
    lore=[ \
        '[ \
            {"text":"Régénère jusqu\'à 6", "color":"gray", "italic":false}, \
            {"text":"❤", "color":"red"}, \
            {"text":" + 2"}, \
            {"text":"❤", "color":"yellow"} \
            ]' \
        ] \
    ] 12

tp @p[scores={sgp.devenir_roi_rouge=1..}] @e[type=marker,tag=sgp.marker,name="protect_spawn_rouges",limit=1]
execute at @e[type=marker,tag=sgp.marker,name="devenir_roi_rouge",limit=1] as @a[distance=..2] run scoreboard players set @s sgp.entre_kits 1

scoreboard players set @p[scores={sgp.devenir_roi_rouge=1..}] sgp.devenir_roi_rouge 0

execute as @a[tag=sgp.in_game] run trigger sgp.devenir_roi_rouge set 0

tellraw @a[tag=sgp.in_game] ["",{"selector":"@a[tag=sgp.roi_rouge]","color":"dark_red","bold":true},{"text":" est le roi ","color":"gold"},{"text":"Rouge","color":"dark_red","bold":true}]
title @a[tag=sgp.in_game] subtitle [{"text":" est le roi ","color":"gold"},{"text":"Rouge","color":"dark_red","bold":true}]
title @a[tag=sgp.in_game] title [{"selector":"@a[tag=sgp.roi_rouge]","color":"dark_red","bold":true}]