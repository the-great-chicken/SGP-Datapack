#> sgp.world:locations/registry_loop_exclusion
# @dummy
# @environment sgp.ci:locations/registry_loop_exclusion
#
# Through the registry loop, a marker with an exclusion_box takes the excluded scan: standing in
# the excluded part neither discovers nor counts the location, and stepping into it from the
# open part leaves the location.
data modify storage sgp.ci:locations previous_registry set value []
data modify storage sgp.ci:locations previous_registry set from storage sgp:data markers_lists.location
data remove storage sgp:data markers_lists.location
scoreboard players set @s sgp.lieu_count 0
function sgp.world:lieu/initialization {lieu:"test_loop_excluded"}
scoreboard players set @s sgp.lieu_test_loop_excluded 0
summon marker ~ ~ ~ {CustomName:"lieu",Tags:["sgp.marker","sgp.test.location_loop"],data:{lieu:"test_loop_excluded",lieu_propre:"Test loop excluded",couleur:"white",width:20,dx:6,dy:3,dz:4,exclusion_box:{x:0,y:0,z:0,dx:2,dy:3,dz:4}}}
execute as @e[tag=sgp.test.location_loop,type=marker] run function sgp.world:lieu/register
assert data storage sgp:data markers_lists.location[0].data.exclusion_box{dx:2}

tp @s ~1.5 ~1 ~1.5
scoreboard players set @s sgp.ab.location 0
function sgp.world:lieu/tick
assert score @s sgp.lieu_count matches 0
assert score @s sgp.ab.location matches 0

tp @s ~4.5 ~1 ~1.5
scoreboard players set @s sgp.ab.location 0
function sgp.world:lieu/tick
assert score @s sgp.lieu_count matches 1
assert score @s sgp.ab.location matches 1
assert score @s sgp.lieu_test_loop_excluded matches 2..

tp @s ~1.5 ~1 ~1.5
scoreboard players set @s sgp.ab.location 0
function sgp.world:lieu/tick
assert score @s sgp.ab.location matches 0
assert score @s sgp.lieu_test_loop_excluded matches 1

function sgp.ci:locations/cleanup_loop
