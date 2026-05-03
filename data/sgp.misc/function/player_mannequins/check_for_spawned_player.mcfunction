#> sgp.misc:player_mannequins/check_for_spawned_player
# `{dx, dy, dz}`
#
# Executed at the corner of the playable map, check if there is any player who
# just spawned in the map

# Remove player mannequin if they somehow go out of bounds (like by disconnecting)
$execute as @a[tag=sgp.has_small_mannequin] unless entity @s[dx=$(dx),dy=$(dy),dz=$(dz)] \
    run function sgp.misc:player_mannequins/disappear {type:"small"}

# Detects if a player just entered bounds
$execute as @a[tag=sgp.in_game,tag=!sgp.has_small_mannequin,dx=$(dx),dy=$(dy),dz=$(dz)] \
    run function sgp.misc:player_mannequins/on_player_spawn with storage sgp:data markers_lists.playable_map_model[0]