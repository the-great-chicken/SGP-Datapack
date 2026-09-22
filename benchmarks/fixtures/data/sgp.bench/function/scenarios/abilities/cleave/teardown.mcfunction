
#> sgp.bench:scenarios/abilities/cleave/teardown
# `{first: int, last: int, players: int, period: int}`

kill @e[tag=sgp.giant_sweep,type=item_display]
kill @e[tag=sgp.dropped,type=item]
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run attribute @s minecraft:knockback_resistance modifier remove sgp.bench:stabilize
$team leave @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}]
team remove sgp.bench.cleave
$function sgp.bench:scenarios/abilities/common/teardown {first:$(first),last:$(last)}
