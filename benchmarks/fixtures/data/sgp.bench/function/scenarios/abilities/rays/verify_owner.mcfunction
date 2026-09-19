#> sgp.bench:scenarios/abilities/rays/verify_owner
# Executed outside profiling as one Rays actor. Records link ownership without
# depending on how the production ray update/raycast is implemented.

scoreboard players set #ray_owner_id sgp.bench -1
scoreboard players set #ray_linked sgp.bench -1
scoreboard players set #ray_id_matches sgp.bench -1
scoreboard players operation #ray_owner_id sgp.bench = @s bs.id
execute unless score #ray_owner_id sgp.bench matches 1.. run return 0

scoreboard players operation $link.to bs.in = @s bs.id
execute store result score #ray_linked sgp.bench if entity @e[tag=sgp.ray,predicate=bs.link:link_equal,type=item_display]
scoreboard players operation #ray_owned_by_actors sgp.bench += #ray_linked sgp.bench

scoreboard players operation $id.suid bs.in = @s bs.id
# Bookshelf SUIDs are global, so duplicates outside the benchmark player set matter too.
execute store result score #ray_id_matches sgp.bench if entity @e[predicate=bs.id:suid_equal]

execute if score #ray_linked sgp.bench matches 8 if score #ray_id_matches sgp.bench matches 1 run scoreboard players add #ray_valid_owners sgp.bench 1
