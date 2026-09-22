#> sgp.bench:scenarios/systems/deaths/tick
# `{first: int, last: int, players: int, period: int, victims: int}`
#
# minecraft:execute_repeating_functions already processed last tick's deaths (sgp.just_died),
# so first respawn and re-equip the dead actors, then start the next kill wave when due.

$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last),sgp.bench.deaths=1..},tag=!sgp.bench.respawning] run function sgp.bench:scenarios/systems/deaths/respawn
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)},tag=sgp.bench.respawning] at @s run function sgp.bench:scenarios/systems/deaths/after_respawn

scoreboard players add #deaths_phase sgp.bench 1
execute if score #deaths_phase sgp.bench < #deaths_period sgp.bench run return 0
scoreboard players set #deaths_phase sgp.bench 0
scoreboard players add #deaths_waves sgp.bench 1
scoreboard players set #deaths_k sgp.bench 0
function sgp.bench:scenarios/systems/deaths/wave
scoreboard players operation #deaths_cursor sgp.bench += #deaths_victims sgp.bench
scoreboard players operation #deaths_cursor sgp.bench %= #deaths_players sgp.bench
