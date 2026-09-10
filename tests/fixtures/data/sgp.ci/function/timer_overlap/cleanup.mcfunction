#> sgp.ci:timer_overlap/cleanup
# Clear shared timing work, disconnect players, and restore every global timer score exactly as setup found it.

schedule clear sgp.misc:second
function sgp.ci:players/cleanup
execute if score #ci.overlap.had0 sgp.dummy matches 1 run scoreboard players operation #timed_events_active sgp.dummy = #ci.overlap.saved0 sgp.dummy
execute if score #ci.overlap.had0 sgp.dummy matches 0 run scoreboard players reset #timed_events_active sgp.dummy
execute if score #ci.overlap.had1 sgp.dummy matches 1 run scoreboard players operation #second sgp.timer = #ci.overlap.saved1 sgp.dummy
execute if score #ci.overlap.had1 sgp.dummy matches 0 run scoreboard players reset #second sgp.timer
execute if score #ci.overlap.had2 sgp.dummy matches 1 run scoreboard players operation #bounty_active sgp.dummy = #ci.overlap.saved2 sgp.dummy
execute if score #ci.overlap.had2 sgp.dummy matches 0 run scoreboard players reset #bounty_active sgp.dummy
execute if score #ci.overlap.had3 sgp.dummy matches 1 run scoreboard players operation #bounty_remaining sgp.timer = #ci.overlap.saved3 sgp.dummy
execute if score #ci.overlap.had3 sgp.dummy matches 0 run scoreboard players reset #bounty_remaining sgp.timer
execute if score #ci.overlap.had4 sgp.dummy matches 1 run scoreboard players operation #confinement_active sgp.dummy = #ci.overlap.saved4 sgp.dummy
execute if score #ci.overlap.had4 sgp.dummy matches 0 run scoreboard players reset #confinement_active sgp.dummy
execute if score #ci.overlap.had5 sgp.dummy matches 1 run scoreboard players operation #confinement_remaining sgp.timer = #ci.overlap.saved5 sgp.dummy
execute if score #ci.overlap.had5 sgp.dummy matches 0 run scoreboard players reset #confinement_remaining sgp.timer
execute if score #ci.overlap.had6 sgp.dummy matches 1 run scoreboard players operation #frenzy_active sgp.dummy = #ci.overlap.saved6 sgp.dummy
execute if score #ci.overlap.had6 sgp.dummy matches 0 run scoreboard players reset #frenzy_active sgp.dummy
execute if score #ci.overlap.had7 sgp.dummy matches 1 run scoreboard players operation #frenzy_remaining sgp.timer = #ci.overlap.saved7 sgp.dummy
execute if score #ci.overlap.had7 sgp.dummy matches 0 run scoreboard players reset #frenzy_remaining sgp.timer
execute if score #ci.overlap.had8 sgp.dummy matches 1 run scoreboard players operation #smol_active sgp.dummy = #ci.overlap.saved8 sgp.dummy
execute if score #ci.overlap.had8 sgp.dummy matches 0 run scoreboard players reset #smol_active sgp.dummy
execute if score #ci.overlap.had9 sgp.dummy matches 1 run scoreboard players operation #smol_remaining sgp.timer = #ci.overlap.saved9 sgp.dummy
execute if score #ci.overlap.had9 sgp.dummy matches 0 run scoreboard players reset #smol_remaining sgp.timer
