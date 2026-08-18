#> sgp.kits:stats_collector/save_ability_use

$execute store result score #nbr_ability_use sgp.dummy \
    run data get storage sgp.kits:stats kits_dict.$(id).$(kit_id).ability_use

scoreboard players add #nbr_ability_use sgp.dummy 1

$execute store result storage sgp.kits:stats kits_dict.$(id).$(kit_id).ability_use int 1 \
    run scoreboard players get #nbr_ability_use sgp.dummy