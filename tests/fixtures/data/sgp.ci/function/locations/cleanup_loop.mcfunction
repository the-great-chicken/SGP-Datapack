#> sgp.ci:locations/cleanup_loop
# Remove the registry-loop markers and objectives, then restore the registry snapshot.
execute as @e[tag=sgp.test.location_loop,type=marker] run function sgp.world:lieu/uninstallation with entity @s data
kill @e[tag=sgp.test.location_loop,type=marker]
scoreboard objectives remove sgp.lieu_test_loop_5
data remove storage sgp:data markers_lists.location
execute if data storage sgp.ci:locations previous_registry run data modify storage sgp:data markers_lists.location set from storage sgp.ci:locations previous_registry
data remove storage sgp.ci:locations previous_registry
