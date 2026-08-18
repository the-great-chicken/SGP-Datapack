#> sgp.diorama:tick/update_mannequin/disappear
# `{type: giant|small, id: int}`
#
# Executed on player's death or leaving diorama

$tag @s remove sgp.has_$(type)_mannequin_$(id)
scoreboard players operation $link.to bs.in = @s bs.id

$function sgp.diorama:tick/update_mannequin/kill_linked {type:$(type), id:$(id)}