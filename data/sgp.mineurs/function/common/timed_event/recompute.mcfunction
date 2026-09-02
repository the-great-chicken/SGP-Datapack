#> sgp.mineurs:common/timed_event/recompute
#
# Display the shortest remaining time among the active timed minor events.

scoreboard players set #timed_event_next sgp.timer 2147483647

execute if score #bounty_active sgp.dummy matches 1 \
    if score #bounty_remaining sgp.timer < #timed_event_next sgp.timer \
        run scoreboard players operation #timed_event_next sgp.timer = #bounty_remaining sgp.timer
execute if score #confinement_active sgp.dummy matches 1 \
    if score #confinement_remaining sgp.timer < #timed_event_next sgp.timer \
        run scoreboard players operation #timed_event_next sgp.timer = #confinement_remaining sgp.timer
execute if score #frenzy_active sgp.dummy matches 1 \
    if score #frenzy_remaining sgp.timer < #timed_event_next sgp.timer \
        run scoreboard players operation #timed_event_next sgp.timer = #frenzy_remaining sgp.timer
execute if score #smol_active sgp.dummy matches 1 \
    if score #smol_remaining sgp.timer < #timed_event_next sgp.timer \
        run scoreboard players operation #timed_event_next sgp.timer = #smol_remaining sgp.timer

scoreboard players operation #second sgp.timer = #timed_event_next sgp.timer

execute store result storage sgp:data mineurs.timed_event.display.duration int 1 \
    run scoreboard players get #timed_event_next sgp.timer
function sgp.mineurs:common/timed_event/display with storage sgp:data mineurs.timed_event.display
