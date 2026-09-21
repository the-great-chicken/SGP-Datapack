#> sgp.bench:scenarios/systems/locations/setup
# `{first: int, last: int, players: int, markers: int, occupied: int, exclusions: int, period: int}`
#
# Register `markers` production-shaped `lieu` markers through the same path as
# sgp.world:initialization, so minecraft:execute_repeating_functions drives them
# with the real per-tick loop. The first `occupied` markers are flat slabs over
# rows of the benchmark actor grid (y 81..83); the rest sit on an 8x8 lattice at
# y 96, inside the forceloaded arena but containing nobody, which is what most
# of a real map's locations look like at any instant.

# Recover cleanly from an interrupted run before touching the production registry.
function sgp.bench:scenarios/systems/locations/clear

$scoreboard players set #locations_markers sgp.bench $(markers)
$scoreboard players set #locations_occupied sgp.bench $(occupied)
$scoreboard players set #locations_exclusions sgp.bench $(exclusions)
$scoreboard players set #locations_period sgp.bench $(period)
scoreboard players set #locations_index sgp.bench 0
scoreboard players set #locations_phase sgp.bench 0
scoreboard players set #locations_outside sgp.bench 0
scoreboard players set #locations_two sgp.bench 2
scoreboard players set #locations_four sgp.bench 4
scoreboard players set #locations_rows sgp.bench 5
scoreboard players set #locations_cols sgp.bench 8
scoreboard players set #locations_pitch sgp.bench 7
scoreboard players set #locations_step sgp.bench 8

# Summon every marker and create its sgp.lieu_<name> objective.
function sgp.bench:scenarios/systems/locations/spawn_loop

# Production registration (sgp.world:initialization), byte for byte.
data remove storage sgp:data markers_lists.location
execute as @e[tag=sgp.marker,name="lieu",type=marker] run function sgp.world:lieu/register

# Production per-player bootstrap (sgp.misc:scoreboards/player_initialization, lieu part):
# without a sgp.lieu_<name> row a player is invisible to lieu/main.
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] \
    run function sgp.bench:scenarios/systems/locations/init_actor

# minecraft:128_ticks_functions recomputes this too; do it now so discovery is correct from the first tick.
execute store result score #nbr_lieu sgp.lieu_count if entity @e[type=marker,tag=sgp.marker,name="lieu"]

# The crossing group (every 4th actor) shares one destination; disable collisions so teleports stay deterministic.
team add sgp.bench.locations
team modify sgp.bench.locations collisionRule never
$team join sgp.bench.locations @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}]
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run scoreboard players operation @s sgp.bench.clock = @s sgp.bench
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run scoreboard players operation @s sgp.bench.clock %= #locations_four sgp.bench
