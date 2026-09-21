#> sgp.bench:scenarios/events/minor_event/confinement/setup
# `{first, last, players, event}`
# Skip straight to the damage phase (second 15 of 150); nobody stands under a roof, so all
# 14 block checks run for every player every second. Actors are healed by the tick.
$attribute @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)},limit=1] minecraft:max_health base set 1024
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)}] run attribute @s minecraft:max_health base set 1024
function sgp.mineurs:confinement/start
scoreboard players set #confines_secondes sgp.timer 14
