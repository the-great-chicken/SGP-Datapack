#> sgp.ci:activation_items/fixture
# Use the real return container and loot table, with players close enough to identify their freshly dropped items.

execute as @a[tag=sgp.ci.activation_actor] run dummy @s leave
kill @e[tag=sgp.ci.activation_item,type=item]
kill @e[tag=sgp.ci.activation_marker,type=marker]
fill ~ ~1 ~ ~8 ~4 ~4 air
fill ~ ~ ~ ~8 ~ ~4 stone
setblock ~6 ~1 ~ magenta_shulker_box
summon marker ~6 ~1 ~ {CustomName:"abilities_shulker",Tags:["sgp.marker","sgp.ci.activation_marker"]}
tag @s add sgp.ci.activation_actor
tag @s add sgp.in_game
gamemode survival @s
tp @s ~0.5 ~1 ~0.5 0 0
clear @s
scoreboard players set @s sgp.cooldown_ability 40
scoreboard players set @s sgp.duration_ability 7
