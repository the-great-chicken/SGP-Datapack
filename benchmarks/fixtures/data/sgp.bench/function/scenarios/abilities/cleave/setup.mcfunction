
#> sgp.bench:scenarios/abilities/cleave/setup
# `{first: int, last: int, players: int, period: int}`
#
# Split the casters into two overlapping stacks four blocks apart. Every caster
# therefore runs the real 120-degree check and /damage path against roughly half
# of the benchmark actors on every activation. This intentionally overstates
# target density rather than benchmarking an empty cone.

$function sgp.bench:scenarios/abilities/common/setup_drop {first:$(first),last:$(last),kit:"combattant"}
team add sgp.bench.cleave
team modify sgp.bench.cleave collisionRule never
$team join sgp.bench.cleave @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}]
scoreboard players set #bench_two sgp.bench 2
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run scoreboard players operation @s sgp.bench.clock = @s sgp.bench
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run scoreboard players operation @s sgp.bench.clock %= #bench_two sgp.bench
$tp @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.clock=0}] 18.5 81 -30.5 0 0
$tp @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.clock=1}] 18.5 81 -26.5 180 0
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run attribute @s minecraft:knockback_resistance modifier add sgp.bench:stabilize 1 add_value
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.clock 0
