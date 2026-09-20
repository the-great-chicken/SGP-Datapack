#> sgp.kits:abilities/tnt/arm_fire_cooldown
#
# Executed as a player immediately after vanilla accepted TNT lingering-fire damage.

scoreboard players set @s sgp.tnt_fire_cd 10
tag @s add sgp.tnt_fire_cached
