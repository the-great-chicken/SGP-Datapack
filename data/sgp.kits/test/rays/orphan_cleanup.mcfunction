#> sgp.kits:rays/orphan_cleanup
# @dummy
# @environment sgp.ci:rays/expiry_isolation
# A generic teleport strands one caster's beams; sweeps remove them while refreshed beams survive.

gamemode spectator @s
tp @s 8.0 88.0 8.0 0 0
await entity @s[predicate=sgp.ci:rays/area_loaded]
function sgp.ci:origin_arena/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:rays/fixture
function sgp.ci:rays/start
dummy RayPeer spawn
gamemode survival RayPeer
tp RayPeer 20.5 88.0 20.5
execute as RayPeer at @s run function sgp.kits:abilities/rays/init
scoreboard players set RayPeer sgp.duration_ability 70
summon item_display 8.0 88.0 9.0 {Tags:["sgp.ci.ray_other"]}

tp @s 27.5 88.0 8.5
function sgp.ci:rays/update
function sgp.kits:abilities/rays/cleanup
function sgp.ci:rays/count {count:8}
execute as RayPeer run function sgp.ci:rays/update
function sgp.kits:abilities/rays/cleanup
function sgp.ci:rays/count {count:0}
execute as RayPeer run function sgp.ci:rays/count {count:8}
execute positioned 8.0 88.0 8.0 run assert entity @e[tag=sgp.ci.ray_other,distance=..3,type=item_display]
