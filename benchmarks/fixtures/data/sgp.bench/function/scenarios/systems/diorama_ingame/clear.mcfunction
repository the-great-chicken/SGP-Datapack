#> sgp.bench:scenarios/systems/diorama_ingame/clear
# `{first: int, last: int}`
# Remove every benchmark-owned Diorama entity, marker, block and storage entry (also the
# recovery path for an interrupted run).
scoreboard players set #diorama_enabled sgp.dummy 0
scoreboard players set #mannequins_swing_enabled sgp.dummy 0
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run function sgp.diorama:cleanup_player
execute as @e[tag=sgp.giant_mannequin_99002,type=mannequin] on passengers run kill @s
tp @e[tag=sgp.giant_mannequin_99002,type=mannequin] 0 -1000 0
kill @e[tag=sgp.giant_mannequin_99002,type=mannequin]
execute as @e[tag=sgp.small_mannequin_99002,type=mannequin] on passengers run kill @s
tp @e[tag=sgp.small_mannequin_99002,type=mannequin] 0 -1000 0
kill @e[tag=sgp.small_mannequin_99002,type=mannequin]
execute as @e[tag=sgp.bench.diorama_ig,name="playable_map_model",limit=1,type=marker] at @s run function sgp.diorama:spawn_entities/clear_volume with entity @s data
kill @e[tag=sgp.bench.diorama_ig_ui,type=interaction]
kill @e[tag=sgp.bench.diorama_ig_ui,type=text_display]
kill @e[tag=sgp.bench.diorama_ig,type=marker]
fill -4 120 -4 8 120 8 air
data remove storage sgp:data markers_lists.playable_map
data remove storage sgp:data markers_lists.playable_map_model
data remove storage sgp:data misc.diorama.spawn_interactions.id_99002
data remove storage sgp:data spawns[{id:99002}]
scoreboard players set #mannequin_update_time sgp.dummy 0
$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] remove sgp.inside_current_model
$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] remove sgp.around_current_model
$tag @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] remove sgp.around_model
