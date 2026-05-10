#> sgp.misc:diorama/tick_small
# `{uuid: playable_map marker uuid}`

$execute as $(uuid) at @s \
    run function sgp.misc:diorama/check_for_spawned_player with entity @s data
execute as @a[tag=sgp.has_small_mannequin] at @s run function sgp.misc:diorama/update_small_pos