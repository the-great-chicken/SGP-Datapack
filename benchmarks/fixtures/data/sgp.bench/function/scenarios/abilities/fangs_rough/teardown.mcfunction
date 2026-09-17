
#> sgp.bench:scenarios/abilities/fangs_rough/teardown
# `{first: int, last: int, players: int, period: int}`

kill @e[type=evoker_fangs]
kill @e[tag=sgp.dropped,type=item]
execute positioned 0.5 81 -24.5 run function sgp.bench:terrain/vertical_stress_lane/clear
$team leave @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}]
team remove sgp.bench.fangs
$function sgp.bench:scenarios/abilities/common/teardown {first:$(first),last:$(last)}
