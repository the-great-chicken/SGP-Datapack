#> sgp.kits:rays/wall
# @dummy
# @environment sgp.ci:rays/wall
#
# A solid wall shortens the beam to its surface without shortening the opposite beam.

gamemode spectator @s
tp @s 8.0 88.0 8.0 0 0
await entity @s[predicate=sgp.ci:rays/area_loaded]
function sgp.ci:perfect_accuracy/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:rays/fixture
setblock 8 88 12 stone
function sgp.ci:rays/start
function sgp.ci:rays/update
function sgp.ci:rays/beam {direction:south,scale:"6990..7010",center:"1745..1755"}
function sgp.ci:rays/beam {direction:north,scale:"31990..32010",center:"7995..8005"}
