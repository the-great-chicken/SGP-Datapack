
#> sgp.bench:scenarios/abilities/water_trident/teardown
# `{first: int, last: int, players: int, period: int}`

execute as @e[tag=sgp.marker,name="temp_water",type=marker] at @s run function sgp.kits:abilities/water_trident/reset_water
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run function sgp.bench:scenarios/abilities/common/reset_actor_position
$function sgp.bench:scenarios/abilities/common/teardown {first:$(first),last:$(last)}
