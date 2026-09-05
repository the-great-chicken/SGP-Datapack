#> sgp.ci:minor_events/reset_timer
#
# Establish an idle shared clock for synchronous CI scenarios.

scoreboard players set #timed_events_active sgp.dummy 0
scoreboard players set #bounty_active sgp.dummy 0
scoreboard players set #confinement_active sgp.dummy 0
scoreboard players set #frenzy_active sgp.dummy 0
scoreboard players set #smol_active sgp.dummy 0
scoreboard players set #second sgp.timer 0
schedule clear sgp.misc:second
