#> sgp.kits:rays/unobstructed
# @dummy
# @environment sgp.ci:rays/unobstructed
#
# All eight beams reach sixteen blocks in open space.

gamemode spectator @s
tp @s 8.0 88.0 8.0 0 0
await entity @s[predicate=sgp.ci:rays/area_loaded]
function sgp.ci:perfect_accuracy/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:rays/fixture
function sgp.ci:rays/start
function sgp.ci:rays/update
function sgp.ci:rays/count {count:8}
function sgp.ci:rays/beam {direction:north,scale:"31990..32010",center:"7995..8005"}
function sgp.ci:rays/beam {direction:south,scale:"31990..32010",center:"7995..8005"}
function sgp.ci:rays/beam {direction:east,scale:"31990..32010",center:"7995..8005"}
function sgp.ci:rays/beam {direction:west,scale:"31990..32010",center:"7995..8005"}
function sgp.ci:rays/beam {direction:north_east,scale:"31990..32010",center:"7995..8005"}
function sgp.ci:rays/beam {direction:north_west,scale:"31990..32010",center:"7995..8005"}
function sgp.ci:rays/beam {direction:south_east,scale:"31990..32010",center:"7995..8005"}
function sgp.ci:rays/beam {direction:south_west,scale:"31990..32010",center:"7995..8005"}
