#> sgp.spawns:enable_triggers
#
# Enable the spawn triggers for the player

tag @s add sgp.enable_spawn_triggers
execute as @e[type=marker,tag=sgp.marker,name="spawn"] run function sgp.spawns:enable_spawn_trigger with entity @s data
tag @s remove sgp.enable_spawn_triggers
scoreboard players enable @s sgp.spawn_random
scoreboard players enable @s sgp.spawn_vers_kits