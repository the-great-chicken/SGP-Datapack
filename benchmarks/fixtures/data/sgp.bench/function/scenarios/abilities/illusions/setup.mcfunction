#> sgp.bench:scenarios/abilities/illusions/setup
# `{first: int, last: int, players: int}`

$function sgp.bench:scenarios/abilities/common/setup_kit {first:$(first),last:$(last),kit:"alchimiste"}

$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] at @s run function sgp.kits:abilities/illusions/start
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.duration_ability 12000
