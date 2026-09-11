#> sgp.kits:stats_collector/damage_received_buckets
# @dummy
# @environment sgp.ci:stats_collector
#
# Damage totals accumulate only inside the exact target/source/kit/cause bucket, including environmental damage.

scoreboard players set #damage_received_delta sgp.dummy 7
function sgp.kits:stats_collector/save_damage_received {id_target:910001,kit_id_target:2,id_source:910002,kit_id_source:4,cause_id:14}
scoreboard players set #damage_received_delta sgp.dummy 3
function sgp.kits:stats_collector/save_damage_received {id_target:910001,kit_id_target:2,id_source:910002,kit_id_source:4,cause_id:14}
scoreboard players set #damage_received_delta sgp.dummy 5
function sgp.kits:stats_collector/save_damage_received {id_target:910001,kit_id_target:2,id_source:910002,kit_id_source:4,cause_id:11}
scoreboard players set #damage_received_delta sgp.dummy 9
function sgp.kits:stats_collector/save_damage_received {id_target:910001,kit_id_target:2,id_source:-1,kit_id_source:-1,cause_id:18}

execute store result storage sgp.ci:stats damage.explosion int 1 run data get storage sgp.kits:stats kits_dict.910001.2.damage_received.910002.4.14
execute store result storage sgp.ci:stats damage.fire_tick int 1 run data get storage sgp.kits:stats kits_dict.910001.2.damage_received.910002.4.11
execute store result storage sgp.ci:stats damage.environment int 1 run data get storage sgp.kits:stats kits_dict.910001.2.damage_received."-1"."-1".18

assert data storage sgp.ci:stats damage{explosion:10,fire_tick:5,environment:9}
