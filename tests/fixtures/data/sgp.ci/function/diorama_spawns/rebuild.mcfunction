#> sgp.ci:diorama_spawns/rebuild
# Run the production spawn-UI rebuild from the fixture model marker.

assert entity @e[tag=sgp.ci.menu,type=marker]
execute as @n[tag=sgp.ci.menu,type=marker] at @s run function sgp.diorama:spawn_entities/clear_and_recreate with entity @s data
