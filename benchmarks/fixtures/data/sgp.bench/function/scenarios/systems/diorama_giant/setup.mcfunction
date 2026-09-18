#> sgp.bench:scenarios/systems/diorama_giant/setup
# `{first: int, last: int, players: int, buttons: 0..16}`
#
# Build one complete synthetic Diorama through the production initialization
# path. The playable map is 64x16x64 at (16,160,16); its 4x1x4 miniature is at
# (0,121,0). Keeping both volumes above the normal benchmark arena isolates this
# scenario from actors belonging to other composed workloads. Actors stand in the
# model's outer shell at (-2.5,121,-2.5), which is outside the model but inside the production 4-block shell used for giant
# mannequin ownership. A no-collision team prevents stacked fake players from
# drifting out of the shell during long profiles.

scoreboard players set #diorama_enabled sgp.dummy 0
scoreboard players set #mannequins_swing_enabled sgp.dummy 0

# Recover cleanly if a previous interrupted run left benchmark-owned Diorama state.
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run function sgp.diorama:cleanup_player
execute as @e[tag=sgp.giant_mannequin_99001,type=mannequin] on passengers run kill @s
tp @e[tag=sgp.giant_mannequin_99001,type=mannequin] 0 -1000 0
kill @e[tag=sgp.giant_mannequin_99001,type=mannequin]
execute as @e[tag=sgp.small_mannequin_99001,type=mannequin] on passengers run kill @s
tp @e[tag=sgp.small_mannequin_99001,type=mannequin] 0 -1000 0
kill @e[tag=sgp.small_mannequin_99001,type=mannequin]
kill @e[tag=sgp.bench.diorama,type=marker]
kill @e[tag=sgp.bench.diorama_ui,type=interaction]
kill @e[tag=sgp.bench.diorama_ui,type=text_display]
fill -4 120 -4 8 120 8 air
data remove storage sgp:data markers_lists.playable_map
data remove storage sgp:data markers_lists.playable_map_model
data remove storage sgp:data misc.diorama.spawn_interactions.id_99001

$function sgp.bench:scenarios/systems/diorama_giant/seed_buttons {buttons:$(buttons)}

fill -4 120 -4 8 120 8 minecraft:bedrock
summon marker 16 160 16 {Tags:["sgp.marker","sgp.bench.diorama"],CustomName:"playable_map",data:{id:99001,dx:64,dy:16,dz:64}}
summon marker 0 121 0 {Tags:["sgp.marker","sgp.bench.diorama"],CustomName:"playable_map_model",data:{id:99001}}
function sgp.diorama:init/markers

execute as @e[tag=sgp.bench.diorama,name="playable_map_model",limit=1,type=marker] at @s run function sgp.diorama:spawn_entities/clear_and_recreate with entity @s data
# Tag production-created UI only after creation so reset/teardown can recover it
# without depending on the UUID cache being intact.
execute positioned 0 121 0 run tag @e[tag=sgp.spawn_tper,distance=..8,type=interaction] add sgp.bench.diorama_ui
execute positioned 0 121 0 run tag @e[tag=sgp.spawn_tper_text,distance=..8,type=text_display] add sgp.bench.diorama_ui

team remove sgpbenchdio
team add sgpbenchdio
team modify sgpbenchdio collisionRule never
$team join sgpbenchdio @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}]
$tp @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] -2.5 121 -2.5 180 0
$item replace entity @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] weapon.mainhand with diamond_sword[enchantments={sharpness:3},custom_data={sgp_bench_diorama:1b}]
$item replace entity @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] weapon.offhand with shield[custom_data={sgp_bench_diorama:1b}]

# Avoid measuring reconnect repair during warmup; use the production initializer
# after the Diorama marker lists exist, then prime one complete production tick.
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run function sgp.diorama:player_initialization
scoreboard players set #mannequin_update_time sgp.dummy 0
scoreboard players set #diorama_enabled sgp.dummy 1
function sgp.diorama:tick/main
