#> sgp.diorama:hover/model
# `{id: int}`
# Executed as and at a playable_map_model marker.

# Only scan the model's spawn hitboxes while a player is around it.
execute if entity @a[tag=sgp.around_current_model,gamemode=!spectator,limit=1] \
    run return run function sgp.diorama:hover/model_active with entity @s data

# Do one cleanup pass after the last player leaves, then keep empty models idle.
execute unless entity @s[tag=sgp.hover_model_active] run return 0
$function sgp.diorama:hover/loop/shrink/init {list_location:"misc.diorama.spawn_interactions.id_$(id)"}
tag @s remove sgp.hover_model_active
