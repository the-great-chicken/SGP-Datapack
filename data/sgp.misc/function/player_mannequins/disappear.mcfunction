#> sgp.misc:player_mannequins/disappear
#
# Executed on player's death

tag @s remove sgp.has_mannequin
function #bs.link:as_children {run:"execute if entity @s[tag=sgp.small_mannequin,type=mannequin] on passengers run kill @s"}
function #bs.link:as_children {run:"execute if entity @s[tag=sgp.small_mannequin,type=mannequin] run tp @s ~ ~-1000 ~"}
function #bs.link:as_children {run:"execute if entity @s[tag=sgp.small_mannequin,type=mannequin] run kill @s"}