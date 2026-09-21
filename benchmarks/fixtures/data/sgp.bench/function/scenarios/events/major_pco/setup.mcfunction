#> sgp.bench:scenarios/events/major_pco/setup
# `{first: int, last: int, players: int}`
#
# One PCO location set named "bench": per team a 2x2x2 cage storage (red concrete floor,
# glass walls) and an uncage storage (open) under the arena at y 60, a cage arena on the
# floor near the hunting team's spawn, a spawn marker and a spawn-cage marker, all in the
# production marker shape (tests/fixtures/data/sgp.ci/function/pco/fixture.mcfunction).
# The event is started through sgp.majeurs:pco/_start exactly like the scheduler does.

function sgp.bench:scenarios/events/major_pco/clear
# ---- poule
fill -31 60 -31 -30 60 -30 red_concrete
fill -31 61 -31 -30 61 -30 glass
summon marker -31.5 60.5 -30.5 {CustomName:"pco_cage_storage",Tags:["sgp.marker","sgp.pco.location_marker","sgp.bench.pco"],data:{pco_location:"bench",cage:"poule",dx:1,dy:1,dz:1}}
fill -31 60 -27 -30 60 -26 red_concrete
fill -31 61 -27 -30 61 -26 air
summon marker -31.5 60.5 -26.5 {CustomName:"pco_uncage_storage",Tags:["sgp.marker","sgp.pco.location_marker","sgp.bench.pco"],data:{pco_location:"bench",cage:"poule",dx:1,dy:1,dz:1}}
summon marker 20 81 -8 {CustomName:"pco_poule_cage_arena",Tags:["sgp.marker","sgp.pco.location_marker","sgp.bench.pco"],data:{pco_location:"bench"}}
summon marker 21.5 82 -7.5 {CustomName:"pco_spawn_cage_Poule",Tags:["sgp.marker","sgp.pco.location_marker","sgp.bench.pco"],data:{pco_location:"bench"}}
summon marker -20.5 81 -10.5 {CustomName:"pco_poule_spawn",Tags:["sgp.marker","sgp.pco.location_marker","sgp.bench.pco"],data:{pco_location:"bench"}}
# ---- canard
fill -27 60 -31 -26 60 -30 red_concrete
fill -27 61 -31 -26 61 -30 glass
summon marker -27.5 60.5 -30.5 {CustomName:"pco_cage_storage",Tags:["sgp.marker","sgp.pco.location_marker","sgp.bench.pco"],data:{pco_location:"bench",cage:"canard",dx:1,dy:1,dz:1}}
fill -27 60 -27 -26 60 -26 red_concrete
fill -27 61 -27 -26 61 -26 air
summon marker -27.5 60.5 -26.5 {CustomName:"pco_uncage_storage",Tags:["sgp.marker","sgp.pco.location_marker","sgp.bench.pco"],data:{pco_location:"bench",cage:"canard",dx:1,dy:1,dz:1}}
summon marker -20 81 -19 {CustomName:"pco_canard_cage_arena",Tags:["sgp.marker","sgp.pco.location_marker","sgp.bench.pco"],data:{pco_location:"bench"}}
summon marker -19.5 82 -18.5 {CustomName:"pco_spawn_cage_Canard",Tags:["sgp.marker","sgp.pco.location_marker","sgp.bench.pco"],data:{pco_location:"bench"}}
summon marker -20.5 81 10.5 {CustomName:"pco_canard_spawn",Tags:["sgp.marker","sgp.pco.location_marker","sgp.bench.pco"],data:{pco_location:"bench"}}
# ---- oie
fill -23 60 -31 -22 60 -30 red_concrete
fill -23 61 -31 -22 61 -30 glass
summon marker -23.5 60.5 -30.5 {CustomName:"pco_cage_storage",Tags:["sgp.marker","sgp.pco.location_marker","sgp.bench.pco"],data:{pco_location:"bench",cage:"oie",dx:1,dy:1,dz:1}}
fill -23 60 -27 -22 60 -26 red_concrete
fill -23 61 -27 -22 61 -26 air
summon marker -23.5 60.5 -26.5 {CustomName:"pco_uncage_storage",Tags:["sgp.marker","sgp.pco.location_marker","sgp.bench.pco"],data:{pco_location:"bench",cage:"oie",dx:1,dy:1,dz:1}}
summon marker -20 81 18 {CustomName:"pco_oie_cage_arena",Tags:["sgp.marker","sgp.pco.location_marker","sgp.bench.pco"],data:{pco_location:"bench"}}
summon marker -19.5 82 19.5 {CustomName:"pco_spawn_cage_Oie",Tags:["sgp.marker","sgp.pco.location_marker","sgp.bench.pco"],data:{pco_location:"bench"}}
summon marker 20.5 81 0.5 {CustomName:"pco_oie_spawn",Tags:["sgp.marker","sgp.pco.location_marker","sgp.bench.pco"],data:{pco_location:"bench"}}
# Register the location and hold a single round (no 30 s re-schedule after a stop).
data modify storage sgp:data majeurs.pco.locations set value []
data remove storage sgp:data majeurs.pco.pinned_location
data remove storage sgp:data majeurs.pco.active_location
function sgp.majeurs:pco/locations/add {id:"bench"}
scoreboard players set #pco_max_rounds sgp.dummy 1
scoreboard players set #rounds sgp.dummy 0
scoreboard players set #pco_phase sgp.dummy 0
function sgp.majeurs:pco/_start

# _start stacked each team on its spawn marker; spread the participants back over the actor
# grid, and move the few standing within 3 blocks of the `respawn` marker (0 81 0), where
# pco/check_death would re-give the kit every tick.
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run function sgp.bench:scenarios/abilities/common/reset_actor_position
$execute positioned 0 81 0 as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)},distance=..3] at @s run tp @s ~ ~ ~5
scoreboard players set #pco_stopped_ticks sgp.bench 0
