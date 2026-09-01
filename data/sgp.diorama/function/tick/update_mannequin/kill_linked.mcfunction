#> sgp.diorama:tick/update_mannequin/kill_linked
# `{type: giant|small, id: int}`

$execute as @e[predicate=bs.link:link_equal,tag=sgp.$(type)_mannequin_$(id),type=mannequin] on passengers run kill @s
$execute as @e[predicate=bs.link:link_equal,tag=sgp.$(type)_mannequin_$(id),type=mannequin] run tp @s ~ ~-1000 ~
$execute as @e[predicate=bs.link:link_equal,tag=sgp.$(type)_mannequin_$(id),type=mannequin] run kill @s