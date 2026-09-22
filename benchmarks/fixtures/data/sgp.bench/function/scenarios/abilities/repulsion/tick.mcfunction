
#> sgp.bench:scenarios/abilities/repulsion/tick
# `{first: int, last: int, players: int, period: int}`

$scoreboard players add @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.clock 1
# The production displacement measurement is scheduled 10 ticks after the drop
# is processed. Reset after it has run so repeated stress casts do not drift the
# Archers out of the arena or change later geometry.
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.clock=12}] run function sgp.bench:scenarios/abilities/common/reset_actor_position
$execute if entity @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.clock=$(period)..}] run function sgp.bench:scenarios/abilities/repulsion/fire {first:$(first),last:$(last),players:$(players)}
