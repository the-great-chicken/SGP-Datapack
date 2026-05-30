#> sgp.misc:diorama/disappear
# `{type: giant|small, id: int}`
#
# Executed on player's death or leaving diorama

$tag @s remove sgp.has_$(type)_mannequin_$(id)
scoreboard players operation $link.to bs.in = @s bs.id

$function sgp.misc:diorama/kill_linked_mannequins {type:$(type), id:$(id)}