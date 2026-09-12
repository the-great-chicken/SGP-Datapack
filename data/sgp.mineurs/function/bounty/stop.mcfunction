#> sgp.mineurs:bounty/stop

effect clear @a[tag=sgp.wanted] minecraft:glowing
scoreboard players reset @a[tag=sgp.wanted] sgp.bounty_gen
tag @a[tag=sgp.wanted] remove sgp.wanted
schedule clear sgp.mineurs:bounty/end
function sgp.mineurs:common/timed_event/stop {event:"bounty"}
