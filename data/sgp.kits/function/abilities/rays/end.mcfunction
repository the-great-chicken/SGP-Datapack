#> sgp.kits:abilities/rays/end

tag @s remove sgp.is_radiating
title @a clear
title @a times 10t 70t 20t
function #bs.link:as_children {run:"kill @s[tag=sgp.ray]"}