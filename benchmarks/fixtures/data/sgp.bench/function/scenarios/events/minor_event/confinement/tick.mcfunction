#> sgp.bench:scenarios/events/minor_event/confinement/tick
# `{first, last, players, event}`
scoreboard players operation #minor_mod sgp.bench = #minor_phase sgp.bench
scoreboard players operation #minor_mod sgp.bench %= #minor_c20 sgp.bench
$execute if score #minor_mod sgp.bench matches 0 run effect give @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] minecraft:instant_health 1 10 true
execute if score #confines_secondes sgp.timer matches 15.. run scoreboard players add #minor_actions sgp.bench 1
