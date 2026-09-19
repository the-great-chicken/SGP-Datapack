
#> sgp.bench:scenarios/abilities/bats_detonating/setup
# `{first: int, last: int, players: int, period: int}`

$function sgp.bench:scenarios/abilities/common/setup_drop {first:$(first),last:$(last),kit:"cancer"}
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] at @s run summon mannequin ~ ~ ~ {Tags:["sgp.illusion","sgp.peaceful","sgp.bench.bat_target","sgp.bench.entity"],Invulnerable:1b,Health:1024.0f}
$function sgp.bench:scenarios/abilities/bats_detonating/fire {first:$(first),last:$(last),players:$(players)}
