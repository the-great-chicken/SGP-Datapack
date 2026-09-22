#> sgp.bench:scenarios/abilities/assassinate/setup
# `{first: int, last: int, players: int}`

$function sgp.bench:scenarios/abilities/common/setup_kit {first:$(first),last:$(last),kit:"enderman"}

$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] at @s run function sgp.kits:abilities/assassinate/start
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.duration_ability 12000
