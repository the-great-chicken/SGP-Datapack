#> sgp.mineurs:common/timed_event/tick
#
# Advance each active minor event from sgp.misc:second's shared clock.

execute if score #bounty_active sgp.dummy matches 1 run scoreboard players remove #bounty_remaining sgp.timer 1
execute if score #confinement_active sgp.dummy matches 1 run scoreboard players remove #confinement_remaining sgp.timer 1
execute if score #frenzy_active sgp.dummy matches 1 run scoreboard players remove #frenzy_remaining sgp.timer 1
execute if score #smol_active sgp.dummy matches 1 run scoreboard players remove #smol_remaining sgp.timer 1
