
#> sgp.bench:scenarios/abilities/fangs_rough/setup
# `{first: int, last: int, players: int, period: int}`

$function sgp.bench:scenarios/abilities/common/setup_drop {first:$(first),last:$(last),kit:"vindicateur"}
team add sgp.bench.fangs
team modify sgp.bench.fangs collisionRule never
$team join sgp.bench.fangs @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}]
$tp @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] 0.5 81 -24.5 0 0
execute positioned 0.5 81 -24.5 run function sgp.bench:terrain/vertical_stress_lane/build
