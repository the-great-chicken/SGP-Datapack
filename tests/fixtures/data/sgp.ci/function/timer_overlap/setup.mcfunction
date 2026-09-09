#> sgp.ci:timer_overlap/setup

function sgp.ci:players/cleanup
schedule clear sgp.misc:second
execute store success score #ci.overlap.had0 sgp.dummy store result score #ci.overlap.saved0 sgp.dummy run scoreboard players get #timed_events_active sgp.dummy
scoreboard players set #timed_events_active sgp.dummy 0
execute store success score #ci.overlap.had1 sgp.dummy store result score #ci.overlap.saved1 sgp.dummy run scoreboard players get #second sgp.timer
scoreboard players set #second sgp.timer 0
execute store success score #ci.overlap.had2 sgp.dummy store result score #ci.overlap.saved2 sgp.dummy run scoreboard players get #bounty_active sgp.dummy
scoreboard players set #bounty_active sgp.dummy 0
execute store success score #ci.overlap.had3 sgp.dummy store result score #ci.overlap.saved3 sgp.dummy run scoreboard players get #bounty_remaining sgp.timer
scoreboard players set #bounty_remaining sgp.timer 0
execute store success score #ci.overlap.had4 sgp.dummy store result score #ci.overlap.saved4 sgp.dummy run scoreboard players get #confinement_active sgp.dummy
scoreboard players set #confinement_active sgp.dummy 0
execute store success score #ci.overlap.had5 sgp.dummy store result score #ci.overlap.saved5 sgp.dummy run scoreboard players get #confinement_remaining sgp.timer
scoreboard players set #confinement_remaining sgp.timer 0
execute store success score #ci.overlap.had6 sgp.dummy store result score #ci.overlap.saved6 sgp.dummy run scoreboard players get #frenzy_active sgp.dummy
scoreboard players set #frenzy_active sgp.dummy 0
execute store success score #ci.overlap.had7 sgp.dummy store result score #ci.overlap.saved7 sgp.dummy run scoreboard players get #frenzy_remaining sgp.timer
scoreboard players set #frenzy_remaining sgp.timer 0
execute store success score #ci.overlap.had8 sgp.dummy store result score #ci.overlap.saved8 sgp.dummy run scoreboard players get #smol_active sgp.dummy
scoreboard players set #smol_active sgp.dummy 0
execute store success score #ci.overlap.had9 sgp.dummy store result score #ci.overlap.saved9 sgp.dummy run scoreboard players get #smol_remaining sgp.timer
scoreboard players set #smol_remaining sgp.timer 0
