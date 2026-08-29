#> sgp.diorama:tick/check_for_spawned_player
# `{dx, dy, dz}`
#
# Executed at the corner of the playable map, check if there is any player who
# just spawned in the map

# Remove player mannequin if they somehow go out of bounds (like by disconnecting)
$execute as @a[tag=sgp.has_small_mannequin_$(id)] unless entity @s[dx=$(dx),dy=$(dy),dz=$(dz)] \
    run function sgp.diorama:tick/update_mannequin/disappear {type:"small", id:$(id)}


scoreboard players operation $id.suid bs.in = @s bs.link.to

# Detects if a player just entered bounds
$execute as @a[tag=sgp.in_game,tag=!sgp.has_small_mannequin_$(id),dx=$(dx),dy=$(dy),dz=$(dz)] \
    at @n[predicate=bs.id:suid_equal,tag=sgp.marker,name=playable_map_model,limit=1,type=marker] \
        run function sgp.diorama:tick/on_player_spawn {id:$(id)}