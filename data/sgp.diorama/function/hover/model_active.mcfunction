#> sgp.diorama:hover/model_active
# `{id: int}`
# Executed as and at a playable_map_model marker.

tag @s add sgp.hover_model_active

# Spawn UUIDs are cached during creation, avoiding a recurring @e scan.
$function sgp.diorama:hover/loop/check/init {list_location:"misc.diorama.spawn_interactions.id_$(id)"}
