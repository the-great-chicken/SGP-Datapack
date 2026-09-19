#> sgp.bench:scenarios/systems/diorama_giant/teardown
# `{first: int, last: int, players: int, buttons: 0..16}`

# Stop the global production tick before dismantling the marker/storage state it consumes.
scoreboard players set #diorama_enabled sgp.dummy 0

# Use production owner cleanup while the playable-map UUID list still exists.
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run function sgp.diorama:cleanup_player

# Clear production-created spawn buttons/labels from the model volume, then use
# benchmark ownership tags as a fallback for interrupted or partially-built UI.
execute as @e[tag=sgp.bench.diorama,name="playable_map_model",limit=1,type=marker] at @s run function sgp.diorama:spawn_entities/clear_volume with entity @s data
kill @e[tag=sgp.bench.diorama_ui,type=interaction]
kill @e[tag=sgp.bench.diorama_ui,type=text_display]

$team leave @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}]
team remove sgpbenchdio
$clear @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}]
$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] remove sgp.inside_current_model
$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] remove sgp.around_current_model
$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] remove sgp.around_model

kill @e[tag=sgp.bench.diorama,type=marker]
fill -4 120 -4 8 120 8 air
data remove storage sgp:data markers_lists.playable_map
data remove storage sgp:data markers_lists.playable_map_model
data remove storage sgp:data misc.diorama.spawn_interactions.id_99001
data remove storage sgp:data spawns[{id:99001}]
scoreboard players set #mannequin_update_time sgp.dummy 0
scoreboard players set #mannequins_swing_enabled sgp.dummy 0
