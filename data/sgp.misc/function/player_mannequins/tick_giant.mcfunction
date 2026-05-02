#> sgp.misc:player_mannequins/tick_giant
# `{uuid: playable_map_model marker uuid}`

$execute as $(uuid) at @s \
    run function sgp.misc:player_mannequins/check_for_giant_player with entity @s data

execute as @a[tag=sgp.has_giant_mannequin] at @s run function sgp.misc:player_mannequins/update_giant_pos