#> sgp.kits:stats_collector/save_damage_received
# `{id_target, kit_id_target, id_source, kit_id_source, cause_id}`
#
# Add the current event's damage_taken delta to this target/source/cause bucket.

scoreboard players set #damage_received_total sgp.dummy 0

$execute store result score #damage_received_total sgp.dummy \
    run data get storage sgp.kits:stats kits_dict.$(id_target).$(kit_id_target).damage_received.$(id_source).$(kit_id_source).$(cause_id)

scoreboard players operation #damage_received_total sgp.dummy += #damage_received_delta sgp.dummy

$execute store result storage sgp.kits:stats kits_dict.$(id_target).$(kit_id_target).damage_received.$(id_source).$(kit_id_source).$(cause_id) int 1 \
    run scoreboard players get #damage_received_total sgp.dummy
