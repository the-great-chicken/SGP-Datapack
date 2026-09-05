#> sgp.world:locations/exclusion_isolation
# @dummy
#
# An exclusion belongs to its own marker and must not leak into the next location scanned.

function sgp.world:lieu/initialization {lieu:"test_blocked"}
function sgp.world:lieu/initialization {lieu:"test_open"}
scoreboard players set @s sgp.lieu_test_blocked 0
scoreboard players set @s sgp.lieu_test_open 0
scoreboard players set @s sgp.lieu_count 0
summon marker ~ ~ ~ {Tags:["sgp.test.location_blocked"],data:{lieu:"test_blocked",lieu_propre:"Test blocked",couleur:"white",width:20,dx:4,dy:3,dz:4,exclusion_box:{x:0,y:0,z:0,dx:4,dy:3,dz:4}}}
summon marker ~ ~ ~ {Tags:["sgp.test.location_open"],data:{lieu:"test_open",lieu_propre:"Test open",couleur:"white",width:20,dx:4,dy:3,dz:4}}
tp @s ~1.5 ~1 ~1.5
function sgp.ci:locations/scan {tag:"sgp.test.location_blocked"}
assert score @s sgp.ab.location matches 0
function sgp.ci:locations/scan {tag:"sgp.test.location_open"}
assert score @s sgp.ab.location matches 1
assert score @s sgp.lieu_count matches 1
assert score @s sgp.lieu_test_open matches 2..
function sgp.ci:locations/scan {tag:"sgp.test.location_blocked"}
assert score @s sgp.ab.location matches 0
assert score @s sgp.lieu_count matches 1

kill @e[tag=sgp.test.location_blocked,distance=..32,type=marker]
kill @e[tag=sgp.test.location_open,distance=..32,type=marker]
scoreboard objectives remove sgp.lieu_test_blocked
scoreboard objectives remove sgp.lieu_test_open
