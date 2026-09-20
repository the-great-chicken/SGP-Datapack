#> sgp.kits:abilities/rays/raycast_fast/run_entities
#
# Entity-only variant used after a cardinal voxel scan proves blocks cannot intersect.

data modify storage bs:data raycast set value {sx:1,sy:1,sz:1}
scoreboard players set #ray_fast_blocks sgp.dummy 0
scoreboard players set #raycast.dm bs.data 16000
scoreboard players set #raycast.pe bs.data 51
execute store result score #raycast.te bs.data \
    run scoreboard players set #raycast.tm bs.data 2147483647
scoreboard players set #count bs.raycast.id 0

tag @e[tag=bs.raycast.checked,distance=..255] remove bs.raycast.checked
execute positioned ^ ^ ^ summon minecraft:marker \
    run function sgp.kits:abilities/rays/raycast_fast/recurse/init with storage bs:data raycast
