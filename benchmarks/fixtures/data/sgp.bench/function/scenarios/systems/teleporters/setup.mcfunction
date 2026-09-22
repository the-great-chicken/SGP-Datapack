#> sgp.bench:scenarios/systems/teleporters/setup
# `{first: int, last: int, players: int, markers: int, standing: int}`
#
# Register `markers` production-shaped `teleporter` markers through the same path as
# sgp.world:initialization, so minecraft:execute_repeating_functions drives them with
# the real per-tick loop. Pads 1..standing sit on the bedrock floor east of the actor
# grid (x 28.5, z -12.5 + 7(i-1)) under actors 1..standing, and teleport to themselves,
# so those actors cycle through the whole countdown; the other pads sit on an 8x8
# lattice at y 96 inside the forceloaded arena, containing nobody.

# Recover cleanly from an interrupted run before touching the production registry.
function sgp.bench:scenarios/systems/teleporters/clear

$scoreboard players set #teleporters_markers sgp.bench $(markers)
$scoreboard players set #teleporters_standing sgp.bench $(standing)
scoreboard players set #teleporters_index sgp.bench 0
scoreboard players set #teleporters_seven sgp.bench 7
scoreboard players set #teleporters_cols sgp.bench 8
scoreboard players set #teleporters_step sgp.bench 8

# Summon every marker.
function sgp.bench:scenarios/systems/teleporters/spawn_loop

# Production registration (sgp.world:initialization), byte for byte.
data remove storage sgp:data markers_lists.teleporter
execute as @e[tag=sgp.marker,name="teleporter",type=marker] \
    run function sgp.misc:uuid_array_to_string/init {list_location:"sgp:data markers_lists.teleporter"}

# Actors first..first+standing-1 step onto their pads (integer coordinates centre x/z like the summon).
scoreboard players set #teleporters_actor sgp.bench 0
$scoreboard players set #teleporters_first sgp.bench $(first)
function sgp.bench:scenarios/systems/teleporters/place_standing
