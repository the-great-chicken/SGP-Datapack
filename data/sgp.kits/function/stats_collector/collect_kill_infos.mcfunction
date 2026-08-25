#> sgp.kits:stats_collector/collect_kill_infos
#
# Find out who killed the player, and what kit they were both wearing.

# Always clear the transient cause, even when this death belongs to a major
# event or the storage schema is unsupported.
execute store result score #stats_can_collect sgp.dummy \
    run function sgp.kits:stats_collector/can_collect
execute unless score #stats_can_collect sgp.dummy matches 1 \
    run scoreboard players set @s sgp.death_cause 0
execute unless score #stats_can_collect sgp.dummy matches 1 run return 0

execute store result storage sgp:macro stats.current_kill_info.kit_id_victim int 1 \
    run scoreboard players get @s sgp.kit_id

execute store result storage sgp:macro stats.current_kill_info.id_victim int 1 \
    run scoreboard players get @s sgp.id

data modify storage sgp:macro stats.current_kill_info.cause_id set value 0
execute store result storage sgp:macro stats.current_kill_info.cause_id int 1 \
    run scoreboard players get @s sgp.death_cause


data modify storage sgp:macro stats.current_kill_info.id_killer set value -1
data modify storage sgp:macro stats.current_kill_info.kit_id_killer set value -1


execute on attacker \
    store result storage sgp:macro stats.current_kill_info.kit_id_killer int 1 \
        run scoreboard players get @s sgp.kit_id

execute on attacker \
    store result storage sgp:macro stats.current_kill_info.id_killer int 1 \
        run scoreboard players get @s sgp.id


function sgp.kits:stats_collector/save_kill_cause_stat with storage sgp:macro stats.current_kill_info
function sgp.kits:stats_collector/save_pick_infos with storage sgp:macro stats.current_kill_info

# Never let a non-damage death inherit the previous life's last damage mechanism.
scoreboard players set @s sgp.death_cause 0
