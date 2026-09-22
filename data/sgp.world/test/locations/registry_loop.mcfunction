#> sgp.world:locations/registry_loop
# @dummy
# @environment sgp.ci:locations/registry_loop
#
# The per-tick registry loop visits every registered marker (more than one shard round), survives
# a marker that disappeared mid-list, and drives entry, membership and leave like a direct scan.
# Markers sit 3 blocks apart along +x (marker i covers x in [3i, 3i+2)), 1 wide, 3 tall.
data modify storage sgp.ci:locations previous_registry set value []
data modify storage sgp.ci:locations previous_registry set from storage sgp:data markers_lists.location
data remove storage sgp:data markers_lists.location
scoreboard players set @s sgp.lieu_count 0
function sgp.ci:locations/loop_marker {index:1, x:3}
function sgp.ci:locations/loop_marker {index:2, x:6}
function sgp.ci:locations/loop_marker {index:3, x:9}
function sgp.ci:locations/loop_marker {index:4, x:12}
function sgp.ci:locations/loop_marker {index:5, x:15}
function sgp.ci:locations/loop_marker {index:6, x:18}
function sgp.ci:locations/loop_marker {index:7, x:21}
function sgp.ci:locations/loop_marker {index:8, x:24}
function sgp.ci:locations/loop_marker {index:9, x:27}
function sgp.ci:locations/loop_marker {index:10, x:30}
execute as @e[tag=sgp.test.location_loop,type=marker] run function sgp.world:lieu/register
execute store result score #ci.loop.registered sgp.dummy run data get storage sgp:data markers_lists.location
assert score #ci.loop.registered sgp.dummy matches 10
assert data storage sgp:data markers_lists.location[9].data{lieu:"test_loop_10",width:100}
# Marker 5 vanishes after registration: the loop must skip it and still reach markers 6..10.
kill @e[tag=sgp.test.location_loop,tag=sgp.test.location_loop_5,type=marker]

# Stand in marker 9 (second shard round).
tp @s ~27.5 ~1 ~0.5
scoreboard players set @s sgp.ab.location 0
scoreboard players set @s sgp.ab.location_width 0
function sgp.world:lieu/tick
assert score @s sgp.ab.location matches 1
assert score @s sgp.ab.location_width matches 90
assert score @s sgp.lieu_test_loop_9 matches 2..
assert score @s sgp.lieu_test_loop_10 matches 0
assert score @s sgp.lieu_count matches 1

# Step into marker 10: leave 9, enter 10 (coordinates are relative to the test origin).
tp @s ~30.5 ~1 ~0.5
scoreboard players set @s sgp.ab.location 0
scoreboard players set @s sgp.ab.location_width 0
function sgp.world:lieu/tick
assert score @s sgp.ab.location matches 1
assert score @s sgp.ab.location_width matches 100
assert score @s sgp.lieu_test_loop_9 matches 1
assert score @s sgp.lieu_test_loop_10 matches 2..
assert score @s sgp.lieu_count matches 2

# Outside every box: only the leave pass fires.
tp @s ~30.5 ~1 ~5.5
scoreboard players set @s sgp.ab.location 0
scoreboard players set @s sgp.ab.location_width 0
function sgp.world:lieu/tick
assert score @s sgp.ab.location matches 0
assert score @s sgp.lieu_test_loop_10 matches 1

function sgp.ci:locations/cleanup_loop
