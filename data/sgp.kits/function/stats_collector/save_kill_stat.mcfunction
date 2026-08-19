#> sgp.kits:stats_collector/save_kill_stat
# `{id_killer, kit_id_killer, kit_id_victim}`
#
# Add 1 to the number of kills of this player with this kit against the other specific kit

$execute store result score #nbr_kills sgp.dummy \
    run data get storage sgp.kits:stats kits_dict.$(id_killer).$(kit_id_killer).kills.$(kit_id_victim)

scoreboard players add #nbr_kills sgp.dummy 1

$execute store result storage sgp.kits:stats kits_dict.$(id_killer).$(kit_id_killer).kills.$(kit_id_victim) int 1 \
    run scoreboard players get #nbr_kills sgp.dummy