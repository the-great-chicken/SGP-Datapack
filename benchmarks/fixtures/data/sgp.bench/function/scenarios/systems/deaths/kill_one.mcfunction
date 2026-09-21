#> sgp.bench:scenarios/systems/deaths/kill_one
# `{victim: int, killer: int}`: actor indexes (sgp.bench scores).
# A real player_attack death with an attacker, the shape the stats tests use, so kill
# attribution, elo and the cosmetics death advancement all fire.
$execute store success score #deaths_hit sgp.bench run damage @a[tag=sgp.bench.actor,scores={sgp.bench=$(victim)},limit=1] 1000 minecraft:player_attack by @a[tag=sgp.bench.actor,scores={sgp.bench=$(killer)},limit=1]
execute if score #deaths_hit sgp.bench matches 1 run scoreboard players add #deaths_kills sgp.bench 1
