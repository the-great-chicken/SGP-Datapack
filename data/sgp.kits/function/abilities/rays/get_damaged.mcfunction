#> sgp.kits:abilities/rays/get_damaged

# /damage succeeds exactly when vanilla's hurt path ran, i.e. when the former entity_hurt_player
# advancement fired, so the ray death-cause callback is called directly instead of granting and
# revoking an advancement on every hit.
execute store success score #ray_hit sgp.dummy run damage @s 0.25 sgp.kits:ray by @a[tag=sgp.radiator,limit=1]
execute if score #ray_hit sgp.dummy matches 1 run function sgp.kits:stats_collector/death_cause/ray
particle lava ~ ~0.6 ~ 0 0 0 0 1
title @s times 0t 1t 5t
title @s title {"text":"\uE000", "font":"sgp.kits:flash_overlay", "shadow_color":0}