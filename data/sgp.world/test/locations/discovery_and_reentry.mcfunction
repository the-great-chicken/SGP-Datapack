#> sgp.world:locations/discovery_and_reentry
# @dummy
#
# Discover a location once, keep it active while inside, leave it, and revisit without another discovery.

function sgp.world:lieu/initialization {lieu:"test_visit"}
scoreboard players set @s sgp.lieu_test_visit 0
scoreboard players set @s sgp.lieu_count 0
summon marker ~ ~ ~ {Tags:["sgp.test.location_visit"],data:{lieu:"test_visit",lieu_propre:"Test visit",couleur:"white",width:20,dx:4,dy:3,dz:4}}
tp @s ~1.5 ~1 ~1.5
function sgp.ci:locations/scan {tag:"sgp.test.location_visit"}
assert score @s sgp.lieu_count matches 1
assert score @s sgp.ab.location matches 1
assert score @s sgp.lieu_test_visit matches 2..
function sgp.ci:locations/scan {tag:"sgp.test.location_visit"}
assert score @s sgp.lieu_count matches 1
assert score @s sgp.ab.location matches 1

tp @s ~8.5 ~1 ~1.5
function sgp.ci:locations/scan {tag:"sgp.test.location_visit"}
assert score @s sgp.ab.location matches 0
assert score @s sgp.lieu_test_visit matches 1
tp @s ~1.5 ~1 ~1.5
function sgp.ci:locations/scan {tag:"sgp.test.location_visit"}
assert score @s sgp.lieu_count matches 1
assert score @s sgp.ab.location matches 1
assert score @s sgp.lieu_test_visit matches 2..

kill @e[tag=sgp.test.location_visit,distance=..32,type=marker]
scoreboard objectives remove sgp.lieu_test_visit
