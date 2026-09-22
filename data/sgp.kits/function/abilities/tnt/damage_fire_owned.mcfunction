#> sgp.kits:abilities/tnt/damage_fire_owned
#
# Executed as a non-owner fire target while sgp.current_damage_owner identifies the caster.
# /damage succeeds only when vanilla accepted the hit; cache only that case.

execute store success score @s sgp.tnt_fire_cd run damage @s 2 on_fire by @a[tag=sgp.current_damage_owner,limit=1]
execute if score @s sgp.tnt_fire_cd matches 1 run function sgp.kits:abilities/tnt/arm_fire_cooldown
