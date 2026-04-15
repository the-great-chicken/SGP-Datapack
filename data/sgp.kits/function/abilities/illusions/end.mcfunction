#> sgp.kits:abilities/illusions/end

team leave @s
function #bs.link:as_children {run:"execute if entity @s[team=sgp.Illusion,type=mannequin] at @s run particle minecraft:reverse_portal ~ ~1 ~ 0.4 0.4 0.4 0 50"}
function #bs.link:as_children {run:"execute if entity @s[team=sgp.Illusion] run tp @s ~ ~-1000 ~"}
function #bs.link:as_children {run:"execute if entity @s[team=sgp.Illusion] run kill @s"}