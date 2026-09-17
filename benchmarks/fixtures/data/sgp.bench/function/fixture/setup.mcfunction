#> sgp.bench:fixture/setup
# Idempotent synthetic arena used by local benchmarks. It intentionally supplies only core markers.

forceload add -32 -32 32 32
gamerule minecraft:spawn_mobs false
gamerule minecraft:advance_weather false
gamerule minecraft:advance_time false
gamerule minecraft:random_tick_speed 0
gamerule minecraft:fire_spread_radius_around_player 0
gamerule minecraft:spawn_patrols false
gamerule minecraft:spawn_wandering_traders false
time set noon
weather clear
difficulty normal
setworldspawn 0 81 0
fill -32 80 -32 32 80 32 minecraft:bedrock

kill @e[tag=sgp.bench.fixture,type=marker]
summon marker 0 80 0 {CustomName:"pvp_arena",Tags:["sgp.marker","sgp.bench.fixture"],data:{radius:64}}
summon marker 0 81 0 {CustomName:"respawn",Tags:["sgp.marker","sgp.bench.fixture"]}
summon marker 0 70 0 {CustomName:"abilities_shulker",Tags:["sgp.marker","sgp.bench.fixture"]}
setblock 0 70 0 minecraft:magenta_shulker_box

data remove storage sgp:data markers_lists.pvp_arena
execute as @e[tag=sgp.bench.fixture,tag=sgp.marker,name="pvp_arena",limit=1,type=marker] run function sgp.misc:uuid_array_to_string/init {list_location:"sgp:data markers_lists.pvp_arena"}

# Keep optional systems out of baseline runs unless a scenario explicitly enables them.
scoreboard players set #diorama_enabled sgp.dummy 0
scoreboard players set #mannequins_swing_enabled sgp.dummy 0
scoreboard players set #events_mineurs_actifs sgp.dummy 0

scoreboard players set #fixture_ready sgp.bench 1
