#> sgp.kits:abilities/pecking/start
#
# Checks if we are looking at player. If we are, start pecking.
# Else make a noise but doesn't start ability cooldown

# execute as @s run function #bs.view:at_aimed_entity {run:"tag @s add sgp.is_pecking", with:{max_distance:5}}

# Not using bookshelf, to have a "thick" ray cuz else it's too hard to aim, and desyncs are too frequent
# Checks in 3 spheres stacked on top of each other, to properly cover the player's hitbox height and allow for the same horizontal tolerance
# Checks in spheres every block, with a radius of 1, so they properly overlap each other in depth
# 4 blocks reach (last sphere is 3 blocks away and has radius 1)
tag @s add sgp.source_peck

execute positioned ^ ^ ^1.0 positioned ~ ~-0.3 ~ if entity @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_pecking
execute unless entity @s[tag=sgp.is_pecking] positioned ^ ^ ^1.0 positioned ~ ~-0.9 ~ if entity @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_pecking
execute unless entity @s[tag=sgp.is_pecking] positioned ^ ^ ^1.0 positioned ~ ~-1.5 ~ if entity @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_pecking

execute unless entity @s[tag=sgp.is_pecking] positioned ^ ^ ^2.0 positioned ~ ~-0.3 ~ if entity @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_pecking
execute unless entity @s[tag=sgp.is_pecking] positioned ^ ^ ^2.0 positioned ~ ~-0.9 ~ if entity @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_pecking
execute unless entity @s[tag=sgp.is_pecking] positioned ^ ^ ^2.0 positioned ~ ~-1.5 ~ if entity @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_pecking

execute unless entity @s[tag=sgp.is_pecking] positioned ^ ^ ^3.0 positioned ~ ~-0.3 ~ if entity @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_pecking
execute unless entity @s[tag=sgp.is_pecking] positioned ^ ^ ^3.0 positioned ~ ~-0.9 ~ if entity @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_pecking
execute unless entity @s[tag=sgp.is_pecking] positioned ^ ^ ^3.0 positioned ~ ~-1.5 ~ if entity @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_pecking

execute unless entity @s[tag=sgp.is_pecking] positioned ^ ^ ^4.0 positioned ~ ~-0.3 ~ if entity @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_pecking
execute unless entity @s[tag=sgp.is_pecking] positioned ^ ^ ^4.0 positioned ~ ~-0.9 ~ if entity @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_pecking
execute unless entity @s[tag=sgp.is_pecking] positioned ^ ^ ^4.0 positioned ~ ~-1.5 ~ if entity @p[tag=!sgp.peaceful,tag=!sgp.source_peck,distance=..1.0] run tag @s add sgp.is_pecking

tag @s remove sgp.source_peck

execute unless entity @s[tag=sgp.is_pecking] run return run playsound entity.villager.no master @s ~ ~ ~ 1 1.0

function sgp.kits:abilities/pecking/damage