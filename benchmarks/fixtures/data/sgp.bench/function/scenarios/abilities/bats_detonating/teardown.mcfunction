
#> sgp.bench:scenarios/abilities/bats_detonating/teardown
# `{first: int, last: int, players: int, period: int}`

schedule clear sgp.kits:abilities/bats/check_for_explosion
$function sgp.bench:scenarios/abilities/common/teardown {first:$(first),last:$(last)}
kill @e[tag=sgp.bat_grenade]
kill @e[tag=sgp.bench.bat_target,type=mannequin]
$effect clear @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] minecraft:invisibility
$effect clear @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] minecraft:weakness
