#> sgp.misc:player_mannequins/tick

execute as @e[tag=sgp.marker,name="playable_map",limit=1,type=marker] at @s \
    run function sgp.misc:player_mannequins/check_for_spawned_player with entity @s data

execute as @a[tag=sgp.has_mannequin] at @s run function sgp.misc:player_mannequins/update_pos