#> sgp.kits:stats_collector/save_kill_cause_stat
# `{id_killer, kit_id_killer, kit_id_victim, cause_id}`
#
# Add 1 to this killer/kit/victim-kit/final-damage-mechanism bucket.

$execute store result score #nbr_kills_by_cause sgp.dummy \
    run data get storage sgp.kits:stats kits_dict.$(id_killer).$(kit_id_killer).kills.$(kit_id_victim).$(cause_id)

scoreboard players add #nbr_kills_by_cause sgp.dummy 1

$execute store result storage sgp.kits:stats kits_dict.$(id_killer).$(kit_id_killer).kills.$(kit_id_victim).$(cause_id) int 1 \
    run scoreboard players get #nbr_kills_by_cause sgp.dummy
