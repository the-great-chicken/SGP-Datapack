#> sgp.kits:abilities/illusions/record_destroyed

function sgp.kits:stats_collector/ability/mark_success {kit_id:8,ability_path:"illusions"}

execute if score #nbr_illusions_left sgp.dummy matches 2 \
    run function sgp.kits:stats_collector/ability/increment {kit_id:8,ability_path:"illusions",metric:"destroyed_decoys",amount:1}

execute if score #nbr_illusions_left sgp.dummy matches 1 \
    run function sgp.kits:stats_collector/ability/increment {kit_id:8,ability_path:"illusions",metric:"destroyed_decoys",amount:2}

execute if score #nbr_illusions_left sgp.dummy matches 0 \
    run function sgp.kits:stats_collector/ability/increment {kit_id:8,ability_path:"illusions",metric:"destroyed_decoys",amount:3}
