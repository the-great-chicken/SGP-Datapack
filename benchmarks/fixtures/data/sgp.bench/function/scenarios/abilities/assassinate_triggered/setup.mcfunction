
#> sgp.bench:scenarios/abilities/assassinate_triggered/setup
# `{first: int, last: int, players: int, period: int}`

$function sgp.bench:scenarios/abilities/common/setup_kit {first:$(first),last:$(last),kit:"enderman"}
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.clock 0
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] at @s run function sgp.bench:scenarios/abilities/assassinate_triggered/setup_attacker
