
#> sgp.bench:scenarios/abilities/water_trident/fire
# `{first: int, last: int, players: int}`
#
# The benchmark does not emulate Riptide physics. Actors instead leave their
# water between casts; the production water_trident/tick function performs the
# actual Riptide removal and temporary-water cleanup.

$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.cooldown_ability 0
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] at @s run function sgp.kits:abilities/water_trident/use
$scoreboard players add #water_trident_use_inputs sgp.bench $(players)
scoreboard players add #water_trident_waves sgp.bench 1
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.clock 0
