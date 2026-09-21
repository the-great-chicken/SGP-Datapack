#> sgp.bench:scenarios/events/major_hide_and_seek/tick
# `{first: int, last: int, players: int}`
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)},team=sgp.hider] run scoreboard players add #hns_hider_ticks sgp.bench 1
$execute as @a[tag=sgp.bench.actor,scores={sgp.bench=$(first)..$(last)},team=sgp.seeker] run scoreboard players add #hns_seeker_ticks sgp.bench 1
execute unless entity @a[predicate=sgp.majeurs:hide_and_seek/ongoing] run scoreboard players add #hns_stopped_ticks sgp.bench 1
