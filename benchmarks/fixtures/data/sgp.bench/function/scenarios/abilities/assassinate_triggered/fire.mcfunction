
#> sgp.bench:scenarios/abilities/assassinate_triggered/fire
# `{first: int, last: int, players: int}`

$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] at @s run function sgp.kits:abilities/end_active
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.cooldown_ability 0
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] at @s run function sgp.kits:abilities/assassinate/start
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] at @s run damage @s 1 minecraft:generic by @n[tag=sgp.bench.assassin_attacker,distance=..6,type=husk]
$scoreboard players add #assassinate_triggers sgp.bench $(players)
scoreboard players add #assassinate_trigger_waves sgp.bench 1
$scoreboard players set @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] sgp.bench.clock 0
