#> sgp.world:locations/overlap
# @dummy
#
# Overlapping locations count independently, and leaving one must preserve the other.

function sgp.world:lieu/initialization {lieu:"test_overlap_a"}
function sgp.world:lieu/initialization {lieu:"test_overlap_b"}
scoreboard players set @s sgp.lieu_test_overlap_a 0
scoreboard players set @s sgp.lieu_test_overlap_b 0
scoreboard players set @s sgp.lieu_count 0
summon marker ~ ~ ~ {Tags:["sgp.test.location_overlap"],data:{lieu:"test_overlap_a",lieu_propre:"Test overlap A",couleur:"white",width:20,dx:4,dy:3,dz:4}}
summon marker ~2 ~ ~ {Tags:["sgp.test.location_overlap"],data:{lieu:"test_overlap_b",lieu_propre:"Test overlap B",couleur:"white",width:30,dx:4,dy:3,dz:4}}
tp @s ~3.5 ~1 ~1.5
function sgp.ci:locations/scan {tag:"sgp.test.location_overlap"}
assert score @s sgp.lieu_count matches 2
assert score @s sgp.ab.location matches 2
assert score @s sgp.ab.location_width matches 50
assert score @s sgp.lieu_test_overlap_a matches 2..
assert score @s sgp.lieu_test_overlap_b matches 2..

tp @s ~1.5 ~1 ~1.5
function sgp.ci:locations/scan {tag:"sgp.test.location_overlap"}
assert score @s sgp.ab.location matches 1
assert score @s sgp.ab.location_width matches 20
assert score @s sgp.lieu_test_overlap_a matches 2..
assert score @s sgp.lieu_test_overlap_b matches 1
tp @s ~6.5 ~1 ~1.5
function sgp.ci:locations/scan {tag:"sgp.test.location_overlap"}
assert score @s sgp.ab.location matches 1
assert score @s sgp.ab.location_width matches 30
assert score @s sgp.lieu_test_overlap_a matches 1
assert score @s sgp.lieu_test_overlap_b matches 2..
assert score @s sgp.lieu_count matches 2

tp @s ~9.5 ~1 ~1.5
function sgp.ci:locations/scan {tag:"sgp.test.location_overlap"}
assert score @s sgp.ab.location matches 0
assert score @s sgp.ab.location_width matches 0
assert score @s sgp.lieu_test_overlap_a matches 1
assert score @s sgp.lieu_test_overlap_b matches 1

kill @e[tag=sgp.test.location_overlap,distance=..32,type=marker]
scoreboard objectives remove sgp.lieu_test_overlap_a
scoreboard objectives remove sgp.lieu_test_overlap_b
