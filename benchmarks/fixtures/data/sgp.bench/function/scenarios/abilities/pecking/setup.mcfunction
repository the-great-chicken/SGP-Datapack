
#> sgp.bench:scenarios/abilities/pecking/setup
# `{first: int, last: int, players: int}`
#
# Two 4.8-block-separated stacks make acquisition succeed near the far edge of
# Pecking's thick ray, after almost all sphere checks have been attempted.

$function sgp.bench:scenarios/abilities/common/setup_kit {first:$(first),last:$(last),kit:"pigeon"}
team add sgp.bench.peck
team modify sgp.bench.peck collisionRule never
$team join sgp.bench.peck @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}]
scoreboard players set #bench_two sgp.bench 2
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run scoreboard players operation @s sgp.bench.clock = @s sgp.bench
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run scoreboard players operation @s sgp.bench.clock %= #bench_two sgp.bench
$tp @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.clock=0}] -18.5 81 24 0 0
$tp @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.clock=1}] -18.5 81 28.8 180 0
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run attribute @s minecraft:knockback_resistance modifier add sgp.bench:stabilize 1 add_value
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] at @s anchored eyes run function sgp.kits:abilities/pecking/start
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.duration_ability 12000
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.clock 0
