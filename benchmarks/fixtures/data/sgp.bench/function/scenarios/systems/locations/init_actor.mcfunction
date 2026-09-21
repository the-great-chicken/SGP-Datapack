#> sgp.bench:scenarios/systems/locations/init_actor
# Executed as one actor: the `lieu` part of sgp.misc:scoreboards/player_initialization.
tag @s add sgp.initialize_lieux
scoreboard players add @a[tag=sgp.initialize_lieux,limit=1] sgp.lieu_count 0
execute as @e[type=marker,tag=sgp.marker,name="lieu"] run function sgp.world:lieu/player_initialization with entity @s data
tag @s remove sgp.initialize_lieux
