#> sgp.kits:abilities/rays/end

title @a clear
title @a times 10t 70t 20t
scoreboard players operation $link.to bs.in = @s bs.id
kill @e[tag=sgp.ray,predicate=bs.link:link_equal,type=item_display]
