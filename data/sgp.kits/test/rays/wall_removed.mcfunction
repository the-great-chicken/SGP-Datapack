#> sgp.kits:rays/wall_removed
# @dummy
# @environment sgp.ci:rays/wall_removed
#
# Removing an obstruction restores the beam reach on the next update.

gamemode spectator @s
tp @s 8.0 88.0 8.0 0 0
await entity @s[predicate=sgp.ci:rays/area_loaded]
function sgp.ci:origin_arena/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:rays/fixture
setblock 8 88 12 stone
function sgp.ci:rays/start
function sgp.ci:rays/update
function sgp.ci:rays/beam {direction:south,scale:"6990..7010",center:"1745..1755"}
# An unchanged obstruction must retain both dimensions while rotation continues.
function sgp.ci:rays/update
function sgp.ci:rays/beam {direction:south,scale:"6990..7010",center:"1745..1755"}
execute positioned 8.5 88.6 8.5 run assert entity @e[tag=sgp.ray,tag=sgp.south,scores={sgp.dummy=3495..3505},distance=..0.01,type=item_display]
assert score @s sgp.ray_anim matches 66
setblock 8 88 12 air
function sgp.ci:rays/update
function sgp.ci:rays/beam {direction:south,scale:"31990..32010",center:"7995..8005"}
function sgp.ci:rays/update
function sgp.ci:rays/beam {direction:south,scale:"31990..32010",center:"7995..8005"}
execute positioned 8.5 88.6 8.5 run assert entity @e[tag=sgp.ray,tag=sgp.south,scores={sgp.dummy=16000},distance=..0.01,type=item_display]
assert score @s sgp.ray_anim matches 62
