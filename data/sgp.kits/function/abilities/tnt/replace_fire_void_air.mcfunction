#> sgp.kits:abilities/tnt/replace_fire_void_air
#
# On each void fire tracker, if they are not on fire anymore, replace the air back with void air

execute as @e[type=marker,tag=sgp.void_fire_tracker] at @s unless block ~ ~ ~ minecraft:fire run setblock ~ ~ ~ minecraft:void_air
execute as @e[type=marker,tag=sgp.void_fire_tracker] at @s unless block ~ ~ ~ minecraft:fire run kill @s