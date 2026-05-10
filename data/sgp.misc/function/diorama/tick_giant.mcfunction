#> sgp.misc:diorama/tick_giant
# `{uuid: playable_map_model marker uuid}`

$execute as $(uuid) at @s \
    run function sgp.misc:diorama/check_for_giant_player with entity @s data

execute as @a[tag=sgp.has_giant_mannequin] at @s run function sgp.misc:diorama/update_giant_pos