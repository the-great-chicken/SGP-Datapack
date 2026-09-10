#> sgp.ci:locations/cleanup
# Failure-safe cleanup for location tests. Successful tests remove these themselves.
# A remaining marker proves its matching objective was initialized before the assertion failed.

execute if entity @e[tag=sgp.test.location_visit,type=marker] run scoreboard objectives remove sgp.lieu_test_visit
execute if entity @e[tag=sgp.test.location_exclusion,type=marker] run scoreboard objectives remove sgp.lieu_test_exclusion
execute if entity @e[tag=sgp.test.location_blocked,type=marker] run scoreboard objectives remove sgp.lieu_test_blocked
execute if entity @e[tag=sgp.test.location_open,type=marker] run scoreboard objectives remove sgp.lieu_test_open
execute if entity @e[tag=sgp.test.location_overlap,type=marker] run scoreboard objectives remove sgp.lieu_test_overlap_a
execute if entity @e[tag=sgp.test.location_overlap,type=marker] run scoreboard objectives remove sgp.lieu_test_overlap_b
execute if entity @e[tag=sgp.test.location_bounds,type=marker] run scoreboard objectives remove sgp.lieu_test_bounds
# player_isolation removes its marker before asserting, but keeps this scratch object until success.
execute if data storage sgp:data tests.location_players run scoreboard objectives remove sgp.lieu_test_players

kill @e[tag=sgp.test.location_visit,type=marker]
kill @e[tag=sgp.test.location_exclusion,type=marker]
kill @e[tag=sgp.test.location_blocked,type=marker]
kill @e[tag=sgp.test.location_open,type=marker]
kill @e[tag=sgp.test.location_overlap,type=marker]
kill @e[tag=sgp.test.location_bounds,type=marker]
kill @e[tag=sgp.test.location_players,type=marker]
data remove storage sgp:data tests.location_players
function sgp.ci:players/cleanup
