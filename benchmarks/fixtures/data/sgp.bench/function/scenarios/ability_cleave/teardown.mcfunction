#> sgp.bench:scenarios/ability_cleave/teardown
# `{first: int, last: int, players: int, period: int}`

$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run function sgp.kits:abilities/end_active
kill @e[tag=sgp.giant_sweep,type=item_display]
kill @e[tag=sgp.dropped,type=item]
$scoreboard players reset @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.clock
