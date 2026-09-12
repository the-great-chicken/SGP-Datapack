#> sgp.misc:on_death
# 
# Executed when a players dies: resets things,...

execute unless score @s sgp.synthetic_death matches 1.. \
    run function sgp.kits:stats_collector/collect_kill_infos
function sgp.kits:stats_collector/pause_pick_as_player
scoreboard players reset @s sgp.synthetic_death
function sgp.kits:cleanup_after_death

scoreboard players operation $link.to bs.in = @s bs.id
tag @s add sgp.diorama_death_cleanup
function sgp.misc:loop_as_entity/init {list_location:"sgp:data markers_lists.playable_map", command:"run function sgp.diorama:tick/update_mannequin/remove with entity @s data"}
tag @s remove sgp.diorama_death_cleanup

function sgp.mineurs:bounty/reward/reset
execute if entity @s[tag=sgp.wanted] run function sgp.mineurs:bounty/leave_wanted
