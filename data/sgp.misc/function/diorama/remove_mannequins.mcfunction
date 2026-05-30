#> sgp.misc:diorama/remove_mannequin_tags
# `{id: int}`

$tag @a[tag=sgp.diorama_death_cleanup] remove sgp.has_small_mannequin_$(id)
$tag @a[tag=sgp.diorama_death_cleanup] remove sgp.has_giant_mannequin_$(id)

$function sgp.misc:diorama/kill_linked_mannequins {type:"small", id:$(id)}
$function sgp.misc:diorama/kill_linked_mannequins {type:"giant", id:$(id)}