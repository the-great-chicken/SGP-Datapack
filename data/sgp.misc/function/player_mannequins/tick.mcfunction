#> sgp.misc:player_mannequins/tick

execute as @e[tag=sgp.marker,name="playable_map",limit=1,type=marker] at @s \
    run function sgp.misc:player_mannequins/check_for_spawned_player with entity @s data

execute as @e[tag=sgp.marker,name="playable_map_model",limit=1,type=marker] at @s \
    run function sgp.misc:player_mannequins/check_for_giant_player with entity @s data

execute as @a[tag=sgp.has_small_mannequin] at @s run function sgp.misc:player_mannequins/update_small_pos
execute as @a[tag=sgp.has_giant_mannequin] at @s run function sgp.misc:player_mannequins/update_giant_pos