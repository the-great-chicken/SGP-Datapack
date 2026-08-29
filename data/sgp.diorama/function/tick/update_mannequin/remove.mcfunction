#> sgp.diorama:tick/update_mannequin/remove
# `{id: int}`
#
# Completely reset player's mannequin status

$tag @a[tag=sgp.diorama_death_cleanup] remove sgp.has_small_mannequin_$(id)
$tag @a[tag=sgp.diorama_death_cleanup] remove sgp.has_giant_mannequin_$(id)

$function sgp.diorama:tick/update_mannequin/kill_linked {type:"small", id:$(id)}
$function sgp.diorama:tick/update_mannequin/kill_linked {type:"giant", id:$(id)}