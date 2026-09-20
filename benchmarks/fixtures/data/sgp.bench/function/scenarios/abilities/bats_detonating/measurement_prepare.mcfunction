#> sgp.bench:scenarios/abilities/bats_detonating/measurement_prepare
# `{first: int, last: int, players: int, period: int}`

# Quiesce only this benchmark driver while warm-up bats finish their normal
# death lifecycle. Other composed workloads keep warming normally.
schedule clear sgp.kits:abilities/bats/check_for_explosion
kill @e[tag=sgp.bat_grenade]
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.clock -1000000
