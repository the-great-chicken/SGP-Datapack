#> sgp.world:locations/player_isolation
# @dummy
#
# One player's discovery or departure must not change another player's location state.

function sgp.world:lieu/initialization {lieu:"test_players"}
data modify storage sgp:data tests.location_players set value {}
scoreboard players set @s sgp.lieu_test_players 0
scoreboard players set @s sgp.lieu_count 0
summon marker ~ ~ ~ {Tags:["sgp.test.location_players"],data:{lieu:"test_players",lieu_propre:"Test players",couleur:"white",width:20,dx:4,dy:3,dz:4}}
dummy LocationOther spawn
scoreboard players set LocationOther sgp.lieu_test_players 0
scoreboard players set LocationOther sgp.lieu_count 0
scoreboard players set LocationOther sgp.ab.location 0
scoreboard players set LocationOther sgp.ab.location_width 0
tp @s ~1.5 ~1 ~1.5
tp LocationOther ~8.5 ~1 ~1.5
function sgp.ci:locations/scan {tag:"sgp.test.location_players"}
execute store result storage sgp:data tests.location_players.first_found int 1 run scoreboard players get @s sgp.lieu_count
execute store result storage sgp:data tests.location_players.first_inside int 1 run scoreboard players get @s sgp.ab.location
execute store result storage sgp:data tests.location_players.other_found_before int 1 run scoreboard players get LocationOther sgp.lieu_count
execute store result storage sgp:data tests.location_players.other_inside_before int 1 run scoreboard players get LocationOther sgp.ab.location

tp @s ~8.5 ~1 ~1.5
tp LocationOther ~1.5 ~1 ~1.5
function sgp.ci:locations/scan {tag:"sgp.test.location_players"}
execute store result storage sgp:data tests.location_players.other_found_after int 1 run scoreboard players get LocationOther sgp.lieu_count
execute store result storage sgp:data tests.location_players.other_inside_after int 1 run scoreboard players get LocationOther sgp.ab.location
dummy LocationOther leave
kill @e[tag=sgp.test.location_players,distance=..32,type=marker]

assert data storage sgp:data tests.location_players{first_found:1,first_inside:1,other_found_before:0,other_inside_before:0,other_found_after:1,other_inside_after:1}
assert score @s sgp.ab.location matches 0
assert score @s sgp.lieu_count matches 1
assert score @s sgp.lieu_test_players matches 1

scoreboard objectives remove sgp.lieu_test_players
data remove storage sgp:data tests.location_players
