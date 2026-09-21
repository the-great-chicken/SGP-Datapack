#> sgp.bench:scenarios/events/minor_event/bounty/tick
# `{first, last, players, event}`
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)},tag=sgp.wanted] run scoreboard players add #minor_actions sgp.bench 1
