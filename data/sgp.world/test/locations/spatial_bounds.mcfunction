#> sgp.world:locations/spatial_bounds
# @dummy
#
# Bounds are relative to the marker, support negative extents, and reject players outside each axis.

function sgp.world:lieu/initialization {lieu:"test_bounds"}
scoreboard players set @s sgp.lieu_test_bounds 0
scoreboard players set @s sgp.lieu_count 0
summon marker ~6 ~ ~6 {Tags:["sgp.test.location_bounds"],data:{lieu:"test_bounds",lieu_propre:"Test bounds",couleur:"white",width:20,dx:-4,dy:3,dz:-4}}
tp @s ~1.5 ~1 ~3.5
function sgp.ci:locations/scan {tag:"sgp.test.location_bounds"}
assert score @s sgp.ab.location matches 0
assert score @s sgp.lieu_count matches 0
tp @s ~3.5 ~5 ~3.5
function sgp.ci:locations/scan {tag:"sgp.test.location_bounds"}
assert score @s sgp.ab.location matches 0
assert score @s sgp.lieu_count matches 0
tp @s ~3.5 ~1 ~1.5
function sgp.ci:locations/scan {tag:"sgp.test.location_bounds"}
assert score @s sgp.ab.location matches 0
assert score @s sgp.lieu_count matches 0

tp @s ~3.5 ~1 ~3.5
function sgp.ci:locations/scan {tag:"sgp.test.location_bounds"}
assert score @s sgp.ab.location matches 1
assert score @s sgp.lieu_count matches 1
assert score @s sgp.lieu_test_bounds matches 2..

kill @e[tag=sgp.test.location_bounds,distance=..32,type=marker]
scoreboard objectives remove sgp.lieu_test_bounds
