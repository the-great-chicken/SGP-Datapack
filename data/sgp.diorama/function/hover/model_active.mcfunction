#> sgp.diorama:hover/model_active
# `{id: int}`
# Executed as and at a playable_map_model marker.

tag @s add sgp.hover_model_active

$execute unless data storage sgp:data misc.diorama.spawn_interactions.id_$(id)[1] run return run function sgp.diorama:hover/loop/check/init {list_location:"misc.diorama.spawn_interactions.id_$(id)"}

# PlayerPredicate's looking_at check raycasts before testing the looked-at entity predicate.
# With several buttons, doing the exact check per button repeats that raycast for the same players.
# First keep only players whose one raycast hits any interaction; the exact per-button predicate remains below.
tag @a[tag=sgp.hover_viewer] remove sgp.hover_viewer
tag @a[tag=sgp.around_current_model,gamemode=!spectator,predicate=sgp.diorama:looking_at_interaction] add sgp.hover_viewer

# If nobody is looking at a spawn interaction, no exact per-button check can succeed.
# Decay the existing hover grace in bulk instead of walking every UUID.
execute unless entity @a[tag=sgp.hover_viewer,limit=1] run return run function sgp.diorama:hover/no_viewers with entity @s data

# Spawn UUIDs are cached during creation, avoiding a recurring @e scan.
$function sgp.diorama:hover/loop/check_filtered/init {list_location:"misc.diorama.spawn_interactions.id_$(id)"}

tag @a[tag=sgp.hover_viewer] remove sgp.hover_viewer
