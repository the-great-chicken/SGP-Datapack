
#> sgp.bench:scenarios/abilities/cooldown/setup
# `{first: int, last: int, players: int, period: int}`

$function sgp.bench:scenarios/abilities/common/setup_drop {first:$(first),last:$(last),kit:"combattant"}
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.cooldown_ability 12000
