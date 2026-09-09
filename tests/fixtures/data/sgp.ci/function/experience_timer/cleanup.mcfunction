#> sgp.ci:experience_timer/cleanup

schedule clear sgp.misc:second
function sgp.ci:players/cleanup
execute if score #ci.xp.had_second sgp.dummy matches 1 run scoreboard players operation #second sgp.timer = #ci.xp.second sgp.dummy
execute if score #ci.xp.had_second sgp.dummy matches 0 run scoreboard players reset #second sgp.timer
execute if score #ci.xp.had_active sgp.dummy matches 1 run scoreboard players operation #timed_events_active sgp.dummy = #ci.xp.active sgp.dummy
execute if score #ci.xp.had_active sgp.dummy matches 0 run scoreboard players reset #timed_events_active sgp.dummy
