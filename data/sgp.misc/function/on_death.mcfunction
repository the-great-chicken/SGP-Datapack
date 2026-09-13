#> sgp.misc:on_death
# 
# Executed when a players dies: resets things,...

execute unless score @s sgp.synthetic_death matches 1.. \
    run function sgp.kits:stats_collector/collect_kill_infos
function sgp.kits:stats_collector/pause_pick_as_player
scoreboard players reset @s sgp.synthetic_death
function sgp.kits:cleanup_after_death

function sgp.diorama:cleanup_player

function sgp.mineurs:bounty/reward/reset
execute if entity @s[tag=sgp.wanted] run function sgp.mineurs:bounty/leave_wanted
