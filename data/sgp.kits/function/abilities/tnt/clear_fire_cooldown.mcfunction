#> sgp.kits:abilities/tnt/clear_fire_cooldown
#
# Executed as a player when vanilla's hurt-cooldown state may have been replaced.

scoreboard players set @s sgp.tnt_fire_cd 0
tag @s remove sgp.tnt_fire_cached
