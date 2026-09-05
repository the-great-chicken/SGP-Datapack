#> sgp.world:locations/exclusion
# @dummy
#
# Crossing an excluded area must not consume the discovery; it also leaves an already active location.

function sgp.world:lieu/initialization {lieu:"test_exclusion"}
scoreboard players set @s sgp.lieu_test_exclusion 0
scoreboard players set @s sgp.lieu_count 0
summon marker ~ ~ ~ {Tags:["sgp.test.location_exclusion"],data:{lieu:"test_exclusion",lieu_propre:"Test exclusion",couleur:"white",width:20,dx:6,dy:3,dz:4,exclusion_box:{x:0,y:0,z:0,dx:2,dy:3,dz:4}}}
tp @s ~1.5 ~1 ~1.5
function sgp.ci:locations/scan {tag:"sgp.test.location_exclusion"}
assert score @s sgp.lieu_count matches 0
assert score @s sgp.ab.location matches 0
function sgp.ci:locations/scan {tag:"sgp.test.location_exclusion"}
assert score @s sgp.lieu_count matches 0

tp @s ~4.5 ~1 ~1.5
function sgp.ci:locations/scan {tag:"sgp.test.location_exclusion"}
assert score @s sgp.lieu_count matches 1
assert score @s sgp.ab.location matches 1
assert score @s sgp.lieu_test_exclusion matches 2..
tp @s ~1.5 ~1 ~1.5
function sgp.ci:locations/scan {tag:"sgp.test.location_exclusion"}
assert score @s sgp.ab.location matches 0
assert score @s sgp.lieu_test_exclusion matches 1
tp @s ~4.5 ~1 ~1.5
function sgp.ci:locations/scan {tag:"sgp.test.location_exclusion"}
assert score @s sgp.lieu_count matches 1
assert score @s sgp.ab.location matches 1

kill @e[tag=sgp.test.location_exclusion,distance=..32,type=marker]
scoreboard objectives remove sgp.lieu_test_exclusion
