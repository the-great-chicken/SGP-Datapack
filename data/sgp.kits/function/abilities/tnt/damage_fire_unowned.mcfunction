#> sgp.kits:abilities/tnt/damage_fire_unowned
#
# Executed as a self-damage target, or any target whose fire owner is offline.
# /damage succeeds only when vanilla accepted the hit; cache only that case.

execute store success score @s sgp.tnt_fire_cd run damage @s 2 on_fire
execute if score @s sgp.tnt_fire_cd matches 1 run function sgp.kits:abilities/tnt/arm_fire_cooldown
