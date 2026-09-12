#> sgp.ci:diorama_lifecycle/small_update
# Run the production small-mannequin lifecycle check from the fixture playable-map marker.

execute as @n[tag=sgp.ci.lifecycle_map,type=marker] at @s run function sgp.diorama:tick/check_for_spawned_player with entity @s data
