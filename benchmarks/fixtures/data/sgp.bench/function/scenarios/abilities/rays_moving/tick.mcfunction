#> sgp.bench:scenarios/abilities/rays_moving/tick
# `{first: int, last: int, players: int}`
# Walk every actor 0.2 blocks forward; turn all of them around every 20 ticks so cells stay isolated.
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] at @s run tp @s ^ ^ ^0.2 ~ ~
scoreboard players add #rays_moving_phase sgp.bench 1
$execute if score #rays_moving_phase sgp.bench matches 20.. as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] at @s run rotate @s ~180 ~
execute if score #rays_moving_phase sgp.bench matches 20.. run scoreboard players set #rays_moving_phase sgp.bench 0
$scoreboard players add #rays_moving_player_ticks sgp.bench $(players)
