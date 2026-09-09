#> sgp.ci:experience_timer/setup

function sgp.ci:players/cleanup
schedule clear sgp.misc:second
execute store success score #ci.xp.had_second sgp.dummy store result score #ci.xp.second sgp.dummy run scoreboard players get #second sgp.timer
execute store success score #ci.xp.had_active sgp.dummy store result score #ci.xp.active sgp.dummy run scoreboard players get #timed_events_active sgp.dummy
scoreboard players set #timed_events_active sgp.dummy 0
