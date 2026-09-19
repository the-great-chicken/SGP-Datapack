
#> sgp.bench:scenarios/abilities/bats_detonating/tick
# `{first: int, last: int, players: int, period: int}`

# Keep every undetonated grenade bat beside a durable valid target. This is
# benchmark-only steering; the production target scan and detonation functions
# still decide and perform every explosion.
execute as @e[tag=sgp.bat_grenade,tag=!sgp.bat_detonated,type=bat] at @s run tp @s @n[tag=sgp.bench.bat_target,type=mannequin]
$scoreboard players add @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.clock 1
$execute if entity @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.clock=$(period)..}] run function sgp.bench:scenarios/abilities/bats_detonating/fire {first:$(first),last:$(last),players:$(players)}
