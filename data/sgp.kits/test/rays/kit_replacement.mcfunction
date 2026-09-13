#> sgp.kits:rays/kit_replacement
# @dummy
# @environment sgp.ci:rays/kit_replacement

gamemode spectator @s
tp @s 8.0 88.0 8.0 0 0
await entity @s[predicate=sgp.ci:rays/area_loaded]
function sgp.ci:origin_arena/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:rays/fixture
tag @s add sgp.roi
tag @s add sgp.in_game
scoreboard players set @s sgp.kit_id 6
execute at @s run function sgp.kits:abilities/route_ability
dummy RayPeer spawn
gamemode survival RayPeer
tp RayPeer 20.0 88.0 20.0
execute as RayPeer at @s run function sgp.kits:abilities/rays/init
function sgp.ci:rays/count {count:8}
execute as RayPeer run function sgp.ci:rays/count {count:8}
summon item_display 8.0 88.0 9.0 {Tags:["sgp.ci.ray_other"]}
scoreboard players operation @e[tag=sgp.ci.ray_other,limit=1,type=item_display] bs.link.to = @s bs.id
function sgp.kits:give {kit:combattant}
function sgp.kits:kit_tags/management
function sgp.kits:abilities/tick
assert entity @s[tag=sgp.combattant,tag=!sgp.roi]
assert score @s sgp.duration_ability matches 0
function sgp.ci:rays/count {count:0}
execute as RayPeer run function sgp.ci:rays/count {count:8}
assert entity @e[tag=sgp.ci.ray_other,type=item_display]
