#> sgp.bench:scenarios/ability_smoke_grenade/teardown
# `{first: int, last: int, players: int, period: int}`

kill @e[tag=sgp.smoke_grenade,type=snowball]
kill @e[tag=sgp.smoke_visual,type=item_display]
$scoreboard players reset @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.clock
