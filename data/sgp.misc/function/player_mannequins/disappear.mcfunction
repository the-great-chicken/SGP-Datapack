#> sgp.misc:player_mannequins/disappear
# `{type: giant|small}`
#
# Executed on player's death or leaving diorama

$tag @s remove sgp.has_$(type)_mannequin
$function #bs.link:as_children {run:"execute if entity @s[tag=sgp.$(type)_mannequin,type=mannequin] on passengers run kill @s"}
$function #bs.link:as_children {run:"execute if entity @s[tag=sgp.$(type)_mannequin,type=mannequin] run tp @s ~ ~-1000 ~"}
$function #bs.link:as_children {run:"execute if entity @s[tag=sgp.$(type)_mannequin,type=mannequin] run kill @s"}