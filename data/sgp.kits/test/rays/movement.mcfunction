#> sgp.kits:rays/movement
# @dummy
# @environment sgp.ci:rays/movement
#
# Beams settle on their caster after movement and retain their reach.

gamemode spectator @s
tp @s 8.0 88.0 8.0 0 0
await entity @s[predicate=sgp.ci:rays/area_loaded]
function sgp.ci:origin_arena/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:rays/fixture
function sgp.ci:rays/start
function sgp.ci:rays/update
tp @s 10.5 88.0 9.5 0 0
function sgp.ci:rays/update
function sgp.ci:rays/update
function sgp.ci:rays/count {count:8}
execute positioned 10.5 88.6 9.5 store result score #ci.rays.moved sgp.dummy if entity @e[tag=sgp.ray,distance=..0.01,type=item_display]
assert score #ci.rays.moved sgp.dummy matches 8
function sgp.ci:rays/beam {direction:south,scale:"31990..32010",center:"7995..8005"}
