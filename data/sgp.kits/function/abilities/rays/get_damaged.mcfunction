#> sgp.kits:abilities/rays/get_damaged

damage @s 0.2 sgp.kits:ray by @p[tag=sgp.radiator]
execute at @s run particle lava ~ ~0.6 ~ 0 0 0 0 1
title @s times 0t 1t 5t
title @s title {"text":"\uE000", "font":"sgp.kits:flash_overlay", "shadow_color":0}