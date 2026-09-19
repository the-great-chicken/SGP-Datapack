#> sgp.bench:scenarios/abilities/bats/setup
# `{first: int, last: int, players: int}`

$function sgp.bench:scenarios/abilities/common/setup_kit {first:$(first),last:$(last),kit:"cancer"}
data modify storage sgp.bench:runtime bats_duration set from storage sgp:data kits.ability_cooldowns.bats.duration
data modify storage sgp:data kits.ability_cooldowns.bats.duration set value 12000s
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] at @s run function sgp.kits:abilities/bats/start
data modify storage sgp:data kits.ability_cooldowns.bats.duration set from storage sgp.bench:runtime bats_duration
data remove storage sgp.bench:runtime bats_duration
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.duration_ability 12000
