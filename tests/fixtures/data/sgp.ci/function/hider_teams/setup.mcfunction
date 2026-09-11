#> sgp.ci:hider_teams/setup
# Save Hide and Seek grouping/round state so the batch can mutate it without leaking into later tests.

function #bs.schedule:cancel_all {with:{id:"hide_and_seek"}}
schedule clear sgp.majeurs:hide_and_seek/_start
schedule clear sgp.majeurs:hide_and_seek/_stop
schedule clear sgp.majeurs:hide_and_seek/timer/hider
schedule clear sgp.majeurs:hide_and_seek/timer/seeker
schedule clear sgp.majeurs:hide_and_seek/timer/glow
schedule clear sgp.majeurs:hide_and_seek/timer/glow_announce

function sgp.ci:players/cleanup
execute store result storage sgp.ci:hider_teams previous_selector int 1 run scoreboard players get #selector sgp.link_teams
execute store result storage sgp.ci:hider_teams previous_hider_timer int 1 run scoreboard players get #hider sgp.timer
execute store result storage sgp.ci:hider_teams previous_seeker_timer int 1 run scoreboard players get #seeker sgp.timer
execute store result storage sgp.ci:hider_teams previous_rounds int 1 run scoreboard players get #rounds sgp.dummy
execute store result storage sgp.ci:hider_teams previous_max_rounds int 1 run scoreboard players get #hide_and_seek_max_rounds sgp.dummy
execute store result storage sgp.ci:hider_teams previous_seconds int 1 run scoreboard players get #second sgp.timer
