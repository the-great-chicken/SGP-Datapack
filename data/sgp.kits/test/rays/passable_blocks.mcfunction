#> sgp.kits:rays/passable_blocks
# @dummy
# @environment sgp.ci:rays/passable_blocks
#
# A beam passes through water but still stops at the solid block behind it.

gamemode spectator @s
tp @s 8.0 88.0 8.0 0 0
await entity @s[predicate=sgp.ci:rays/area_loaded]
function sgp.ci:origin_arena/ready
await entity @e[tag=sgp.ci.origin_ready,x=8,y=88,z=8,distance=..1,type=marker]
kill @e[tag=sgp.ci.origin_ready,type=marker]
function sgp.ci:rays/fixture
setblock 8 88 10 water strict
setblock 8 88 12 stone
function sgp.ci:rays/start
function sgp.ci:rays/update
function sgp.ci:rays/beam {direction:south,scale:"6990..7010",center:"1745..1755"}
