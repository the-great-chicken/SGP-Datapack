#> sgp.spawns:disable_triggers
#
# Disable the spawn triggers for the player

tag @s add sgp.disable_spawn_triggers
execute as @e[type=marker,tag=sgp.marker,name="spawn"] run function sgp.spawns:disable_spawn_trigger with entity @s data
tag @s remove sgp.disable_spawn_triggers
trigger sgp.spawn_random set 0
trigger sgp.spawn_vers_kits set 0