#> sgp.kits:stats_collector/kill_cause_buckets
# @dummy
# @environment sgp.ci:stats_collector
#
# Kill counts accumulate by killer kit, victim kit, and final damage mechanism without merging adjacent buckets.

function sgp.kits:stats_collector/save_kill_cause_stat {id_killer:910003,kit_id_killer:1,id_victim:910004,kit_id_victim:7,cause_id:1}
function sgp.kits:stats_collector/save_kill_cause_stat {id_killer:910003,kit_id_killer:1,id_victim:910004,kit_id_victim:7,cause_id:1}
function sgp.kits:stats_collector/save_kill_cause_stat {id_killer:910003,kit_id_killer:1,id_victim:910004,kit_id_victim:7,cause_id:100}
function sgp.kits:stats_collector/save_kill_cause_stat {id_killer:910003,kit_id_killer:1,id_victim:910004,kit_id_victim:8,cause_id:1}

execute store result storage sgp.ci:stats kills.melee int 1 run data get storage sgp.kits:stats kits_dict.910003.1.kills.910004.7.1
execute store result storage sgp.ci:stats kills.cleave int 1 run data get storage sgp.kits:stats kits_dict.910003.1.kills.910004.7.100
execute store result storage sgp.ci:stats kills.other_victim_kit int 1 run data get storage sgp.kits:stats kits_dict.910003.1.kills.910004.8.1

assert data storage sgp.ci:stats kills{melee:2,cleave:1,other_victim_kit:1}
