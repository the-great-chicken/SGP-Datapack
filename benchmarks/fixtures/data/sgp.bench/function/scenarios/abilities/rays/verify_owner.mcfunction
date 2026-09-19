#> sgp.bench:scenarios/abilities/rays/verify_owner
# Executed outside profiling as one Rays actor. Records link ownership without
# depending on how the production ray update/raycast is implemented.

scoreboard players set #ray_owner_id sgp.bench -1
scoreboard players set #ray_linked sgp.bench -1
scoreboard players operation #ray_owner_id sgp.bench = @s bs.id
execute unless score #ray_owner_id sgp.bench matches 1.. run return 0

scoreboard players operation $link.to bs.in = @s bs.id
execute store result score #ray_linked sgp.bench if entity @e[tag=sgp.ray,predicate=bs.link:link_equal,type=item_display]
tag @e[tag=sgp.ray,predicate=bs.link:link_equal,type=item_display] add sgp.bench.ray_owned

execute if score #ray_linked sgp.bench matches 8 run scoreboard players add #ray_valid_owners sgp.bench 1
