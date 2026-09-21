#> sgp.bench:scenarios/events/major_hide_and_seek/setup
# `{first: int, last: int, players: int}`
#
# Spawn markers for both roles inside the arena, then the production start (roles, teams,
# timers, 360 s experience timer, 60 s hiding countdown). Participants are then spread back
# over the actor grid; seekers keep their stun and hiders their invisibility.

function sgp.bench:scenarios/events/major_hide_and_seek/clear
summon marker 20.5 81 0.5 {CustomName:"spawn_seeker",Tags:["sgp.marker","sgp.bench.hns"]}
summon marker -20.5 81 0.5 {CustomName:"spawn_hider",Tags:["sgp.marker","sgp.bench.hns"]}
scoreboard players set #hide_and_seek_max_rounds sgp.dummy 1
scoreboard players set #rounds sgp.dummy 0
function sgp.majeurs:hide_and_seek/_start
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run function sgp.bench:scenarios/abilities/common/reset_actor_position
scoreboard players set #hns_stopped_ticks sgp.bench 0
