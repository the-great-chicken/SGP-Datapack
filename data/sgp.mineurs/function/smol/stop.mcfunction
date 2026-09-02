#> sgp.mineurs:smol/stop

execute as @a[tag=sgp.in_game] \
    run attribute @s minecraft:scale modifier remove sgp.smol

schedule clear sgp.mineurs:smol/end
function sgp.mineurs:common/timed_event/stop {event:"smol"}
