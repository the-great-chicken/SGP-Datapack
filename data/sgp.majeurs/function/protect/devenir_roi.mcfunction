#> sgp.majeurs:protect/devenir_roi
# `{side, team, name, color}`
#
# This function is executed when a players wants to become a king
# Give him the kit and effects, tags him, announces it,...

function sgp.kits:give {kit:roi}
effect give @s minecraft:health_boost infinite 4 true
effect give @s minecraft:regeneration 2 10 true

$tag @s add sgp.roi_$(side)

$execute at @e[type=marker,tag=sgp.marker,name="devenir_roi_$(side)",limit=1] as @a[distance=..2] run team join sgp.$(team) @s

execute as @s run item replace entity @s hotbar.2 with golden_apple[ \
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

$tp @s @e[type=marker,tag=sgp.marker,name="protect_spawn_$(side)s",limit=1]

$execute at @e[type=marker,tag=sgp.marker,name="devenir_roi_$(side)",limit=1] as @a[distance=..2] run function sgp.kits:misc/entre_salle

$scoreboard players set @s sgp.devenir_roi_$(side) 0

$execute as @a[tag=sgp.in_game] run trigger sgp.devenir_roi_$(side) set 0

$tellraw @a[tag=sgp.in_game] ["",{"selector":"@a[tag=sgp.roi_$(side)]","color":"$(color)","bold":true},{"text":" est le roi ","color":"gold"},{"text":"$(name)","color":"$(color)","bold":true}]
$title @a[tag=sgp.in_game] subtitle [{"text":" est le roi ","color":"gold"},{"text":"$(name)","color":"$(color)","bold":true}]
$title @a[tag=sgp.in_game] title [{"selector":"@a[tag=sgp.roi_$(side)]","color":"$(color)","bold":true}]
