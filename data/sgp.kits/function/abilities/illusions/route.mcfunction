#> sgp.kits:abilities/illusions/route

# This changes executor to the Mannequin, but keeps the position safely at the Marker!

function #bs.link:as_children {run:"execute if entity @s[tag=sgp.direction_left] run function sgp.kits:abilities/illusions/apply_left"}
function #bs.link:as_children {run:"execute if entity @s[tag=sgp.direction_opposite] run function sgp.kits:abilities/illusions/apply_opposite"}
function #bs.link:as_children {run:"execute if entity @s[tag=sgp.direction_right] run function sgp.kits:abilities/illusions/apply_right"}