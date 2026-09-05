#> sgp.mineurs:bounty/stop

effect clear @a[tag=sgp.wanted] minecraft:glowing
tag @a[tag=sgp.wanted] remove sgp.wanted
schedule clear sgp.mineurs:bounty/end
function sgp.mineurs:common/timed_event/stop {event:"bounty"}
