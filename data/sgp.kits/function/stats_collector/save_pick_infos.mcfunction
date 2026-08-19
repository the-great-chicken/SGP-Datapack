#> sgp.kits:stats_collector/save_pick_infos
# `{id_victim, kit_id_victim}`

$execute unless data storage sgp.kits:stats kits_dict.$(id_victim).$(kit_id_victim).pick.last_pick \
    run return fail

# Computed life elapsed time with the kit, and add it to the total time
$execute store result score #last_pick_time sgp.dummy \
    run data get storage sgp.kits:stats kits_dict.$(id_victim).$(kit_id_victim).pick.last_pick

$execute store result score #total_pick_time sgp.dummy \
    run data get storage sgp.kits:stats kits_dict.$(id_victim).$(kit_id_victim).pick.total_time

execute store result score #death_time sgp.dummy \
    run time query gametime

execute store result score #pick_elapsed_time sgp.dummy \
    run scoreboard players operation #death_time sgp.dummy -= #last_pick_time sgp.dummy

$execute store result storage sgp.kits:stats kits_dict.$(id_victim).$(kit_id_victim).pick.total_time int 1 \
    run scoreboard players operation #total_pick_time sgp.dummy += #pick_elapsed_time sgp.dummy


$data remove storage sgp.kits:stats kits_dict.$(id_victim).$(kit_id_victim).pick.last_pick

# Increment number of picks (lives played with the kit)
$execute store result score #nbr_picks sgp.dummy \
    run data get storage sgp.kits:stats kits_dict.$(id_victim).$(kit_id_victim).pick.nbr_picks

scoreboard players add #nbr_picks sgp.dummy 1

$execute store result storage sgp.kits:stats kits_dict.$(id_victim).$(kit_id_victim).pick.nbr_picks int 1 \
    run scoreboard players get #nbr_picks sgp.dummy