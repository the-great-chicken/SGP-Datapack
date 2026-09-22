#> sgp.bench:scenarios/abilities/rays/setup
# `{first: int, last: int, players: int}`

$function sgp.bench:scenarios/abilities/common/setup_kit {first:$(first),last:$(last),kit:"roi"}
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run attribute @s minecraft:gravity modifier add sgp.bench:rays_sparse_gravity -1 add_multiplied_total
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run function sgp.bench:scenarios/abilities/rays/position {first:$(first)}

$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] at @s run function sgp.kits:abilities/rays/start
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.duration_ability 12000
